Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S266763AbSLUHYT>; Sat, 21 Dec 2002 02:24:19 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S266765AbSLUHYT>; Sat, 21 Dec 2002 02:24:19 -0500
Received: from adsl-206-170-148-147.dsl.snfc21.pacbell.net ([206.170.148.147]:4360
	"EHLO gw.goop.org") by vger.kernel.org with ESMTP
	id <S266763AbSLUHYS>; Sat, 21 Dec 2002 02:24:18 -0500
Subject: Re: Valgrind meets UML
From: Jeremy Fitzhardinge <jeremy@goop.org>
To: Jeff Dike <jdike@karaya.com>
Cc: John Reiser <jreiser@BitWagon.com>,
       Linux Kernel List <linux-kernel@vger.kernel.org>,
       Julian Seward <jseward@acm.org>
In-Reply-To: <200212210249.VAA04704@ccure.karaya.com>
References: <200212210249.VAA04704@ccure.karaya.com>
Content-Type: text/plain
Organization: 
Message-Id: <1040455941.1841.123.camel@ixodes.goop.org>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.2.1 
Date: 20 Dec 2002 23:32:21 -0800
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 2002-12-20 at 18:49, Jeff Dike wrote:
> jreiser@BitWagon.com said:
> > I suggest that useful partial progress can be made sooner by
> > identifying the allocators, telling valgrind about them and their
> > external semantics, and having valgrind trust them.  
> 
> This is likely what will happen anyway.  It will likely generate noise
> from inside the allocators until they are described.

It probably won't be the allocators which generate warnings.  The main
problem will be that newly allocated memory will still be considered
initialized by its previous owner.  Also, if UML allocates memory using
mmap, all memory will be considered to be initialized.

> > Waiting for the globally correct description can take a long time,
> > perhaps about as long as waiting for the authors of device drivers to
> > update to a new device I/O model.
> 
> Nonsense.  They aren't going to be that complicated, and they don't change
> very often anyway.

Doing a few base-level allocators first (get_free_page, kmalloc) will
find lots of problems, then you can start refining to the more
specialized allocators.

	J

