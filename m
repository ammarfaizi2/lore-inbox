Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266520AbUGUPrq@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266520AbUGUPrq (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 21 Jul 2004 11:47:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266524AbUGUPrq
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 21 Jul 2004 11:47:46 -0400
Received: from witte.sonytel.be ([80.88.33.193]:47002 "EHLO witte.sonytel.be")
	by vger.kernel.org with ESMTP id S266520AbUGUPrl (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 21 Jul 2004 11:47:41 -0400
Date: Wed, 21 Jul 2004 17:43:33 +0200 (MEST)
From: Geert Uytterhoeven <geert@linux-m68k.org>
To: "Povolotsky, Alexander" <Alexander.Povolotsky@marconi.com>
cc: "'Hollis Blanchard'" <hollisb@us.ibm.com>,
       "'linuxppc-dev@lists.linuxppc.org'" <linuxppc-dev@lists.linuxppc.org>,
       crossgcc <crossgcc@sources.redhat.com>,
       "'bertrand marquis'" <bertrand_marquis@yahoo.fr>,
       "'trevor_scroggins@hotmail.com'" <trevor_scroggins@hotmail.com>,
       "'Dan Kegel'" <dank@kegel.com>,
       Linux Kernel list <linux-kernel@vger.kernel.org>
Subject: RE:  Re: missing elf.h (for mk_elfconfig.c)  while  building zIma
 ge for PPC on Intel platform (windows XP) using cygwin
In-Reply-To: <313680C9A886D511A06000204840E1CF08F4304E@whq-msgusr-02.pit.comms.marconi.com>
Message-ID: <Pine.GSO.4.58.0407211741590.8147@waterleaf.sonytel.be>
References: <313680C9A886D511A06000204840E1CF08F4304E@whq-msgusr-02.pit.comms.marconi.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 21 Jul 2004, Povolotsky, Alexander wrote:
> You are correct. It looks for /usr/include/elf.h. It is not a case of
> missing (altogether) elf.h - it is just misconfiguration issue (files are
> looked in a wrong directories - another menuconfig problem ?)

/usr/include is the correct location, though. Did you install libelf-dev under
Cygwin?

> As a proof of that - I copied existent elf.h include file from
> \linux-2.6.7\include\linux

That's the kernel elf.h, which is not the correct one...

> to /usr/include/elf.h (there was no elf.h there originally ...) - and
> compilation moved forward for one step -
> now it can not find linux/types.h, the one which "lives" (I think) in
> \linux-2.6.7\include\linux, and asm/elf.h, the one which "lives" (I think)
> in \linux-2.6.7\include\asm-ppc
>
> $ make zImage
>   HOSTCC  scripts/basic/fixdep
>   HOSTCC  scripts/basic/split-include
>   HOSTCC  scripts/basic/docproc
>   HOSTCC  scripts/conmakehash
>   HOSTCC  scripts/kallsyms
>   HOSTCC  scripts/mk_elfconfig
> In file included from scripts/mk_elfconfig.c:4:
> /usr/include/elf.h:4:25: linux/types.h: No such file or directory

... hence these error messages.

> Povolotsky, Alexander wrote:
> > I have made changes in linux-2.6/scripts/kconfig/Makefile as advised and
> it
> > did fix menuconfig problem - thank you very much for being kind and
> patient
> > helping - much appreciated !
> >
> > Now I am facing the next problem: missing elf.h (for mk_elfconfig.c) while
> > building zImage for PPC on Intel platform (windows XP) using cygwin.
> > ...
> > scripts/mk_elfconfig.c:4:17: elf.h: No such file or directory
> >
> > From where I could pick-up this include file ?
>
> In other words, download and install
>    http://www.gnu.org/directory/libs/misc/libelf.html
> which will I think provide <gelf.h>;
> you can then make an elf.h that just does
>    #include <gelf.h>
> and you should be good to go.  (I haven't tried it myself.)
> - Dan

Yep, these are the files you need.

Gr{oetje,eeting}s,

						Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
							    -- Linus Torvalds
