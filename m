Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266250AbUGTVT6@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266250AbUGTVT6 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 20 Jul 2004 17:19:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266281AbUGTVT5
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 20 Jul 2004 17:19:57 -0400
Received: from out2.smtp.messagingengine.com ([66.111.4.26]:61876 "EHLO
	out2.smtp.messagingengine.com") by vger.kernel.org with ESMTP
	id S266250AbUGTVT4 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 20 Jul 2004 17:19:56 -0400
X-Sasl-enc: I8lBb3peS5424aH7az40zw 1090358394
Message-ID: <021501c46e9f$524d9c90$9aafc742@ROBMHP>
From: "Rob Mueller" <robm@fastmail.fm>
To: "Chris Mason" <mason@suse.com>, <wli@holomorphy.com>, <akpm@osdl.org>
Cc: <linux-kernel@vger.kernel.org>
References: <00f601c46539$0bdf47a0$e6afc742@ROBMHP> <1089377936.3956.148.camel@watt.suse.com> <009e01c46849$f2e85430$9aafc742@ROBMHP> <1090353111.23350.8.camel@watt.suse.com>
Subject: Re: Processes stuck in unkillable D state (now seen in 2.6.7-mm6)
Date: Tue, 20 Jul 2004 14:19:56 -0700
MIME-Version: 1.0
Content-Type: text/plain;
	format=flowed;
	charset="iso-8859-1";
	reply-type=original
Content-Transfer-Encoding: 7bit
X-Priority: 3
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook Express 6.00.2900.2149
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2900.2149
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


> Ugh, so the call path here is:
>
> reiserfs_file_write -> start a transaction
> copy_from_user -> fault in the page
> page fault handler -> lock page
>
> This means we're trying to lock a page with a running transaction, and
> that's not allowed, since some other process on the box most likely has
> that page locked and is trying to start a transaction.
>
> That makes for 3 different deadlocks in this exact same call path
> (dirty_inode, lock_page and kmap), and my patch for it has major
> problems.  So, I'll talk things over with everyone during OLS and try to
> work out a proper fix.
>
> Sorry Rob, this one is non-trivial.

Thanks for looking at it Chris. At least it seems that there is now a 
diagnosis of what's happening, which can be half the battle!

I'm surprised that this seems so rare, and that no-one else has reported it 
as a significant problem before. Do you think there's anything in particular 
about our kernel config that would be causing this to happen?

Rob

