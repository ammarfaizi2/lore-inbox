Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264851AbUGBSNL@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264851AbUGBSNL (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 2 Jul 2004 14:13:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264858AbUGBSNL
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 2 Jul 2004 14:13:11 -0400
Received: from mlf.linux.rulez.org ([192.188.244.13]:5646 "EHLO
	mlf.linux.rulez.org") by vger.kernel.org with ESMTP id S264851AbUGBSNB
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 2 Jul 2004 14:13:01 -0400
Date: Fri, 2 Jul 2004 20:12:59 +0200 (MEST)
From: Szakacsits Szabolcs <szaka@sienet.hu>
To: Andries Brouwer <Andries.Brouwer@cwi.nl>
Cc: "Patrick J. LoPresti" <patl@users.sourceforge.net>, bug-parted@gnu.org,
       "K.G." <k_guillaume@libertysurf.fr>,
       Steffen Winterfeldt <snwint@suse.de>, Thomas Fehr <fehr@suse.de>,
       linux-kernel@vger.kernel.org
Subject: Re: [RFC] Restoring HDIO_GETGEO semantics (was: Re: workaround for
 BIOS / CHS stuff)
In-Reply-To: <20040702170410.GC25914@apps.cwi.nl>
Message-ID: <Pine.LNX.4.21.0407021936550.30622-100000@mlf.linux.rulez.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Fri, 2 Jul 2004, Andries Brouwer wrote:
> On Fri, Jul 02, 2004 at 06:17:53PM +0200, Szakacsits Szabolcs wrote:
> 
> > Does anybody find the new HDIO_GETGEO semantic useful? Did it help
> > _anything_? 
> 
> Yes. I do.
> 
> There was a steady stream of people reporting on geometry problems.
> All these problems were caused by kernel guessing stuff.

True, I'm well aware that old kernels guessed wrong geometries sometimes,
resulting totally trashed partitions. However far not as much as
currently. Perhaps the steady stream started also when the HDIO_GETGEO
semantic was changed and more people started to use 2.5 and 2.6 kernels.

Two choices to "fix" this guess game:

    1) return error ("I don't know") but providing compatibility
       functionality for things that the kernel knows (e.g. where the
       partition starts). 

    2) use EDD, it does a much better job -- maybe this suggestions
       doesn't make much sense overall, so only 1) left if you don't 
       want to keep guessing.

Instead the HDIO_GETGEO change was a non-sense semantic one, AFAIS. It
doesn't fix anything apparently, only broke _even_ more by not even
guessing just providing some values.

Please correct me if I'm wrong.

> If the kernel no longer volunteers a guess, then we no longer have
> the situation that the guess can be wrong.

The problem is, the kernel still _guesses_ (even potential hard coded
values are guesses). And now it's even more broken than before. 

This is why I asked _what_ it fixed, not from maintaince but from
functionality point of view.

In short, 2.4 was slightly broken, 2.6 is badly broken. Less maintaince
isn't a good argument because deleting the code would have been a much
better solution: it wouldn't break so many things and even if it did,
developers would have notice (function return error that must be always
handled).
 
> The new world is getting much simpler. 

Unfortunately it seems it's more messed up. You didn't write any specific
why the current situation would be better. What does HDIO_GETGEO returns
at present? Hard coded values? Random values? Then why not error instead?

> The only case I see where absolutely something is needed is the
> case of partitioning an empty disk.

Recovery, cloning, ... just unpack a major distro source and grep for
HDIO_GETGEO and you'll see how many things use it for all kind of
purposes.

	Szaka

