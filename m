Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S266717AbSKSPZP>; Tue, 19 Nov 2002 10:25:15 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S266728AbSKSPZP>; Tue, 19 Nov 2002 10:25:15 -0500
Received: from franka.aracnet.com ([216.99.193.44]:60567 "EHLO
	franka.aracnet.com") by vger.kernel.org with ESMTP
	id <S266717AbSKSPZO>; Tue, 19 Nov 2002 10:25:14 -0500
Date: Tue, 19 Nov 2002 07:28:58 -0800
From: "Martin J. Bligh" <mbligh@aracnet.com>
Reply-To: "Martin J. Bligh" <mbligh@aracnet.com>
To: "Eric W. Biederman" <ebiederm@xmission.com>,
       Dave Hansen <haveblue@us.ibm.com>
cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [ANNOUNCE][CFT] kexec for v2.5.48 && kexec-tools-1.7
Message-ID: <787956812.1037690937@[10.10.2.3]>
In-Reply-To: <m1of8l27fy.fsf@frodo.biederman.org>
References: <m1of8l27fy.fsf@frodo.biederman.org>
X-Mailer: Mulberry/2.1.2 (Win32)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> I suspect the hardware shutdown and start up logic for NUMAQ cpus 
> needs some special handling.   

Almost certainly ;-) One of the main things I do differently on boot
is to use NMIs rather than the normal INIT/STARTUP sequence to bootstrap
CPUs with .... thus they aren't as thoroughly reset. Things like clearing
down the local APIC state (but NOT the LDR) and clearing down the IO-APICs
will be especially important. I haven't looked at your code yet to see
exactly what it does here though.

> Small steps.   When I bypass the BIOS I need to get all of the information
> the kernel normally would get from the BIOS from someplace else.  Currently
> you can use the "mem= " kernel command line parameters.  Of you can dig the
> /proc/iomem and /proc/meminfo and other places and get the BIOS's memory map.
> There isn't a really good source, so I started with something that would work,
> and I will work the user space tools up to something that works well.
> 
> I will happily accept patches :)

Sounds like we should just export back to you the value we parsed from
the BIOS from the existing boot, no? I'll see if I can make you a patch
to do that ...

M.

