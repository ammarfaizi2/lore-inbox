Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S264644AbTBABNz>; Fri, 31 Jan 2003 20:13:55 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S264646AbTBABNy>; Fri, 31 Jan 2003 20:13:54 -0500
Received: from smtpzilla1.xs4all.nl ([194.109.127.137]:20751 "EHLO
	smtpzilla1.xs4all.nl") by vger.kernel.org with ESMTP
	id <S264644AbTBABNy>; Fri, 31 Jan 2003 20:13:54 -0500
Date: Sat, 1 Feb 2003 02:22:38 +0100 (CET)
From: Roman Zippel <zippel@linux-m68k.org>
X-X-Sender: roman@serv
To: Kai Germaschewski <kai@tp1.ruhr-uni-bochum.de>
cc: Rusty Russell <rusty@rustcorp.com.au>, <linux-kernel@vger.kernel.org>,
       <greg@kroah.com>, <jgarzik@pobox.com>
Subject: Re: [PATCH] Module alias and device table support.
In-Reply-To: <Pine.LNX.4.44.0301311842140.16486-100000@chaos.physics.uiowa.edu>
Message-ID: <Pine.LNX.4.44.0302010157530.6646-100000@serv>
References: <Pine.LNX.4.44.0301311842140.16486-100000@chaos.physics.uiowa.edu>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Fri, 31 Jan 2003, Kai Germaschewski wrote:

> > > missing 
> > > EXPORT_SYMBOL()s tend to go unnoticed quite often otherwise.
> > 
> > The problem here is that we use System.map, it's not that difficult to 
> > extract the exported symbols:
> > objcopy -j .kstrtab -O binary vmlinux .export.tmp
> > tr \\0 \\n < .export.tmp > Export.map
> 
> What you say is right (except that it misses symbols exported from 
> modules), but I don't see what you mean the problem is?

See above, maybe I quoted to much. The other exported symbols are 
already extracted by depmod, so it had exactly the information it needs 
and would give more correct warnings.

> > It makes sense to keep depmod close to the linker, as both need the same 
> > knowledge about resolving symbols, but I still don't know why that would 
> > be a reason to put it into the kernel.
> 
> Well, I hope you mean into the kernel tree, it sure doesn't make sense to 
> put it into the kernel itself.
> 
> Anyway, I think rusty's approach is to deal with the kernel-internal data 
> structures from inside the kernel tree (during the build, that is) and 
> generate data in a fixed format (.modalias) for depmod to read. Since 
> depmod is external, it needs a fixed interface. Makes sense to me.

You have to define a fixed format somewhere anyway, either you have to do 
it for depmod or for modprobe. This only moves the problem around and if 
we already break interfaces, we should look at all the possibilities.
What I'm really missing is an analysis of the problem(s) and a description 
of how the solution solves it. After reading most of the patches I think I 
understand what Rusty is trying to do, but I still think there are better 
solutions, unfortunately Rusty doesn't talk with me anymore :(, if anyone 
else knows what I'm doing wrong, I'd be really happy to know about it.

bye, Roman

