Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261438AbVAXEvS@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261438AbVAXEvS (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 23 Jan 2005 23:51:18 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261439AbVAXEvS
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 23 Jan 2005 23:51:18 -0500
Received: from fiura.inf.utfsm.cl ([200.1.19.5]:15496 "EHLO fiura.inf.utfsm.cl")
	by vger.kernel.org with ESMTP id S261438AbVAXEvN (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 23 Jan 2005 23:51:13 -0500
Message-Id: <200501240402.j0O42iOn010758@laptop11.inf.utfsm.cl>
To: Matt Mackall <mpm@selenic.com>
cc: Andi Kleen <ak@muc.de>, Felipe Alfaro Solana <lkml@mac.com>,
       Trond Myklebust <trond.myklebust@fys.uio.no>,
       linux-kernel@vger.kernel.org, Buck Huppmann <buchk@pobox.com>,
       Neil Brown <neilb@cse.unsw.edu.au>,
       Andreas Gruenbacher <agruen@suse.de>,
       "Andries E. Brouwer" <Andries.Brouwer@cwi.nl>,
       Andrew Morton <akpm@osdl.org>, Olaf Kirch <okir@suse.de>
Subject: Re: [patch 1/13] Qsort 
In-Reply-To: Message from Matt Mackall <mpm@selenic.com> 
   of "Sat, 22 Jan 2005 20:29:30 -0800." <20050123042930.GI3867@waste.org> 
X-Mailer: MH-E 7.4.2; nmh 1.0.4; XEmacs 21.4 (patch 15)
Date: Mon, 24 Jan 2005 01:02:44 -0300
From: Horst von Brand <vonbrand@laptop11.inf.utfsm.cl>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Matt Mackall <mpm@selenic.com> said:
> On Sun, Jan 23, 2005 at 03:39:34AM +0100, Andi Kleen wrote:

[...]

> > -Andi (who thinks the glibc qsort is vast overkill for kernel purposes
> > where there are only small data sets and it would be better to use a 
> > simpler one optimized for code size)

> Mostly agreed. Except:
> 
> a) the glibc version is not actually all that optimized
> b) it's nice that it's not recursive
> c) the three-way median selection does help avoid worst-case O(n^2)
> behavior, which might potentially be triggerable by users in places
> like XFS where this is used

Shellsort is much simpler, and not much slower for small datasets. Plus no
extra space for stacks.

> I'll probably whip up a simpler version tomorrow or Monday and do some
> size/space benchmarking. I've been meaning to contribute a qsort for
> doubly-linked lists I've got lying around as well.

Qsort is OK as long as you have direct access to each element. In case of
lists, it is better to just use mergesort.
-- 
Dr. Horst H. von Brand                   User #22616 counter.li.org
Departamento de Informatica                     Fono: +56 32 654431
Universidad Tecnica Federico Santa Maria              +56 32 654239
Casilla 110-V, Valparaiso, Chile                Fax:  +56 32 797513
