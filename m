Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S315539AbSECCgk>; Thu, 2 May 2002 22:36:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S315540AbSECCgj>; Thu, 2 May 2002 22:36:39 -0400
Received: from gateway2.ensim.com ([65.164.64.250]:16647 "EHLO
	nasdaq.ms.ensim.com") by vger.kernel.org with ESMTP
	id <S315539AbSECCgj>; Thu, 2 May 2002 22:36:39 -0400
X-Mailer: exmh version 2.5 01/15/2001 with nmh-1.0
From: Paul Menage <pmenage@ensim.com>
To: Alexander Viro <viro@math.psu.edu>
cc: linux-kernel@vger.kernel.org
Subject: Re: [PATCH] Replace exec_permission_lite() with inlined vfs_permission() 
cc: pmenage@ensim.com
In-Reply-To: Your message of "Thu, 02 May 2002 22:16:37 EDT."
             <Pine.GSO.4.21.0205022159040.17171-100000@weyl.math.psu.edu> 
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Date: Thu, 02 May 2002 19:36:23 -0700
Message-Id: <E173Svn-0004LE-00@pmenage-dt.ensim.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>
>IMO it's a bad idea.  In many cases we have ->permission() but it's
>perfectly OK with being called under dcache_lock - either always or
>in (fs-specific) "fast case".
>
>I would prefer ->permission_light() that would always be called
>under dcache_lock and besides the usual values could return -EAGAIN.
>In that case ->permission() would be called in a normal way.
>

OK - a few details/matters of taste:

- how about similar dcache_lock-safe versions of d_op->revalidate()
and i_op->follow_link()?

- an alternative to separate methods is to add a "noblock" argument 
to the existing methods. This entails more breakage in the short term.

- permission_light() or permission_lite()? :-)

Paul

