Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261393AbTDLWRQ (for <rfc822;willy@w.ods.org>); Sat, 12 Apr 2003 18:17:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261821AbTDLWRQ (for <rfc822;linux-kernel-outgoing>);
	Sat, 12 Apr 2003 18:17:16 -0400
Received: from ms-smtp-02.tampabay.rr.com ([65.32.1.39]:61076 "EHLO
	ms-smtp-02.tampabay.rr.com") by vger.kernel.org with ESMTP
	id S261393AbTDLWRO (for <rfc822;linux-kernel@vger.kernel.org>); Sat, 12 Apr 2003 18:17:14 -0400
Message-ID: <000d01c30143$ccf54ad0$6801a8c0@epimetheus>
From: "Timothy Miller" <tmiller10@cfl.rr.com>
To: <linux-kernel@vger.kernel.org>
Subject: Page compression in lieu of swap?
Date: Sat, 12 Apr 2003 18:35:19 -0400
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
X-Priority: 3
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook Express 6.00.2720.3000
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2600.0000
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I did some searching of the kernel archives and the only things related to
the forthcoming idea had to do with compressing pages when writing to swap
and doing compressed disks.  Here's a different idea...

Inspired by my recent experiments in compressing kernel messages, I started
to wonder what else might benefit from compression, and the following idea
occurred to me:

Given the hideous amount of time required to access a disk, especially when
something else wants to access it, could there be a benefit to "swapping"
pages by compressing them to somewhere else in memory?  If we could achieve,
even say, 30% compression on pages, on average, then we could free up RAM
without having to do any I/O.  This would be the first line of defense
against a low-memory situation, finally resorting to actual disk access when
that becomes unworkable or for pages which can't be compressed enough for it
to help (which has a penalty worse than just writing to disk).  And
furthermore, if we were to swap first memory containing compressed pages, we
can reduce the total amount of I/O for swapping.

This would, of course, suck a lot of CPU, and in the case of a server
running many services where the CPU usage is pegged even when there's a lot
of swapping, it would be better to just swap as normal.  But in any case
where swapping is causing an increase in idle time, I would expect a
considerable benefit from being able to free up pages by making LRU pages
simply take up less space in RAM when they're not being used.

Comments?



