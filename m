Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S264610AbTBAAio>; Fri, 31 Jan 2003 19:38:44 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S264617AbTBAAio>; Fri, 31 Jan 2003 19:38:44 -0500
Received: from chaos.physics.uiowa.edu ([128.255.34.189]:37608 "EHLO
	chaos.physics.uiowa.edu") by vger.kernel.org with ESMTP
	id <S264610AbTBAAim>; Fri, 31 Jan 2003 19:38:42 -0500
Date: Fri, 31 Jan 2003 18:48:06 -0600 (CST)
From: Kai Germaschewski <kai@tp1.ruhr-uni-bochum.de>
X-X-Sender: kai@chaos.physics.uiowa.edu
To: Roman Zippel <zippel@linux-m68k.org>
cc: Rusty Russell <rusty@rustcorp.com.au>, <linux-kernel@vger.kernel.org>,
       <greg@kroah.com>, <jgarzik@pobox.com>
Subject: Re: [PATCH] Module alias and device table support.
In-Reply-To: <Pine.LNX.4.44.0301312045440.9900-100000@serv>
Message-ID: <Pine.LNX.4.44.0301311842140.16486-100000@chaos.physics.uiowa.edu>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 31 Jan 2003, Roman Zippel wrote:

> On Fri, 31 Jan 2003, Kai Germaschewski wrote:
> 
> > exactly great. In doing that, I already notice unresolved symbols and warn 
> > about them, which I think is an improvement to the build process, missing 
> > EXPORT_SYMBOL()s tend to go unnoticed quite often otherwise.
> 
> The problem here is that we use System.map, it's not that difficult to 
> extract the exported symbols:
> objcopy -j .kstrtab -O binary vmlinux .export.tmp
> tr \\0 \\n < .export.tmp > Export.map

What you say is right (except that it misses symbols exported from 
modules), but I don't see what you mean the problem is?

> It makes sense to keep depmod close to the linker, as both need the same 
> knowledge about resolving symbols, but I still don't know why that would 
> be a reason to put it into the kernel.

Well, I hope you mean into the kernel tree, it sure doesn't make sense to 
put it into the kernel itself.

Anyway, I think rusty's approach is to deal with the kernel-internal data 
structures from inside the kernel tree (during the build, that is) and 
generate data in a fixed format (.modalias) for depmod to read. Since 
depmod is external, it needs a fixed interface. Makes sense to me.

--Kai


