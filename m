Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262368AbUCRC4C (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 17 Mar 2004 21:56:02 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262370AbUCRC4C
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 17 Mar 2004 21:56:02 -0500
Received: from mail1.webmaster.com ([216.152.64.168]:43794 "EHLO
	mail1.webmaster.com") by vger.kernel.org with ESMTP id S262368AbUCRC4A
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 17 Mar 2004 21:56:00 -0500
From: "David Schwartz" <davids@webmaster.com>
To: "Timothy Miller" <miller@techsource.com>
Cc: "Linux Kernel Mailing List" <linux-kernel@vger.kernel.org>
Subject: RE: Scheduler: Process priority fed back to parent?
Date: Wed, 17 Mar 2004 18:55:38 -0800
Message-ID: <MDEHLPKNGKAHNMBLJOLKKEJBLCAA.davids@webmaster.com>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
X-Priority: 3 (Normal)
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook IMO, Build 9.0.6604 (9.0.2911.0)
Importance: Normal
In-Reply-To: <200403161323.26043.eric@cisu.net>
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2900.2055
X-Authenticated-Sender: joelkatz@webmaster.com
X-Spam-Processed: mail1.webmaster.com, Wed, 17 Mar 2004 18:34:10 -0800
	(not processed: message from valid local sender)
X-MDRemoteIP: 206.171.168.138
X-Return-Path: davids@webmaster.com
X-MDaemon-Deliver-To: linux-kernel@vger.kernel.org
Reply-To: davids@webmaster.com
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


> > I'm not familiar with that aspect of Windows, but... sure.  :)
>
> All i know is it does some sort of prefetch/caching of
> information to make
> user processes load faster.

	My recollection is that Windows, rather than letting a program and the
libraries it rely upon just fault in, keeps track of what pages from what
files it needed within its first few seconds of execution on a previous run
and pre-loads/maps them.

	If the startup access pattern of the program is quite random over multiple
files, this can save quite a bit of time because they can be loaded in in a
logical/sequential fashion. Otherwise, the operating system must load them
in in the order they fault because it has no idea what page will be needed
next as each fault blocks the process before it is known where the next
fault will be.

	Theoretically, one might expect Linux to benefit as well from such a
prefetch/preload mechanism. It would be interesting to code one as a quick
hack and see what kind of difference it makes. My guess is that Linux is
called upon to start behemoth programs much less often than Windows is.

	I also expect that the access patterns on Linux programs tends to be a bit
more linear than on Windows. If prefetching eliminates a large percentage of
the blocking faults, then there would be much less gain.

	On Windows 98, though, it made an enormous difference. The first add-on
programs to provide this type of optimization were amazing, especially when
you look at launch times for programs like Netscape that are large and span
muliple files.

	DS


