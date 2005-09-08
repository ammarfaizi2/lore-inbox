Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932676AbVIHPPr@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932676AbVIHPPr (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 8 Sep 2005 11:15:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932680AbVIHPPr
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 8 Sep 2005 11:15:47 -0400
Received: from public.id2-vpn.continvity.gns.novell.com ([195.33.99.129]:45155
	"EHLO emea1-mh.id2.novell.com") by vger.kernel.org with ESMTP
	id S932676AbVIHPPp (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 8 Sep 2005 11:15:45 -0400
Message-Id: <432071FF0200007800024479@emea1-mh.id2.novell.com>
X-Mailer: Novell GroupWise Internet Agent 7.0 
Date: Thu, 08 Sep 2005 17:16:47 +0200
From: "Jan Beulich" <JBeulich@novell.com>
To: "Patrick McHardy" <kaber@trash.net>
Cc: <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] rmmod notifier chain
References: <43206EFE0200007800024451@emea1-mh.id2.novell.com> <43205486.6090901@trash.net>
In-Reply-To: <43205486.6090901@trash.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>> Debugging and maintenance support code occasionally needs to know
not
>> only of module insertions, but also modulke removals. This adds a
>> notifier
>> chain for this purpose.
>> 
>>
>> diff -Npru 2.6.13/kernel/module.c
>> 2.6.13-rmmod-notifier/kernel/module.c
>> --- 2.6.13/kernel/module.c	2005-08-29 01:41:01.000000000 +0200
>> +++ 2.6.13-rmmod-notifier/kernel/module.c	2005-09-02
>> 09:46:24.000000000 +0200
>> @@ -62,6 +62,8 @@ static LIST_HEAD(modules);
>>  
>>  static DECLARE_MUTEX(notify_mutex);
>>  static struct notifier_block * module_notify_list;
>> +static DECLARE_MUTEX(rmmod_notify_mutex);
>
>Why is this mutex needed? The notifier functions already take care of
>locking.

As you can see in the fragment, the same is being done for the insert
notifier chain, and I simply copied and modified that code to have the
lowest possible risk. If that's inappropriate, then the insert notifier
should probably be fixed first...

Jan
