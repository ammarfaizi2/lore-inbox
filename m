Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S266938AbTCEWp3>; Wed, 5 Mar 2003 17:45:29 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S266932AbTCEWp3>; Wed, 5 Mar 2003 17:45:29 -0500
Received: from amdext2.amd.com ([163.181.251.1]:2490 "EHLO amdext2.amd.com")
	by vger.kernel.org with ESMTP id <S266907AbTCEWp1>;
	Wed, 5 Mar 2003 17:45:27 -0500
From: ravikumar.chakaravarthy@amd.com
X-Server-Uuid: 262C4BA7-64EE-471D-8B02-117625D613AB
Message-ID: <99F2150714F93F448942F9A9F112634CA54B0F@txexmtae.amd.com>
To: kai@tp1.ruhr-uni-bochum.de
cc: mbligh@aracnet.com, linux-kernel@vger.kernel.org
Subject: RE: Loading and executing kernel from a non-standard address
 usin g SY SLINUX
Date: Wed, 5 Mar 2003 16:55:39 -0600
MIME-Version: 1.0
X-Mailer: Internet Mail Service (5.5.2653.19)
X-WSS-ID: 12785FF92468738-01-01
Content-Type: text/plain;
 charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Yup,
  Thanks I got that. The physical address is computed using (virtual address) - PAGE_OFFSET. So if my decompressed kernel is loaded at the physical address 0x200000 (I defined this address), I would need the linker to know it. Actually I went past that stage and now I got into start_kernel.. however it seems to be hanging somewhere after that. 
Is there any other kernel changes I need to make to avoid this hanging for a normal boot.

-Ravi

-----Original Message-----
From: Kai Germaschewski [mailto:kai@tp1.ruhr-uni-bochum.de] 
Sent: Wednesday, March 05, 2003 3:40 PM
To: Chakaravarthy, Ravikumar
Cc: mbligh@aracnet.com; linux-kernel@vger.kernel.org
Subject: RE: Loading and executing kernel from a non-standard address usin g SY SLINUX

On Tue, 4 Mar 2003 ravikumar.chakaravarthy@amd.com wrote:

> Yes the kernel is uncompressed to the right location (0x200000), in my
> case. When I try to uncompress it to a non standard address (other than
> 0x100000), the address mapping is affected. Thats why I tried to change
> the PAGE_OFFSET value to 0xc0100000, which should be the right value
> corresponding to (0x200000).

> So the problem now is that, when a function is invoked it is unable to
> fetch the right physical address, since my address mapping (System.map)
> does not change when I change the value of PAGE_OFFSET and recompile the
> kernel.

Well, this sounds very much like your vmlinux is relocated to the wrong 
adresses, and then it's not surprising it doesn't work. You definitely 
want to change arch/i386/vmlinux.lds.S. I'm not sure if you actually want 
to change PAGE_OFFSET, but I don't see a fundamental reason why it should 
be needed, so I think you should try as-is.

--Kai



