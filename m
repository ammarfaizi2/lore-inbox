Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266680AbUI0LRc@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266680AbUI0LRc (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 27 Sep 2004 07:17:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266679AbUI0LRc
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 27 Sep 2004 07:17:32 -0400
Received: from witte.sonytel.be ([80.88.33.193]:19876 "EHLO witte.sonytel.be")
	by vger.kernel.org with ESMTP id S266680AbUI0LRO (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 27 Sep 2004 07:17:14 -0400
Date: Mon, 27 Sep 2004 13:17:05 +0200 (MEST)
From: Geert Uytterhoeven <geert@linux-m68k.org>
To: Jochen Friedrich <jochen@scram.de>
cc: "Christian T. Steigies" <cts@debian.org>,
       Linux/m68k <linux-m68k@lists.linux-m68k.org>,
       Linux Kernel Development <linux-kernel@vger.kernel.org>
Subject: sprintf -> strcpy (was: Re: gcc-3.4)
In-Reply-To: <Pine.LNX.4.58.0409262049380.1809@localhost>
Message-ID: <Pine.GSO.4.61.0409271315230.15815@waterleaf.sonytel.be>
References: <20040925145454.GA16191@skeeve> <20040925221427.GA30105@skeeve>
 <Pine.LNX.4.58.0409262049380.1809@localhost>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


(CC'ing lkml)

On Sun, 26 Sep 2004, Jochen Friedrich wrote:
> > Or maybe it is the binutils? After downgrading to 2.14 from a previous
> > toolchain source, I could build linux-2.6.8 with gcc-3.4.
> 
> I'm using binutils 2.15 and gcc 3.4.2 on Alpha to cross compile 2.6. All i
> noticed is that the compiler optimizes sprintf(x,"%s",y) to strcpy(x,y)
> which then fails to link or causes unresolved externals because strcpy is
> an inline function on m68k. The fix is to do the replacement in the
> source, like here:

I remember seeing a similar discussion on lkml about some other automatic
replacements a while ago, but I cannot remember the details...

Is this the correct(TM) way to fix this issue, or is there a better solution?

> diff -c -r1.1.1.21 binfmt_misc.c
> *** fs/binfmt_misc.c    15 Aug 2004 14:18:10 -0000      1.1.1.21
> --- fs/binfmt_misc.c    26 Sep 2004 18:54:27 -0000
> ***************
> *** 461,467 ****
>         dp = page + strlen(page);
> 
>         /* print the special flags */
> !       sprintf (dp, "%s", flags);
>         dp += strlen (flags);
>         if (e->flags & MISC_FMT_PRESERVE_ARGV0) {
>                 *dp ++ = 'P';
> --- 461,467 ----
>         dp = page + strlen(page);
> 
>         /* print the special flags */
> !       strcpy (dp, flags);
>         dp += strlen (flags);
>         if (e->flags & MISC_FMT_PRESERVE_ARGV0) {
>                 *dp ++ = 'P';
> 

Gr{oetje,eeting}s,

						Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
							    -- Linus Torvalds
