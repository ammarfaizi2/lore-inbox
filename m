Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262707AbUKWMHO@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262707AbUKWMHO (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 23 Nov 2004 07:07:14 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262523AbUKWMHO
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 23 Nov 2004 07:07:14 -0500
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:30694 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id S262630AbUKWMHG convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 23 Nov 2004 07:07:06 -0500
Date: Tue, 23 Nov 2004 05:27:16 -0200
From: Marcelo Tosatti <marcelo.tosatti@cyclades.com>
To: Linux Mailing Lists <linux@aiind.upv.es>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Problem compiling 2.4.28 [dn_neigh.c]
Message-ID: <20041123072716.GC2712@logos.cnet>
References: <Pine.LNX.4.58.0411201948310.18643@andercheran.aiind.upv.es>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.58.0411201948310.18643@andercheran.aiind.upv.es>
User-Agent: Mutt/1.5.5.1i
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Nov 20, 2004 at 08:16:17PM +0100, Linux Mailing Lists wrote:
> 
> Hello,
> 
> While compiling the lastest 2.4 kernel I stumbled on this error:
> 
> gcc -D__KERNEL__ -I/usr/src/linux-2.4.28/include -Wall -Wstrict-prototypes
> -Wno-trigraphs -O2 -fno-strict-aliasing -fno-common -fomit-frame-pointer
> -pipe -mpreferred-stack-boundary=2 -march=i586  -DMODULE  -nostdinc
> -iwithprefix include -DKBUILD_BASENAME=dn_dev  -c -o dn_dev.o dn_dev.c
> gcc -D__KERNEL__ -I/usr/src/linux-2.4.28/include -Wall -Wstrict-prototypes
> -Wno-trigraphs -O2 -fno-strict-aliasing -fno-common -fomit-frame-pointer
> -pipe -mpreferred-stack-boundary=2 -march=i586  -DMODULE  -nostdinc
> -iwithprefix include -DKBUILD_BASENAME=dn_neigh  -c -o dn_neigh.o
> dn_neigh.c
> dn_neigh.c:584: `THIS_MODULE' undeclared here (not in a function)
> dn_neigh.c:584: initializer element is not constant
> dn_neigh.c:584: (near initialization for `dn_neigh_seq_fops.owner')
> make[2]: *** [dn_neigh.o] Error 1
> make[2]: Leaving directory `/usr/src/linux-2.4.28/net/decnet'
> make[1]: *** [_modsubdir_decnet] Error 2
> make[1]: Leaving directory `/usr/src/linux-2.4.28/net'
> make: *** [_mod_net] Error 2
> 
> I followed the same steps as always to do the compilation:
> 
> - I copied linux-2.4.27/.config to linux-2.4.28/.config
> - I made an "make oldconfig" in the 2.4.28 directory
> - Then I tried to compile the kernel and the modules, as usual, with "make
> dep; make clean; make bzImage; make modules"
> 
> I Googled the archives of the list to see if someone had reported this
> error, but I didn't seem to find anything about it. I found a patch for a
> similar error (from quite a while ago) and tried it, and the compilation
> went fine.
> 
> The patch is very simple, I just added the line:
> 
> #include <linux/module.h>

Yep.

> 
> To dn_neigh.c and ¡voilá! the compilation went without a single warning at
> that point.
> 
> I got this error in three different Linux machines.

Fixed in 2.4 BK tree.

