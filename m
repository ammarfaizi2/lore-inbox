Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1031116AbWKQFKp@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1031116AbWKQFKp (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 17 Nov 2006 00:10:45 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1031193AbWKQFKp
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 17 Nov 2006 00:10:45 -0500
Received: from raven.upol.cz ([158.194.120.4]:13981 "EHLO raven.upol.cz")
	by vger.kernel.org with ESMTP id S1031116AbWKQFKo (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 17 Nov 2006 00:10:44 -0500
Date: Fri, 17 Nov 2006 05:17:29 +0000
To: Horst Schirmeier <horst@schirmeier.com>, Andi Kleen <ak@suse.de>,
       Valdis.Kletnieks@vt.edu, Jan Beulich <jbeulich@novell.com>,
       draconx@gmail.com, jpdenheijer@gmail.com, Andrew Morton <akpm@osdl.org>,
       Sam Ravnborg <sam@ravnborg.org>, LKML <linux-kernel@vger.kernel.org>
Subject: kbuild: O= with M= (Re: [PATCH -mm] replacement for broken kbuild-dont-put-temp-files-in-the-source-tree.patch)
Message-ID: <20061117051729.GA12896@flower.upol.cz>
References: <20061029120858.GB3491@quickstop.soohrt.org> <slrnekcu6m.2vm.olecom@flower.upol.cz> <20061031001235.GE2933@quickstop.soohrt.org> <200610310119.10567.ak@suse.de> <20061031011416.GG2933@quickstop.soohrt.org> <20061031135136.GB16063@flower.upol.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20061031135136.GB16063@flower.upol.cz>
User-Agent: Mutt/1.5.13 (2006-08-11)
From: Oleg Verych <olecom@flower.upol.cz>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Oct 31, 2006 at 02:51:36PM +0100, olecom wrote:
[]
> On Tue, Oct 31, 2006 at 02:14:16AM +0100, Horst Schirmeier wrote:
[]
> > I'm not sure what you mean by $(objdir); I just got something to work
> > which creates the /dev/null symlink in a (newly created if necessary)
> > directory named
> 
> $(objtree) is a directory for all possible outputs of the build precess,
> it's set up by `O=' or `KBUILD_OUTPUT', and this is *not* output for ready
> external modules `$(M)'. Try to play with this, please.

And for me, they are *not* working together:

,--[shell]--
|olecom@deen:/tmp/linux-source-2.6.18$ make clean
|olecom@deen:/tmp/linux-source-2.6.18$ make M=$a
|  LD      /mnt/work/app-src-build/kernel.org/_work/ti_usb/built-in.o
|  CC [M]  /mnt/work/app-src-build/kernel.org/_work/ti_usb/ti_usb_3410_5052.o
|  Building modules, stage 2.
|  MODPOST
|  CC      /mnt/work/app-src-build/kernel.org/_work/ti_usb/ti_usb_3410_5052.mod.o
|  LD [M]  /mnt/work/app-src-build/kernel.org/_work/ti_usb/ti_usb_3410_5052.ko
|olecom@deen:/tmp/linux-source-2.6.18$
|olecom@deen:/tmp/linux-source-2.6.18$ make clean
|olecom@deen:/tmp/linux-source-2.6.18$ make O=/tmp/_build-2.6/ M=$a
|  CC [M]  /mnt/work/app-src-build/kernel.org/_work/ti_usb/ti_usb_3410_5052.o
|  Building modules, stage 2.
|  MODPOST
|/bin/sh: scripts/mod/modpost: not found
|make[2]: *** [__modpost] Error 127
|make[1]: *** [modules] Error 2
|make: *** [_all] Error 2
|olecom@deen:/tmp/linux-source-2.6.18$ make clean
|olecom@deen:/tmp/linux-source-2.6.18$ make M=$a
|  CC [M]  /mnt/work/app-src-build/kernel.org/_work/ti_usb/ti_usb_3410_5052.o
|  Building modules, stage 2.
|  MODPOST
|  LD [M]  /mnt/work/app-src-build/kernel.org/_work/ti_usb/ti_usb_3410_5052.ko
|olecom@deen:/tmp/linux-source-2.6.18$
`--

I'm using 'O=' as good way to have clean kernel source directory,
regardless of any "ignore files" policy. And it seems, must be fixed.

> I'm looking for Sam to say something, if we must go further with this.
> ____
____
