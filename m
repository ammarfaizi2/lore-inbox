Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751066AbWCADt1@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751066AbWCADt1 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 28 Feb 2006 22:49:27 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751100AbWCADt1
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 28 Feb 2006 22:49:27 -0500
Received: from mail1.webmaster.com ([216.152.64.168]:16132 "EHLO
	mail1.webmaster.com") by vger.kernel.org with ESMTP
	id S1751066AbWCADt1 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 28 Feb 2006 22:49:27 -0500
From: "David Schwartz" <davids@webmaster.com>
To: "Linux Kernel Mailing List" <linux-kernel@vger.kernel.org>
Subject: RE: Thread safety for epoll/libaio
Date: Tue, 28 Feb 2006 19:48:46 -0800
Message-ID: <MDEHLPKNGKAHNMBLJOLKMEAIKHAB.davids@webmaster.com>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 7bit
X-Priority: 3 (Normal)
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook IMO, Build 9.0.6604 (9.0.2911.0)
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2900.2670
In-Reply-To: <598a055d0602281236m7eac9c09oc60af9ce28e7e4bf@mail.gmail.com>
Importance: Normal
X-Authenticated-Sender: joelkatz@webmaster.com
X-Spam-Processed: mail1.webmaster.com, Tue, 28 Feb 2006 19:45:15 -0800
	(not processed: message from trusted or authenticated source)
X-MDRemoteIP: 206.171.168.138
X-Return-Path: davids@webmaster.com
X-MDaemon-Deliver-To: linux-kernel@vger.kernel.org
Reply-To: davids@webmaster.com
X-MDAV-Processed: mail1.webmaster.com, Tue, 28 Feb 2006 19:45:16 -0800
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


> I apologize if I should not post this on LKML, but there seems to be
> some lack of documentation for using epoll/AIO with threads.  Are
> these interfaces thread-safe?  Can I use them safely in the following
> way:

	They are thread safe.

> Thread A:  while(1) { io_getevents();  ... }
> // wait forever until an event occurs, then handles the event and loop
>
> Thread B:  while(1) { epoll_wait();  ... }
> // same as thread A
>
> Thread C:  ... io_submit(); ...
>
> Thread D:  ... epoll_ctl(); ....
>
> Suppose thread B calls epoll_wait and blocks before thread D calls
> epoll_ctl.  Is it safe to do so? Will thread B be notified for the
> event submitted by thread D?  Thread A and C pose the same question
> for AIO.

	Using the interfaces this way is pretty much their entire point. They'd be
almost useless if you couldn't use them in this way.

	DS


