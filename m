Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129069AbQKHNoB>; Wed, 8 Nov 2000 08:44:01 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129112AbQKHNnm>; Wed, 8 Nov 2000 08:43:42 -0500
Received: from tomcat.admin.navo.hpc.mil ([204.222.179.33]:38997 "EHLO
	tomcat.admin.navo.hpc.mil") by vger.kernel.org with ESMTP
	id <S129069AbQKHNnh>; Wed, 8 Nov 2000 08:43:37 -0500
Date: Wed, 8 Nov 2000 07:43:29 -0600 (CST)
From: Jesse Pollard <pollard@tomcat.admin.navo.hpc.mil>
Message-Id: <200011081343.HAA341140@tomcat.admin.navo.hpc.mil>
To: jmerkey@vger.timpanogas.org, davej@suse.de
Subject: Re: Installing kernel 2.4
Cc: linux-kernel@vger.kernel.org
X-Mailer: [XMailTool v3.1.2b]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

---------  Received message begins Here  ---------

> 
> On Wed, Nov 08, 2000 at 03:25:56AM +0000, davej@suse.de wrote:
> > On Tue, 7 Nov 2000, Jeff V. Merkey wrote:
> > 
> > > If the compiler always aligned all functions and data on 16 byte
> > > boundries (NetWare)  for all i386 code, it would run a lot faster.
> > 
> > Except on architectures where 16 byte alignment isn't optimal.
> > 
> > > Cache line alignment could be an option in the loader .... after all,
> > > it's hte loader that locates data in memory.  If Linux were PE based,
> > > relocation logic would be a snap with this model (like NT).
> > 
> > Are you suggesting multiple files of differing alignments packed into
> > a single kernel image, and have the loader select the correct one at
> > runtime ? I really hope I've misinterpreted your intention.
> 
> Or more practically, a smart loader than could select a kernel image
> based on arch and auto-detect to load the correct image. I don't really
> think it matters much what mechanism is used.   
> 
> What makes more sense is to pack multiple segments for different 
> processor architecures into a single executable package, and have the 
> loader pick the right one (the NT model).  It could be used for 
> SMP and non-SMP images, though, as well as i386, i586, i686, etc.  

Sure.. and it will also be able to boot on Alpha/Sparc/PPC....:)

The best is to have the installer (person) to select the primary
archecture from a CD. There will NOT be a single boot loader that will
work for all systems. At best, there will have to be one per CPU family,
but more likely, one per BIOS structure. This is the only thing that can
determine the primary boot.

The primary boot can then determine which CPU type (starting with the
smallest common CPU), and set flags for a kernel (minimal kernel) load.
During the startup of THAT kernel then the selection of target RPM can
be made that would install a kernel for the specific architetcure. After
a (minimal?) system install, a reboot would be necessary.

It actually seems like it would be simpler to use the minimal kernel
to rebuild the kernel for the local architecture. MUCH less work.
This still requires a CPU family selection by the person doing the install.
Nothing will get around that.

-------------------------------------------------------------------------
Jesse I Pollard, II
Email: pollard@navo.hpc.mil

Any opinions expressed are solely my own.
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
