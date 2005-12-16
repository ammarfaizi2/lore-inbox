Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932390AbVLPTGf@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932390AbVLPTGf (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 16 Dec 2005 14:06:35 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932375AbVLPTGf
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 16 Dec 2005 14:06:35 -0500
Received: from inti.inf.utfsm.cl ([200.1.21.155]:4768 "EHLO inti.inf.utfsm.cl")
	by vger.kernel.org with ESMTP id S932396AbVLPTGe (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 16 Dec 2005 14:06:34 -0500
Message-Id: <200512161903.jBGJ3EnR003647@laptop11.inf.utfsm.cl>
To: Adrian Bunk <bunk@stusta.de>
cc: Neil Brown <neilb@suse.de>, Dave Jones <davej@redhat.com>,
       Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org,
       arjan@infradead.org, xfs-masters@oss.sgi.com, nathans@sgi.com
Subject: Re: [2.6 patch] i386: always use 4k stacks 
In-Reply-To: Message from Adrian Bunk <bunk@stusta.de> 
   of "Fri, 16 Dec 2005 13:18:05 BST." <20051216121805.GX23349@stusta.de> 
X-Mailer: MH-E 7.4.2; nmh 1.1; XEmacs 21.4 (patch 18)
Date: Fri, 16 Dec 2005 16:03:14 -0300
From: Horst von Brand <vonbrand@inf.utfsm.cl>
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-2.0b5 (inti.inf.utfsm.cl [200.1.19.1]); Fri, 16 Dec 2005 16:03:30 -0300 (CLST)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Adrian Bunk <bunk@stusta.de> wrote:
> On Fri, Dec 16, 2005 at 01:56:58PM +1100, Neil Brown wrote:

[...]

> gcc can figure out itself that static functions called only once should 
> be inline (except currently on i386 due to no-unit-at-a-time, see 
> below).
> 
> > These add up to over 300 bytes on the stack.
> > Looking at each of these, I see that nfsd_write (which includes
> >  nfsd_vfs_write) contributes 0x8c to stack usage itself!!
> > 
> > It turns out this is because it puts a 'struct iattr' on the stack so
> > it can kill suid if needed.  The following patch saves about 50 bytes
> > off the stack in this call path.
> >...

And if you set up a compound literal for the task then? It is just used to
shove data into the called function.

My short test case (attached) has a smaller stack with the compound
literal (gcc-4.1, Fedora rawhide on i686), and IMHO it is clearer what is
going on here.

> This works currently on i386 (and only on i386) because we are using 
> -fno-unit-at-a-time there.
> 
> In the medium-term, we want to get rid of no-unit-at-a-time because this 
> makes the code both bigger and slower, and I'm therefore not a big fan 
> of this kind of workarounds.
> 
> If this struct is really a problem (which I doubt considering it's 
> size), I'd prefer it being kmalloc'ed.

Nodz.
-- 
Dr. Horst H. von Brand                   User #22616 counter.li.org
Departamento de Informatica                     Fono: +56 32 654431
Universidad Tecnica Federico Santa Maria              +56 32 654239
Casilla 110-V, Valparaiso, Chile                Fax:  +56 32 797513
