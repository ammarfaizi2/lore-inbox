Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S266998AbSKSRhf>; Tue, 19 Nov 2002 12:37:35 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267020AbSKSRhf>; Tue, 19 Nov 2002 12:37:35 -0500
Received: from ebiederm.dsl.xmission.com ([166.70.28.69]:49493 "EHLO
	frodo.biederman.org") by vger.kernel.org with ESMTP
	id <S266998AbSKSRhd>; Tue, 19 Nov 2002 12:37:33 -0500
To: "Martin J. Bligh" <mbligh@aracnet.com>
Cc: Dave Hansen <haveblue@us.ibm.com>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [ANNOUNCE][CFT] kexec for v2.5.48 && kexec-tools-1.7
References: <m1of8l27fy.fsf@frodo.biederman.org>
	<787956812.1037690937@[10.10.2.3]>
From: ebiederm@xmission.com (Eric W. Biederman)
Date: 19 Nov 2002 10:44:02 -0700
In-Reply-To: <787956812.1037690937@[10.10.2.3]>
Message-ID: <m11y5h1ml9.fsf@frodo.biederman.org>
User-Agent: Gnus/5.09 (Gnus v5.9.0) Emacs/21.1
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

"Martin J. Bligh" <mbligh@aracnet.com> writes:

> > I suspect the hardware shutdown and start up logic for NUMAQ cpus 
> > needs some special handling.   
> 
> Almost certainly ;-) One of the main things I do differently on boot
> is to use NMIs rather than the normal INIT/STARTUP sequence to bootstrap
> CPUs with .... thus they aren't as thoroughly reset. Things like clearing
> down the local APIC state (but NOT the LDR) and clearing down the IO-APICs
> will be especially important. I haven't looked at your code yet to see
> exactly what it does here though.

That part is in my x86kexec-hwfixes.diff I have a good first stab
at it that works on most x86 SMPs.  But apparently not on NUMAQ.
 
> > Small steps.   When I bypass the BIOS I need to get all of the information
> > the kernel normally would get from the BIOS from someplace else.  Currently
> > you can use the "mem= " kernel command line parameters.  Of you can dig the
> > /proc/iomem and /proc/meminfo and other places and get the BIOS's memory map.
> > There isn't a really good source, so I started with something that would work,
> 
> > and I will work the user space tools up to something that works well.
> > 
> > I will happily accept patches :)
> 
> Sounds like we should just export back to you the value we parsed from
> the BIOS from the existing boot, no? I'll see if I can make you a patch
> to do that ...

Yep.  But we currently don't export it cleanly...

Eric

