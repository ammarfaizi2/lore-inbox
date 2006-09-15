Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751674AbWIOQ3p@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751674AbWIOQ3p (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 15 Sep 2006 12:29:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751678AbWIOQ3p
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 15 Sep 2006 12:29:45 -0400
Received: from smtp.osdl.org ([65.172.181.4]:40623 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S1751674AbWIOQ3o (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 15 Sep 2006 12:29:44 -0400
Date: Fri, 15 Sep 2006 09:26:00 -0700
From: Andrew Morton <akpm@osdl.org>
To: Martin Schwidefsky <schwidefsky@de.ibm.com>
Cc: torvalds@osdl.org, gregkh@suse.de, bunk@stusta.de,
       linux-kernel@vger.kernel.org
Subject: Re: [patch] Race condition in usermodehelper.
Message-Id: <20060915092600.3046c511.akpm@osdl.org>
In-Reply-To: <20060915104654.GA31548@skybase>
References: <20060915104654.GA31548@skybase>
X-Mailer: Sylpheed version 2.2.7 (GTK+ 2.8.17; x86_64-unknown-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 15 Sep 2006 12:46:54 +0200
Martin Schwidefsky <schwidefsky@de.ibm.com> wrote:

> From: Martin Schwidefsky <schwidefsky@de.ibm.com>
> 
> [patch] Race condition in usermodehelper.
> 
> There is a race between call_usermodehelper_keys, __call_usermodehelper
> and wait_for_helper. It should only happen if preemption is enabled or
> on a virtualized system.
> 
> If the cpu is preempted or put to sleep by the hypervisor in
> __call_usermodehelper between the creation of the wait_for_helper
> thread and the second check on sub_info->wait, the whole execution
> of wait_for_helper including the complete call and the continuation
> after the wait_for_completion in call_usermodehelper_keys can have
> happened before __call_usermodehelper checks sub_info->wait for the
> second time. Since sub_info can already have been clobbered,
> sub_info->wait could be zero and complete is called a second time
> with an invalid argument. This has happened on s390. It took me only
> three days to find out ..

You mean three days work?

If so, I owe you a big apology, because an identical patch has been in -mm
for over a month.  I guess I didn't appreciate its significance.

Shall expedite.

