Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S318529AbSGaVKV>; Wed, 31 Jul 2002 17:10:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S318516AbSGaVKV>; Wed, 31 Jul 2002 17:10:21 -0400
Received: from leibniz.math.psu.edu ([146.186.130.2]:23801 "EHLO math.psu.edu")
	by vger.kernel.org with ESMTP id <S318529AbSGaVKU>;
	Wed, 31 Jul 2002 17:10:20 -0400
Date: Wed, 31 Jul 2002 17:13:46 -0400 (EDT)
From: Alexander Viro <viro@math.psu.edu>
To: Jan Harkes <jaharkes@cs.cmu.edu>
cc: "Peter J. Braam" <braam@clusterfs.com>, linux-kernel@vger.kernel.org
Subject: Re: BIG files & file systems
In-Reply-To: <20020731210739.GA15492@ravel.coda.cs.cmu.edu>
Message-ID: <Pine.GSO.4.21.0207311711540.8505-100000@weyl.math.psu.edu>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Wed, 31 Jul 2002, Jan Harkes wrote:

> On Wed, Jul 31, 2002 at 01:16:20PM -0600, Peter J. Braam wrote:
> > Hi, 
> > 
> > I've just been told that some "limitations" of the following kind will
> > remain:
> >   page index = unsigned long
> >   ino_t      = unsigned long
> 
> The number of files is not limited by ino_t, just look at the
> iget5_locked operation in fs/inode.c. It is possible to have your own
> n-bit file identifier, and simply provide your own comparison function.
> The ino_t then becomes the 'hash-bucket' in which the actual inode is
> looked up.

You _do_ need unique ->st_ino from stat(2), though - otherwise tar(1)
and friends will break in all sorts of amusing ways.  And there's
nothing kernel can do about that - applications expect 32bit st_ino
(compare them as 32bit values, etc.)

