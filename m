Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267578AbRGNF6i>; Sat, 14 Jul 2001 01:58:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267579AbRGNF63>; Sat, 14 Jul 2001 01:58:29 -0400
Received: from leibniz.math.psu.edu ([146.186.130.2]:65014 "EHLO math.psu.edu")
	by vger.kernel.org with ESMTP id <S267578AbRGNF6O>;
	Sat, 14 Jul 2001 01:58:14 -0400
Date: Sat, 14 Jul 2001 01:58:15 -0400 (EDT)
From: Alexander Viro <viro@math.psu.edu>
To: Kai Henningsen <kaih@khms.westfalen.de>
cc: linux-kernel@vger.kernel.org
Subject: Re: Question about ext2
In-Reply-To: <84l4sXb1w-B@khms.westfalen.de>
Message-ID: <Pine.GSO.4.21.0107140151420.19749-100000@weyl.math.psu.edu>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On 13 Jul 2001, Kai Henningsen wrote:

> viro@math.psu.edu (Alexander Viro)  wrote on 13.07.01 in <Pine.GSO.4.21.0107130623510.17323-100000@weyl.math.psu.edu>:
> 
> > The only really obscure part is dropping an extra reference if victim is
> > a directory - then we know that we are cannibalizing the last external
> > link to it and the only link that remains is victim's ".". We don't want
> > it to prevent victim's removal, so we drive i_nlink of victim to zero.
> 
> Does this stuff work right with those cases which do linkcount=1 either  
> because the fs doesn't have a link count, or because the real link count  
> has grown too large?

It doesn't. If fs doesn't have link count you are very likely to need
other ways to deal with rename() anyway (e.g. you are pretty likely to
have part of metadata stored in directory entry). If you are playing
with "set i_nlink to 1 if it's too large" (which works only for directories,
BTW) - change according to your encoding scheme for link count.

