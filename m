Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S314057AbSDZR0w>; Fri, 26 Apr 2002 13:26:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S314082AbSDZR0v>; Fri, 26 Apr 2002 13:26:51 -0400
Received: from leibniz.math.psu.edu ([146.186.130.2]:26584 "EHLO math.psu.edu")
	by vger.kernel.org with ESMTP id <S314057AbSDZR0u>;
	Fri, 26 Apr 2002 13:26:50 -0400
Date: Fri, 26 Apr 2002 13:26:45 -0400 (EDT)
From: Alexander Viro <viro@math.psu.edu>
To: Andrew Morton <akpm@zip.com.au>
cc: maneesh@in.ibm.com, LKML <linux-kernel@vger.kernel.org>
Subject: Re: [RFC] link_path_walk cleanup
In-Reply-To: <3CC982FC.C2B6F099@zip.com.au>
Message-ID: <Pine.GSO.4.21.0204261318110.22065-100000@weyl.math.psu.edu>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Fri, 26 Apr 2002, Andrew Morton wrote:

> Maneesh Soni wrote:
> > 
> >..
> > +static inline int walk_one(struct nameidata *nd)
> 
> This function is hundreds and hundreds of bytes of code.  It has
> three call sites.  Making it an inline is very inefficient!

Unfortunately, this is a very special case.  This sucker is involved
in mutual recursion and extra frame on stack will be nasty for, say it,
sparc.  Normally I would agree that something of that kind should not be
inlined, but...

