Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266901AbUH1GOR@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266901AbUH1GOR (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 28 Aug 2004 02:14:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266898AbUH1GOR
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 28 Aug 2004 02:14:17 -0400
Received: from omx3-ext.sgi.com ([192.48.171.20]:15316 "EHLO omx3.sgi.com")
	by vger.kernel.org with ESMTP id S266891AbUH1GOM (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 28 Aug 2004 02:14:12 -0400
Date: Fri, 27 Aug 2004 23:08:57 -0700
From: Paul Jackson <pj@sgi.com>
To: Hans Reiser <reiser@namesys.com>
Cc: riel@redhat.com, ninja@slaphack.com, torvalds@osdl.org,
       diegocg@teleline.es, jamie@shareable.org, christophe@saout.de,
       vda@port.imtp.ilyichevsk.odessa.ua, christer@weinigel.se,
       spam@tnonline.net, akpm@osdl.org, wichert@wiggy.net, jra@samba.org,
       hch@lst.de, linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
       flx@namesys.com, reiserfs-list@namesys.com
Subject: Re: silent semantic changes with reiser4
Message-Id: <20040827230857.69340aec.pj@sgi.com>
In-Reply-To: <412F7D63.4000109@namesys.com>
References: <Pine.LNX.4.44.0408271043090.10272-100000@chimarrao.boston.redhat.com>
	<412F7D63.4000109@namesys.com>
Organization: SGI
X-Mailer: Sylpheed version 0.9.12 (GTK+ 1.2.10; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hans wrote:
> We create filename/pseudos/backup, and that tells the archiver what to 
> do.....

Instead of exposing the old semantics under a new interface, why not
expose the new semantics under a new interface.

There exist plenty of programs that know the old Unix semantics.  There
don't exist many working programs that use the new semantics that you're
adding.

I raise again the example of how Windows adapted to long filenames.  Old
DOS and FAT programs, including my Unix backups of today, see a 8.3 name
space.  Only code that knows the new magic sees the long names.

If given the choice of breaking much old, existing stuff, or some new,
mostly not yet existing stuff, does not it make more sense to break what
mostly doesn't exist yet?

One possible way to do this, of no doubt many:

 * Stealing a corner of the existing filename space for
   some magic names with the new semantics.

 * A new option on open(2), hence opendir(3), that lights up
   these magic names.

 * Doing any of the classic pathname calls with such a
   new magic name exposes the new semantics - such calls
   as:
	access execve mkdir mknod mount readlink
	rename rmdir stat truncate unlink

This means essentially constructing a map between old and new,
such that changes made in either view are sane and visible
from the other view.

-- 
                          I won't rest till it's the best ...
                          Programmer, Linux Scalability
                          Paul Jackson <pj@sgi.com> 1.650.933.1373
