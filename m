Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264883AbTLFARu (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 5 Dec 2003 19:17:50 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264881AbTLFARu
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 5 Dec 2003 19:17:50 -0500
Received: from gaia.cela.pl ([213.134.162.11]:59400 "EHLO gaia.cela.pl")
	by vger.kernel.org with ESMTP id S264868AbTLFARr (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 5 Dec 2003 19:17:47 -0500
Date: Sat, 6 Dec 2003 01:15:20 +0100 (CET)
From: Maciej Zenczykowski <maze@cela.pl>
To: Matthew Wilcox <willy@debian.org>
cc: Erez Zadok <ezk@cs.sunysb.edu>,
       =?iso-8859-1?Q?J=F6rn?= Engel <joern@wohnheim.fh-wedel.de>,
       Phillip Lougher <phillip@lougher.demon.co.uk>,
       Kallol Biswas <kbiswas@neoscale.com>, <linux-kernel@vger.kernel.org>,
       "linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>
Subject: Re: partially encrypted filesystem
In-Reply-To: <20031205202838.GD29469@parcelfarce.linux.theplanet.co.uk>
Message-ID: <Pine.LNX.4.44.0312060112450.11626-100000@gaia.cela.pl>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> But the genius is that you don't need to calculate anything.  If the
> data block turns out to be incompressible (those damn .tar.bz2s!), you
> just write the block in-place.  If it is compressible, you write as much
> into that block's entry as you need and leave a gap.  The underlying
> file system doesn't write any data there.  There's no need for an index
> file -- you know exactly where to start reading each block.

You are pushing this down to the file system.  I'd venture too say that 
this will majorly stress the fs code, make its indexing slower and 
majorly fragment the file on disk (if it's later overwritten).  Sure - you 
have less work to do (less to code) - but the end effect might be 
painful, especially on often written files (if the file ain't written to 
then there are much better compression solutions).

Cheers,
MaZe.


