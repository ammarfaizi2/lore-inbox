Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265941AbRGJIk0>; Tue, 10 Jul 2001 04:40:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265948AbRGJIkQ>; Tue, 10 Jul 2001 04:40:16 -0400
Received: from columba.EUR.3Com.COM ([161.71.169.13]:38796 "EHLO
	columba.eur.3com.com") by vger.kernel.org with ESMTP
	id <S265941AbRGJIkG>; Tue, 10 Jul 2001 04:40:06 -0400
X-Lotus-FromDomain: 3COM
From: "Jon Burgess" <Jon_Burgess@eur.3com.com>
To: linux-kernel@vger.kernel.org
Message-ID: <80256A85.002FDC1E.00@notesmta.eur.3com.com>
Date: Tue, 10 Jul 2001 09:39:32 +0100
Subject: Re: loosing interrupt 12 under Linux-2.4.Re: loosing interrupt 12
	 under Linux-2.4.[2-6]
Mime-Version: 1.0
Content-type: text/plain; charset=us-ascii
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



I had a similar problem which was caused by an interaction between the BIOS and
Linux. The Ethernet NIC was assigned IRQ 12 by the BIOS because it had the PS/2
mouse disabled, however the kernel found the mouse and used IRQ12 for both the
mouse and the Ethernet card. The result was that the Ethernet card didn't work
properly and the system would occasionally freeze. The solution was to enable
the PS/2 mouse in the BIOS.

I didn't investigate the problem further once I had found a solution but my
guess is that there were two things at fault here:

- BIOS was at fault for not properly disabling the PS/2 device in the SuperIO
whiuch would have freed IRQ12.
- I think it might be an error for a PCI device (the NIC) to share an IRQ with
an ISA device (PS/2 mouse). Perhaps the kernel should flag this?

     Jon


