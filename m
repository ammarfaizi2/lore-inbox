Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266804AbUFYRJJ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266804AbUFYRJJ (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 25 Jun 2004 13:09:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266795AbUFYRJJ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 25 Jun 2004 13:09:09 -0400
Received: from inti.inf.utfsm.cl ([200.1.21.155]:39878 "EHLO inti.inf.utfsm.cl")
	by vger.kernel.org with ESMTP id S266806AbUFYRII (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 25 Jun 2004 13:08:08 -0400
Message-Id: <200406251707.i5PH7KOw009004@eeyore.valparaiso.cl>
To: Pavel Machek <pavel@ucw.cz>
cc: Horst von Brand <vonbrand@inf.utfsm.cl>, Amit Gud <gud@eth.net>,
       alan <alan@clueserver.org>,
       "Fao, Sean" <Sean.Fao@dynextechnologies.com>,
       linux-kernel@vger.kernel.org
Subject: Re: Elastic Quota File System (EQFS) 
In-Reply-To: Message from Pavel Machek <pavel@ucw.cz> 
   of "Fri, 25 Jun 2004 18:25:37 +0200." <20040625162537.GA6201@elf.ucw.cz> 
X-Mailer: MH-E 7.4.2; nmh 1.0.4; XEmacs 21.4 (patch 14)
Date: Fri, 25 Jun 2004 13:07:20 -0400
From: Horst von Brand <vonbrand@inf.utfsm.cl>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Pavel Machek <pavel@ucw.cz> said:
> Hi!
> 
> > Case closed, anyway. It belongs in the kernel only if there is no
> > reasonable way to do it in userspace.
> 
> But... there's no reasonable way to do this in userspace.

Let's see...

> Two pieces of kernel support are needed:
> 
> 1) some way to indicate "this file is elastic" (okay perhaps xattrs
> can do this already)

Or just a list of elastic files in ~/.elastic. Even better, could mark them
as "Just delete", "compress"; could go as far as giving (fallback?) globs
to select files for each treatment ("If space gets tight, delete *~ files,
and compress *.tex that haven't been read in a week"). Sounds like a fun
Perl project...

> and either
> 
> 2a) file selection/deletion in kernel

A daemon or cron job running as root can do that just fine. Or you can set
it up for your own files.

> or

> 2b) assume that disk does not fill up faster than 1GB/sec, allways
> keep 1GB free, make "deleting" daemon poll each second [ugly,
> unreliable]

Buy a larger disk. Make sure sum of all hard quotas is less than filesystem
size. Need that anyway; so it reduces to a one-user problem with per-user
solutions. 

> or

> 2c) just before returning -ENOSPC, synchronously tell userspace to
> free space, and retry the operation.

Ugly.

> BTW 2c) would be also usefull for undelete. Unfortunately 2c looks
> very complex, too; it might be easier to do 2a than 2c.

As said, all this buys very little for a lot of hairy code in the kernel,
which will be rarely used (and whose bugs will show up when it is badly
needed to work right). Besides, I strongly oppose automatic file
disposal. I love the Unix way exactly because I decide what to do (no "I
know better than you what to do", "you dumb user aren't supposed to do
that, so you have no right to know", no "undelete deleted files, but only
sometimes; it just might still be around, but if space got tight it isn't"
(this is even worse...))
-- 
Dr. Horst H. von Brand                   User #22616 counter.li.org
Departamento de Informatica                     Fono: +56 32 654431
Universidad Tecnica Federico Santa Maria              +56 32 654239
Casilla 110-V, Valparaiso, Chile                Fax:  +56 32 797513
