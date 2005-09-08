Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932640AbVIHPLG@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932640AbVIHPLG (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 8 Sep 2005 11:11:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932655AbVIHPLG
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 8 Sep 2005 11:11:06 -0400
Received: from mail.collax.com ([213.164.67.137]:17637 "EHLO
	kaber.coreworks.de") by vger.kernel.org with ESMTP id S932649AbVIHPLE
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 8 Sep 2005 11:11:04 -0400
Message-ID: <43205486.6090901@trash.net>
Date: Thu, 08 Sep 2005 17:11:02 +0200
From: Patrick McHardy <kaber@trash.net>
User-Agent: Mozilla/5.0 (X11; U; Linux x86_64; en-US; rv:1.7.10) Gecko/20050803 Debian/1.7.10-1
X-Accept-Language: en
MIME-Version: 1.0
To: Jan Beulich <JBeulich@novell.com>
CC: linux-kernel@vger.kernel.org
Subject: Re: [PATCH] rmmod notifier chain
References: <43206EFE0200007800024451@emea1-mh.id2.novell.com>
In-Reply-To: <43206EFE0200007800024451@emea1-mh.id2.novell.com>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Jan Beulich wrote:
> Debugging and maintenance support code occasionally needs to know not
> only of module insertions, but also modulke removals. This adds a
> notifier
> chain for this purpose.
> 
>
> diff -Npru 2.6.13/kernel/module.c
> 2.6.13-rmmod-notifier/kernel/module.c
> --- 2.6.13/kernel/module.c	2005-08-29 01:41:01.000000000 +0200
> +++ 2.6.13-rmmod-notifier/kernel/module.c	2005-09-02
> 09:46:24.000000000 +0200
> @@ -62,6 +62,8 @@ static LIST_HEAD(modules);
>  
>  static DECLARE_MUTEX(notify_mutex);
>  static struct notifier_block * module_notify_list;
> +static DECLARE_MUTEX(rmmod_notify_mutex);

Why is this mutex needed? The notifier functions already take care of
locking.
