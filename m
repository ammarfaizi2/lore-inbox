Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S287629AbSAEJzT>; Sat, 5 Jan 2002 04:55:19 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S287644AbSAEJzJ>; Sat, 5 Jan 2002 04:55:09 -0500
Received: from leibniz.math.psu.edu ([146.186.130.2]:29151 "EHLO math.psu.edu")
	by vger.kernel.org with ESMTP id <S287641AbSAEJy6>;
	Sat, 5 Jan 2002 04:54:58 -0500
Date: Sat, 5 Jan 2002 04:54:39 -0500 (EST)
From: Alexander Viro <viro@math.psu.edu>
To: Daniel Phillips <phillips@bonn-fries.net>
cc: linux-kernel@vger.kernel.org,
        Arnaldo Carvalho de Melo <acme@conectiva.com.br>
Subject: Re: [CFT] Unbork fs.h + per-fs supers
In-Reply-To: <E16MnM9-0001Fu-00@starship.berlin>
Message-ID: <Pine.GSO.4.21.0201050448280.29230-100000@weyl.math.psu.edu>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Sat, 5 Jan 2002, Daniel Phillips wrote:

> Adding VFS support for per-fs superblock size was dead simple compared to 
> doing the inodes because superblocks are few enough that no slab cache is 
> needed, and also because of cleanup Al had already done.

*Stop*.

First of all, exporting size of superblock is wrong, since the entire
->read_super() mechanism is going to be replaced with ->get_super(type, ...)
(get_sb_...() becoming commonly used instances of the method).  Moreover,
freeing superblock is very likely to become a method (for quite a few
reasons).

Please, don't turn fs type into a bloody mess.  It's bad enough as it
is; at least don't add the stuff that will go away anyway.

