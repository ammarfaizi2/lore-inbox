Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S318775AbSHLRtF>; Mon, 12 Aug 2002 13:49:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S318776AbSHLRtF>; Mon, 12 Aug 2002 13:49:05 -0400
Received: from petasus.ch.intel.com ([143.182.124.5]:58025 "EHLO
	petasus.ch.intel.com") by vger.kernel.org with ESMTP
	id <S318775AbSHLRtD>; Mon, 12 Aug 2002 13:49:03 -0400
Message-ID: <D9223EB959A5D511A98F00508B68C20C0BFB80E7@orsmsx108.jf.intel.com>
From: "Woodruff, Robert J" <woody@co.intel.com>
To: "'daniel sheltraw'" <l5gibson@hotmail.com>, linux-kernel@vger.kernel.org
Subject: RE: kernel to user-space communication
Date: Mon, 12 Aug 2002 10:52:45 -0700
MIME-Version: 1.0
X-Mailer: Internet Mail Service (5.5.2653.19)
Content-Type: text/plain;
	charset="iso-8859-1"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

There are a couple of techniques one can use.
First, you can set up a piece of memory that is shared
between the kernel and the user process and when the 
interrupt occurs, set a flag in memory. The user process
can poll the memory to see if an interrupt happened.

Coarse, you might not want to waist CPU polling all day,
so you could use signals (like SIGUSR1) to block, and have the 
kernel send the signal when the interrupt occurs. Only problem
with signals is that they are not stackable.

Another technique is to implement the concept of a wait object,
you write a simple driver that manages these. The user process
does an ioctl to the wait object driver when it wants to wait for 
an interrupt. The ioctl sleeps if the interrupt has not occurred.
The kernel then calls wakeup when the interrupt 
happens and the ioctl completes. 
We implemented a mechanism like this for InfiniBand,
which allows user level I/O to the hardware and we needed a way to
signal I/O completions (interrupts) to the user process. 
If you are interested
in an example, take a look at the early reference InfiniBand code
at http://sourceforge.net/projects/infiniband.

-----Original Message-----
From: daniel sheltraw [mailto:l5gibson@hotmail.com]
Sent: Monday, August 12, 2002 8:40 AM
To: linux-kernel@vger.kernel.org
Subject: kernel to user-space communication


Hello Kernel

Is there a way to comminicate to a user-space program that an
interrupt has occurred in a kernel module?

Thanks,
Daniel Sheltraw


_________________________________________________________________
MSN Photos is the easiest way to share and print your photos: 
http://photos.msn.com/support/worldwide.aspx

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
Please read the FAQ at  http://www.tux.org/lkml/
