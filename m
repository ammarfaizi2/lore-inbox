Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S263674AbRFRH30>; Mon, 18 Jun 2001 03:29:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S263676AbRFRH3Q>; Mon, 18 Jun 2001 03:29:16 -0400
Received: from aeon.tvd.be ([195.162.196.20]:58551 "EHLO aeon.tvd.be")
	by vger.kernel.org with ESMTP id <S263674AbRFRH3J>;
	Mon, 18 Jun 2001 03:29:09 -0400
Date: Mon, 18 Jun 2001 09:26:24 +0200 (CEST)
From: Geert Uytterhoeven <geert@linux-m68k.org>
To: Ivan Vadovic <pivo@pobox.sk>
cc: Riley Williams <rhw@MemAlpha.CX>, linux-kernel@vger.kernel.org
Subject: Re: any good diff merging utility?
In-Reply-To: <20010618023459.C1063@ivan.doma>
Message-ID: <Pine.LNX.4.05.10106180919200.15276-100000@callisto.of.borg>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 18 Jun 2001, Ivan Vadovic wrote:
> >  > I like to build kernels with a bunch of patches on top to test
> >  > new stuff. The problem is that it takes a lot of effort to fix
> >  > all the failed hunks during patching that really wouldn't have
> >  > to be failed if only patch was a little more inteligent and
> >  > could merge several patches into one ( if possible) or if could
> >  > take into account already applied patches.
> > 
> > The basic problem here is that the "failed hunks" are usually there
> > because of conflicts between the two patches in question, and as a
> > result, they are not as easy to merge automagically as one might at
> > first assume.
> 
> Very often the case is that they indeed can be merged automagically.
> For example two patches inserting few lines right after the #include
> lines.
> 
> patch1:
> @@ 10,1 10,2 @@
>  #include <foo.h>
> +#include <1.h>
> 
> patch2:
> @@ 10,1 10,2 @@
>  #include <foo.h>
> +#include <2.h>
> 
> The patch will fail to patch :-). But there is no real conflict between
> the patches.
>  
> >  > Well, are there any utilities to merge diffs? I couldn't find
> >  > any on freshmeat. So what are you using to stack many patches
> >  > onto the kernel tree? Just manualy modify the diff? I'll try to
> >  > write something more automatic if nothing comes up.
> > 
> > I once came across a utility called "diff3" that was designed to take
> > a patch for one version of a package and create an equivalent patch
> > for another version of the same package, but I haven't been able to
> > find it again since my hard drive crashed.
> 
> diff3 comes from gnu diffutils
> <ftp://ftp.gnu.org/gnu/diffutils/diffutils-2.7.tar.gz>. But all it does
> is comparing three FILES for differencies.

Diffutils also contains `merge' which is more or less what you want: it merges
two files and a common ancestor into one file. So you can merge two diffs as
well, by merging the following three files:

  - original + diff1 applied
  - original
  - original + diff2 applied

If a conflict happens, merge will warn you and indicate it with special signs
in the merged file.

Merge is only for one file with different versions. I wrote a Perl script
`mergetree' that applies merge recursively to merge two directory trees and a
common ancestor. It also has an option to create hard links if the merge result
is identical to one of the merge input files. This saves diskspace if you use
cp -rl and patch and the `same' utility to have multiple revisions of the same
tree on one disk. If you want the script, mail me in private.

Revision control systems do the same, and many more things. But `mergetree'
proved to be very useful for me to keep my Linux/m68k in sync with Linus'/Alans
tree.

Gr{oetje,eeting}s,

						Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
							    -- Linus Torvalds

