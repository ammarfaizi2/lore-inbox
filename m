Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S314653AbSEUOhk>; Tue, 21 May 2002 10:37:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S314657AbSEUOhj>; Tue, 21 May 2002 10:37:39 -0400
Received: from chaos.physics.uiowa.edu ([128.255.34.189]:9644 "EHLO
	chaos.physics.uiowa.edu") by vger.kernel.org with ESMTP
	id <S314653AbSEUOhi>; Tue, 21 May 2002 10:37:38 -0400
Date: Tue, 21 May 2002 09:37:35 -0500 (CDT)
From: Kai Germaschewski <kai-germaschewski@uiowa.edu>
X-X-Sender: kai@chaos.physics.uiowa.edu
To: Russell King <rmk@arm.linux.org.uk>
cc: linux-kernel@vger.kernel.org
Subject: Re: 1GB piggys
In-Reply-To: <20020521124057.A2286@flint.arm.linux.org.uk>
Message-ID: <Pine.LNX.4.44.0205210933170.10815-100000@chaos.physics.uiowa.edu>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 21 May 2002, Russell King wrote:

> I'm getting reports of some people ending up with 1GB piggy objects for
> gzip to compress on ARM.  While investigating this, I found the following:
> 
> 00003dd4 ? __module_kernel_version
> 00003df4 ? __module_parm_minor
> 00003e04 ? __module_parm_flash_base
> 00003e18 ? __module_parm_flash_size
> 40004000 A swapper_pg_dir
> 40008000 ? __init_begin
> 40008000 ? _stext
> 40008000 ? stext
> 
> The __module_* stuff is from the .modinfo section of some kernel object.

Well, the .modinfo section should only be generated for objects build as 
modules, not into the kernel. So it very much likes some object has been 
compiled with -DMODULE, though it gets linked into the kernel.

(Which one is it? Obviously it has MODULE_PARM(minor/flash_base/size) in 
it)

> Since .modinfo isn't actually used or indeed placed in the linker
> script, shouldn't we be explicitly discarding it like the
> .exitcall.exit, .text.exit and .data.exit sections, rather than
> letting the linker apparantly pick some random memory location to
> dump this section?

Well, discarding .modinfo would only hide errors like this, so I wouldn't 
think it's a good idea.

--Kai


