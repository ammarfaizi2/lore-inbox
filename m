Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S269459AbTCDRpl>; Tue, 4 Mar 2003 12:45:41 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S269460AbTCDRpl>; Tue, 4 Mar 2003 12:45:41 -0500
Received: from amdext2.amd.com ([163.181.251.1]:61917 "EHLO amdext2.amd.com")
	by vger.kernel.org with ESMTP id <S269459AbTCDRpj>;
	Tue, 4 Mar 2003 12:45:39 -0500
From: ravikumar.chakaravarthy@amd.com
X-Server-Uuid: 262C4BA7-64EE-471D-8B02-117625D613AB
Message-ID: <99F2150714F93F448942F9A9F112634CA54B08@txexmtae.amd.com>
To: mbligh@aracnet.com, linux-kernel@vger.kernel.org
Subject: RE: Loading and executing kernel from a non-standard address
 usin g SY SLINUX
Date: Tue, 4 Mar 2003 11:55:49 -0600
MIME-Version: 1.0
X-Mailer: Internet Mail Service (5.5.2653.19)
X-WSS-ID: 127A37232302268-01-01
Content-Type: text/plain;
 charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Yes the kernel is uncompressed to the right location (0x200000), in my case. When I try to uncompress it to a non standard address (other than 0x100000), the address mapping is affected. Thats why I tried to change the PAGE_OFFSET value to 0xc0100000, which should be the right value corresponding to (0x200000). 
So the problem now is that, when a function is invoked it is unable to fetch the right physical address, since my address mapping (System.map) does not change when I change the value of PAGE_OFFSET and recompile the kernel.

-Ravi


-----Original Message-----
From: Martin J. Bligh [mailto:mbligh@aracnet.com] 
Sent: Tuesday, March 04, 2003 11:35 AM
To: Chakaravarthy, Ravikumar; linux-kernel@vger.kernel.org
Subject: Re: Loading and executing kernel from a non-standard address using SY SLINUX

> I am trying to load and boot the kernel from a non-standard address
> (0x200000). I am using the SYSLINUX boot loader, which loads the
> kernel at that address. I have also made changes to the kernel to
> setup code and startup_32() function to effect the same. When I boot
> the system It says
> 
> Loading.......... Ready
> Uncompressing Linux... OK Booting the kernel
> 
> and then hangs.
> 
> I guess the reason being the System.map entries are still using the
> PAGE_OFFSET = 0xc0000000, as opposed to 0xc0100000.
> I have the following questions??
> 
> 1. How do i change the System.map to get the right PAGE_OFFSET.
> 2. Will it work if I load and boot the kernel from a different address
> like (0xdf000000)??
> 
> 3. Am I in the right track or missing something.

The kernel should decompress itself to the right space anyway ... check
arch/i386/boot/compressed/head.S ... should be minimal changes needed,
if any.

M.

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
Please read the FAQ at  http://www.tux.org/lkml/

