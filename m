Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262647AbREVQky>; Tue, 22 May 2001 12:40:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262633AbREVQko>; Tue, 22 May 2001 12:40:44 -0400
Received: from leibniz.math.psu.edu ([146.186.130.2]:25995 "EHLO math.psu.edu")
	by vger.kernel.org with ESMTP id <S262629AbREVQk2>;
	Tue, 22 May 2001 12:40:28 -0400
Date: Tue, 22 May 2001 12:40:26 -0400 (EDT)
From: Alexander Viro <viro@math.psu.edu>
To: Jean-Marc Saffroy <saffroy@ri.silicomp.fr>
cc: linux-kernel@vger.kernel.org
Subject: Re: [Q] [VFS] i_mapping vs. i_data ?
In-Reply-To: <Pine.LNX.4.31.0105221813030.29327-100000@sisley.ri.silicomp.fr>
Message-ID: <Pine.GSO.4.21.0105221234350.15685-100000@weyl.math.psu.edu>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Tue, 22 May 2001, Jean-Marc Saffroy wrote:

> Hello,
> 
> I have the following question for VFS gurus here:
> 
> In the inode struct, an address_space (i_data) and a pointer to an
> address_space (i_mapping) are defined, and it looks like i_mapping is
> always a reference to the inode's i_data (except in coda_open). Then what
> is the difference of meaning between these two ?

i_data is "pages read/written by this inode"
i_mapping is "whom should I ask for pages?"

IOW, everything outside of individual filesystems should use the latter.
They are same if (and only if) inode owns the data. CODA (or anything that
caches data on a local fs) will have i_mapping pointing to the i_data of
inode it caches into. Ditto for block devices if/when they go into pagecache -
we should associate pagecache with struct block_device, since we can have
many inodes with the same major:minor. IOW, ->i_mapping should be pointing
to the same place for all of them.

