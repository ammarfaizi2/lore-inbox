Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129650AbRBTK77>; Tue, 20 Feb 2001 05:59:59 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129790AbRBTK7t>; Tue, 20 Feb 2001 05:59:49 -0500
Received: from port-212.169.150.196.flat4all.de ([212.169.150.196]:28405 "EHLO
	localhost.localdomain") by vger.kernel.org with ESMTP
	id <S129650AbRBTK7m>; Tue, 20 Feb 2001 05:59:42 -0500
Message-ID: <3A924D8A.FBEAD695@cluster-labs.de>
Date: Tue, 20 Feb 2001 11:57:14 +0100
From: Norbert Roos <norbert.roos@cluster-labs.de>
X-Mailer: Mozilla 4.76 [en] (X11; U; Linux 2.2.17-7 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: Probs with PCI bus master DMA to user space
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Hello!

I think the following is general problem, but i haven't found any
information about that yet..

I'm currently writing a driver which wants to transfer data between main
memory and a PCI device. The data buffers are allocated by the program
which uses the driver and therefore lie in the user space. Pointers to
the data buffers are as usual passed to the driver with read() and
write() calls. The driver then initializes a DMA transfer where the PCI
device is bus master.

The driver of course has to split the transfer into several smaller
ones, because the memory pages which contain the data buffers could be
spread across the complete memory.

Before i can actually start the transfer, i have to make sure that the
pages are not swapped and remain locked during the transfer.

The problem I have is: Is there an efficient way to lock the pages which
are accessed by the DMA?

The program using the driver can't use mlock(), because the program does
not know about DMA transfers somewhere below the driver.

The driver should not use mlock() either, because i think that the
execution of mlock() takes about as long as copying the data directly
with copy_from/to_user(). Additionally, I could not unlock() the memory
after the transfer, because the main program might have locked the same
memory area and wants the memory to remain locked.

So what can i do then?

bye
