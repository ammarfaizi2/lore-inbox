Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030296AbVIITTT@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030296AbVIITTT (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 9 Sep 2005 15:19:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030298AbVIITTT
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 9 Sep 2005 15:19:19 -0400
Received: from inti.inf.utfsm.cl ([200.1.21.155]:31882 "EHLO inti.inf.utfsm.cl")
	by vger.kernel.org with ESMTP id S1030296AbVIITTT (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 9 Sep 2005 15:19:19 -0400
Message-Id: <200509091915.j89JFREG011864@laptop11.inf.utfsm.cl>
To: Anton Altaparmakov <aia21@cam.ac.uk>
cc: Pekka J Enberg <penberg@cs.Helsinki.FI>,
       linux-ntfs-dev@lists.sourceforge.net, linux-kernel@vger.kernel.org,
       Linus Torvalds <torvalds@osdl.org>
Subject: Re: [PATCH 2/25] NTFS: Allow highmem kmalloc() in ntfs_malloc_nofs() and add _nofail() version. 
In-Reply-To: Message from Anton Altaparmakov <aia21@cam.ac.uk> 
   of "Fri, 09 Sep 2005 13:08:58 +0100." <1126267738.32261.10.camel@imp.csi.cam.ac.uk> 
X-Mailer: MH-E 7.4.2; nmh 1.1; XEmacs 21.4 (patch 17)
Date: Fri, 09 Sep 2005 15:15:27 -0400
From: Horst von Brand <vonbrand@inf.utfsm.cl>
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-2.0b5 (inti.inf.utfsm.cl [200.1.21.155]); Fri, 09 Sep 2005 15:15:34 -0400 (CLT)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Anton Altaparmakov <aia21@cam.ac.uk> wrote:
> On Fri, 2005-09-09 at 15:02 +0300, Pekka J Enberg wrote:
> > On Fri, 9 Sep 2005, Anton Altaparmakov wrote:

> > > > I completely disagree with you given that this is not "inventing
> > > > [...] own memory allocators", it is just a convenient short hand.
> > > > I am sure a lot of people would agree with you though.  It is just
> > > > a matter of personal preference.

> > > I should add that this is not ntfs only, the idea is from another file
> > > system which uses it, too.  Can't remember which one it was, though (xfs
> > > maybe?).

> > Indeed. It is not just a matter of personal preference but also a matter 
> > of subsystems introducing duplicate code like this. Quick grepping shows 
> > UDF doing same thing  and XFS doing slightly differently but I am pretty 
> > sure I've seen it elsewhere too.

> Yes, that is usually a good indication that a generic function should be
> provided.  However having a generic function with complicated and long
> arguments is no use as everyone will want their own shorter one anyway.
> And given the function is static inline it actually makes no difference
> to the generated code size.  Also calling it __vmalloc_fast makes no
> sense as it doesn't always use vmalloc...  Given we have kmalloc and
> vmalloc maybe it should be just malloc?

That it makes no difference to the generated code isn't enough. If somebody
if going over the kernel with a fine comb trying to fix memory allocations
(example as here), she will have to remember half a dozen slightly
different ways of doing the same thing, for no good reason. And probably
miss a bundle in the process. This is bad in itself.

> Obviously if there were a suitable generic function I would use it but I
> and I imagine all the other users would still wrap it with the old name.

I'd hope not.

[Yes, I can understand that each subsystem has its own "culture", and
 trying to force them all into the same mold is friction too.]
-- 
Dr. Horst H. von Brand                   User #22616 counter.li.org
Departamento de Informatica                     Fono: +56 32 654431
Universidad Tecnica Federico Santa Maria              +56 32 654239
Casilla 110-V, Valparaiso, Chile                Fax:  +56 32 797513
