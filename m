Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317424AbSFROYz>; Tue, 18 Jun 2002 10:24:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317427AbSFROYy>; Tue, 18 Jun 2002 10:24:54 -0400
Received: from chaos.physics.uiowa.edu ([128.255.34.189]:34773 "EHLO
	chaos.physics.uiowa.edu") by vger.kernel.org with ESMTP
	id <S317424AbSFROYx>; Tue, 18 Jun 2002 10:24:53 -0400
Date: Tue, 18 Jun 2002 09:24:48 -0500 (CDT)
From: Kai Germaschewski <kai@tp1.ruhr-uni-bochum.de>
X-X-Sender: kai@chaos.physics.uiowa.edu
To: "Adam J. Richter" <adam@yggdrasil.com>
cc: linux-kernel@vger.kernel.org
Subject: Re: Various kbuild problems in 2.5.22
In-Reply-To: <200206181218.FAA08522@adam.yggdrasil.com>
Message-ID: <Pine.LNX.4.44.0206180917230.5695-100000@chaos.physics.uiowa.edu>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 18 Jun 2002, Adam J. Richter wrote:

> 	I would like to note the following problems with the
> kernel build process in 2.5.22, after applying the patch that
> Kai Germaschewski posted that enabled modversions to work again.
> All but the first one are spurious dependencies.

> #define __ver_pcmcia_get_mem_page_Rsmp_3d2ded54 smp_ba03375b
> #define pcmcia_get_mem_page_Rsmp_3d2ded54       _set_ver(pcmcia_get_mem_page_Rsmp_3d2ded54)

Yes, the fix I posted was not complete. I submitted a corrected one 
already.

> 	2. "make bzImage" does not build a bzImage if any module fails
> to compile.  Really, it should not attempt to buidl modules or even
> descend into directories that contain only modules.  To build a bzImage,
> I have to edit the Makefile and comment out "BUILD_MODULES:=1".

That's intentional. If you don't want to build modules, use "make 
KBUILD_MODULES= bzImage". Or you can just ignore errors using "make -k".


> 	3. make include/linux/modversios.h aborts if any .c file has
> a #error or #include's a .h that is not present (for example, because
> the .h is built by the process, as is the case with one scsi driver).

The fact that it aborts is intentional. That it doesn't build the .h in 
that case is a bug. Which driver is it?

> 	4. "make -k modules" will not build perfectly buildable modules
> in a directory that has a subdirectory where a compile error occurs.

Well, I can fix that, I'll look into it.

--Kai


