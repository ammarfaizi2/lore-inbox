Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S287464AbSAUREE>; Mon, 21 Jan 2002 12:04:04 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S287425AbSAURDz>; Mon, 21 Jan 2002 12:03:55 -0500
Received: from www.transvirtual.com ([206.14.214.140]:6409 "EHLO
	www.transvirtual.com") by vger.kernel.org with ESMTP
	id <S287464AbSAURDo>; Mon, 21 Jan 2002 12:03:44 -0500
Date: Mon, 21 Jan 2002 09:03:25 -0800 (PST)
From: James Simmons <jsimmons@transvirtual.com>
To: Sven <luther@dpt-info.u-strasbg.fr>
cc: Geert Uytterhoeven <geert@linux-m68k.org>,
        Linux Fbdev development list 
	<linux-fbdev-devel@lists.sourceforge.net>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [Linux-fbdev-devel] [PATCH] fbdev fbgen cleanup
In-Reply-To: <20020121092851.A11531@dpt-info.u-strasbg.fr>
Message-ID: <Pine.LNX.4.10.10201210849030.20645-100000@www.transvirtual.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


> > The best tree to work with is the Dave Jones tree for 2.5.X. DJ tree
> > provides a better testing ground. Eventually when stuff goes from DJ to
> > Linus tree ruby and 2.5.X will look alot more alike :-) 
> 
> Mmm, any timeline for the DJ->linus move ?

At the moment no. I guess when Linus will take patches :-)

> And if i understood you right, ruby is now obsolet, and we should all work
> with the -dj tree ? Does it even make sense to do some work on the older (well
> 2.4 and current 2.5) drivers, or is it not adviseable ?

I wouldn't say obsolete. The input stuff just got syned to the -dj tree.
So ruby and -dj tree are almost the same in this case. I'm going to work
on drivers/char/keyboard.c today to make it work with the input layer
directly instead of going threw keybdev.c in drivers/input then pc_keyb.c 
as it does now. It still will work the old way tho as well. Thsi is for
the keyboard drivers not ported over to the input api.

NOTE: keyboard maintainers please move your drivers over to the input api. 
It will speed up the transition.


As for the fbdev layer. Their was way to much code to cleanup and maintain
in sync. So ruby had hardly any fbdev ported over :-( Now I'm spending the
time to port every single fbdev driver over. Alot of work but it is
needed.

> BTW, romain, i have built pm3fb with 2.5.2, there were some modifications
> needed, the major of them was the testing for 2.2 or 2.4 kernels that needed
> changing, and the new info.node, which needed to be changed to
> info.node.values.

The correct fix is to do something like fb_info.node = NODEV;

> Also, i tried Petr's suggestions for the corruption while changing from vgacon
> to pm3fb, but it didn't work, i will have to look more in detail about it, i
> remember X had some similar problems with textmode, where the switching to X
> and back corrupted the fonts, which were supposed to be saved. 

Oh. That will not be fixed for awhile in the upper console layers. I did
have a fix for those sort of problems. 

> > That is my fault :-( I have been so busy coding I haven't written any
> > docs. 
> 
> ... I imagined such. What is the best why to understand how all this works in
> order to port the pm3fb driver to the new setup (well there is already
> something in there, but it does not work, and romain has only a ppc box, on
> which ruby did not work anyway, i guess once pm3fb + new fbdev works on i386,
> it would be easier for him to look at the ppc particularities.

Right now the changes have been the moving of fb_blank from struct fb_info
to struct fb_ops. I placed xxfb_setcolreg into struct fb_ops. I just sent
a patch in to remove struct fbcon_cmap and use instead pseudo_palette in
struct fb_info. I now have every driver compiled with fbgen.c. This allows
us to use one function at a time in fbgen.c. Right now most drivers use
do_install_cmap and fbgen_set_cmap in fbgen.c instead of their own
functions.

