Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129325AbQKULbs>; Tue, 21 Nov 2000 06:31:48 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129437AbQKULbi>; Tue, 21 Nov 2000 06:31:38 -0500
Received: from cerebus-ext.cygnus.co.uk ([194.130.39.252]:13559 "EHLO
	passion.cygnus") by vger.kernel.org with ESMTP id <S129325AbQKULbc>;
	Tue, 21 Nov 2000 06:31:32 -0500
X-Mailer: exmh version 2.2 06/23/2000 with nmh-1.0.4
From: David Woodhouse <dwmw2@infradead.org>
X-Accept-Language: en_GB
In-Reply-To: <Pine.LNX.4.10.10011210112530.26514-100000@master.linux-ide.org> 
In-Reply-To: <Pine.LNX.4.10.10011210112530.26514-100000@master.linux-ide.org> 
To: Andre Hedrick <andre@linux-ide.org>
Cc: Hakan Lennestal <hakanl@cdt.luth.se>, linux-kernel@vger.kernel.org
Subject: Re: 2.4.0, test10, test11: HPT366 problem 
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Date: Tue, 21 Nov 2000 11:01:26 +0000
Message-ID: <8094.974804486@redhat.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


andre@linux-ide.org said:
>  2.2.x and 2.4.0-xxx, do not share the same interrupt pin hack. 

>  Add the above stub to ide-pci.c near or at line 756 to look like 2.2,
> then retry and see if it fixes it.  Then you bitch at Linus, not me,
> because it is a functional kludge, but a "kludge". 


But:

 1) 2.2 with your latest patches also falls over, even with the DMA timeout
	workaround enabled.

 2) This happens even when the offending IBM-DTLA drive is the master
	on the primary HPT366 controller, and nothing else is connected.

hakanl@cdt.luth.se said:
>  Udma3 seem to be rock solid though as long as it manages to pass the
> partition  detection during boot up. 

Strange. If it sometimes fails during the partition detection, then I'd 
expect it to also fail in stress testing. Can you try repeatedly doing 
BLKRRPART on it {instead of,as well as} parallel 'hdparm -t'?

If it falls over at udma3, perhaps we should blacklist it all the way down 
to udma2?

--
dwmw2


-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
