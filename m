Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129143AbRAZKgr>; Fri, 26 Jan 2001 05:36:47 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129184AbRAZKgh>; Fri, 26 Jan 2001 05:36:37 -0500
Received: from mailout2-0.nyroc.rr.com ([24.92.226.121]:54859 "EHLO
	mailout2-0.nyroc.rr.com") by vger.kernel.org with ESMTP
	id <S129143AbRAZKg1>; Fri, 26 Jan 2001 05:36:27 -0500
Message-ID: <027801c08784$48a04630$0701a8c0@morph>
From: "Dan Maas" <dmaas@dcine.com>
To: "Dima Brodsky" <dima@cs.ubc.ca>
Cc: <linux-kernel@vger.kernel.org>
In-Reply-To: <fa.h16635v.l0uu8m@ifi.uio.no>
Subject: Re: mapping physical memory
Date: Fri, 26 Jan 2001 05:39:38 -0500
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
X-Priority: 3
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook Express 5.50.4133.2400
X-MimeOLE: Produced By Microsoft MimeOLE V5.50.4133.2400
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> I need to be able to obtain and pin approximately 8 MB of
> contiguous physical memory in user space.  How would I go
> about doing that under Linux if it is at all possible?

The only way to allocate that much *physically* contiguous memory is by
writing a driver that grabs it at boot-time (I think the "bootmem" API is
used for this). This is an extreme measure and should rarely be necessary,
except in special cases such as primitive PCI cards that lack support for
scatter/gather DMA.

You can easily implement a mmap() interface to give user-space programs
access to the memory; there are plenty of examples of how to do this in
various character device drivers.
(well OK, if all you need is a one-off hack, you can use the method
developed by the Utah GLX people -- tell the kernel that you have 8MB *less*
RAM than is actually present using a "mem=" directive at boot, then grab
that last piece of memory by mmap'ing /dev/mem -- see
http://utah-glx.sourceforge.net/memory-usage.html)



Dan

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
