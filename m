Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261946AbVGMB1x@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261946AbVGMB1x (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 12 Jul 2005 21:27:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262189AbVGMB1x
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 12 Jul 2005 21:27:53 -0400
Received: from out2.smtp.messagingengine.com ([66.111.4.26]:6582 "EHLO
	out2.smtp.messagingengine.com") by vger.kernel.org with ESMTP
	id S261946AbVGMB1s (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 12 Jul 2005 21:27:48 -0400
X-Sasl-enc: 0aBpaHYSjh8o3p+scQWUZmbr72GIiuLDyWmbS64zGBAA 1121218050
Message-ID: <03e601c5874a$12613fa0$7c00a8c0@ROBMHP>
From: "Rob Mueller" <robm@fastmail.fm>
To: "Chris Mason" <mason@suse.com>
Cc: <akpm@osdl.org>, "Lars Roland" <lroland@gmail.com>,
       "Bron Gondwana" <brong@fastmail.fm>, <linux-kernel@vger.kernel.org>,
       "Vladimir Saveliev" <vs@namesys.com>,
       "Jeremy Howard" <jhoward@fastmail.fm>
References: <01dd01c586c3$cdd525d0$7c00a8c0@ROBMHP> <200507122042.11397.mason@suse.com> <03b601c58744$ee69e390$7c00a8c0@ROBMHP> <200507122103.10159.mason@suse.com>
Subject: Re: 2.6.12.2 dies after 24 hours
Date: Wed, 13 Jul 2005 11:27:39 +1000
MIME-Version: 1.0
Content-Type: text/plain;
	format=flowed;
	charset="iso-8859-1";
	reply-type=original
Content-Transfer-Encoding: 7bit
X-Priority: 3
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook Express 6.00.2900.2527
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2900.2527
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


> Sorry for the confusion, you're hitting the other mmap_sem -> transaction 
> lock
> problem.  This one should be solvable with an iget so we make sure not to 
> do
> the final unlink until after the mmap sem is dropped.
>
> Lets see what I can do...

Oh dang.

I thought this last crash after upgrading to 2.6.12.2 was due to the IRQ 
BALANCE issue Lars suggested, but you're saying that it's actually a whole 
different bug, though similar to the previous "prepare_write ... 
copy_from_user ... commit_write" lock problem?

Is this something new between 2.6.4-mm2 and 2.6.12.2? Or would it have 
always been present, just for some reason we're hitting it in 2.6.12 now but 
weren't hitting it in 2.6.4?

I feel we're moving backwards... :(

Rob

