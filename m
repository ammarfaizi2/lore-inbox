Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267364AbRGKRKW>; Wed, 11 Jul 2001 13:10:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267365AbRGKRKM>; Wed, 11 Jul 2001 13:10:12 -0400
Received: from jffdns02.or.intel.com ([134.134.248.4]:6888 "EHLO
	hebe.or.intel.com") by vger.kernel.org with ESMTP
	id <S267364AbRGKRKB>; Wed, 11 Jul 2001 13:10:01 -0400
Message-ID: <9287DC1579B0D411AA2F009027F44C3F05F5F20E@FMSMSX41>
From: "Naik, Uday" <uday.naik@intel.com>
To: "'ixp1200@CS.Princeton.EDU'" <ixp1200@CS.Princeton.EDU>,
        linux-kernel@vger.kernel.org
Subject: RE: [ixp1200] questions on memory in linux
Date: Wed, 11 Jul 2001 10:09:37 -0700
MIME-Version: 1.0
X-Mailer: Internet Mail Service (5.5.2653.19)
Content-Type: text/plain;
	charset="iso-8859-1"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

a) For memory, one easy solution is to map this memory as unprotected
   uncached memory in kernel space. We did exactly this. Look at the
   ixp1200 linux kernel on www.netwinder.org/~urnaik

   Look at mm-ixp1200.c, and include/asm/arch/hardware.h.

   We mapped the packet memory into virtual memory 0xd8000000 with 
   cache off and memory protection off. It is accessible to all processes
   at that address.

b) This is doable. Cygmon puts the boot string into 0xc0000000. But 
   currently the linux port does not read this string. You need to change
   the head.S in arch/arm/boot/compressed

Regards

Uday

-----Original Message-----
From: Josh Fryman [mailto:fryman@cc.gatech.edu]
Sent: Tuesday, July 10, 2001 11:44 AM
To: ixp1200@CS.Princeton.EDU; linux-kernel@vger.kernel.org
Subject: [ixp1200] questions on memory in linux



hi,

we've got some intel IXP 1200 (spin B0) eval boards, and are running 
linux in them.  we have some questions about how to do specific things
with (a) memory and (b) the cygmon mini-boot loader...

(a) memory:
        the IXP 1200 boards have 32M of SDRAM in two 16MB banks.  the
        bottom 24MB are used for linux, the rest are free... 
        however, we want to allocate some memory in that first bank
        and *tie* it down so that it's always available at that address
        physically to the IXP microengines as well as virtually to the
        linux system.  can anyone provide pointers to FAQs or other
        documents for handling this?  eg, some way to do a 
        malloc( 1MB ) and then get the true physical address of the 
        malloc results?  

(b) the IXP 1200 has a SA-1100 core running the cygmon mini loader from
        flash.  is there any way to specify kernel-load arguments,
        similar to how LILO works, with this system?  any pointers to
        where we can find out more details for this?  the process is to
        boot the cygmon from flash, give it the parameters for where to
        TFTP the kernel / ramdisk from, and then let it run.  we'd like
        to force the kernel to run with a "mem=4M" type of setting so
        it doesn't suck down our very meager memory for buffers we don't
        want/need.  (note, if we can do this, the part (a) above doesn't
	necessarily go away... it's something we still need to know how
	to do...)

thanks for any input,

josh

