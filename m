Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266797AbUFYQqE@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266797AbUFYQqE (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 25 Jun 2004 12:46:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266795AbUFYQqD
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 25 Jun 2004 12:46:03 -0400
Received: from 216-99-213-120.dsl.aracnet.com ([216.99.213.120]:65198 "EHLO
	clueserver.org") by vger.kernel.org with ESMTP id S266797AbUFYQo5
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 25 Jun 2004 12:44:57 -0400
Subject: Re: Elastic Quota File System (EQFS)
From: Alan <alan@clueserver.org>
To: Pavel Machek <pavel@ucw.cz>
Cc: Horst von Brand <vonbrand@inf.utfsm.cl>, Amit Gud <gud@eth.net>,
       "Fao, Sean" <Sean.Fao@dynextechnologies.com>,
       linux-kernel@vger.kernel.org
In-Reply-To: <20040625162537.GA6201@elf.ucw.cz>
References: <004e01c45abd$35f8c0b0$b18309ca@home>
	 <200406251444.i5PEiYpq008174@eeyore.valparaiso.cl>
	 <20040625162537.GA6201@elf.ucw.cz>
Content-Type: text/plain
Message-Id: <1088181893.6558.12.camel@zontar.fnordora.org>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6 (1.4.6-2) 
Date: Fri, 25 Jun 2004 09:44:54 -0700
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 2004-06-25 at 09:25, Pavel Machek wrote:
> Hi!
> 
> > Case closed, anyway. It belongs in the kernel only if there is no
> > reasonable way to do it in userspace.
> 
> But... there's no reasonable way to do this in userspace.
> 
> Two pieces of kernel support are needed:
> 
> 1) some way to indicate "this file is elastic" (okay perhaps xattrs
> can do this already)
> 
> and either
> 
> 2a) file selection/deletion in kernel
> 
> or
> 
> 2b) assume that disk does not fill up faster than 1GB/sec, allways
> keep 1GB free, make "deleting" daemon poll each second [ugly,
> unreliable]
> 
> or
> 
> 2c) just before returning -ENOSPC, synchronously tell userspace to
> free space, and retry the operation.
> 
> BTW 2c) would be also usefull for undelete. Unfortunately 2c looks
> very complex, too; it might be easier to do 2a than 2c.

Why does the kernel have to get involved with file deletion?

All it needs is to run at sufficient privs.

If you are overflowing drives that easily, it is time to buy a bigger
drive.  It is not the time to start deleting stuff at random.  Data is
usually put on a drive for a reason.  Having a human decide what to
delete is *much* better than letting some automated process do it in
background.

This sounds like a hack to get around a badly designed system with too
few resources.

Windows has an option to delete files "that are not needed".  It tends
to delete things that you wanted, but had not thought about in a while.

This really strikes me as a bad idea.  It has lots of "special" things
that programs will have to deal with for this particular case. 
This makes things much more complex in userspace for a problem that
needs to be dealt with in meatspace.

-- 
"Ye have locked yerselves up in cages of fear--and, behold, do ye now
complain that ye lack FREEDOM!"
  - Lord Omar in THE EPISTLE TO THE PARANOIDS Chaper 1 Verse 1


