Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261819AbREPHnz>; Wed, 16 May 2001 03:43:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261820AbREPHnp>; Wed, 16 May 2001 03:43:45 -0400
Received: from leibniz.math.psu.edu ([146.186.130.2]:6045 "EHLO math.psu.edu")
	by vger.kernel.org with ESMTP id <S261819AbREPHni>;
	Wed, 16 May 2001 03:43:38 -0400
Date: Wed, 16 May 2001 03:43:37 -0400 (EDT)
From: Alexander Viro <viro@math.psu.edu>
To: Kai Henningsen <kaih@khms.westfalen.de>
cc: linux-kernel@vger.kernel.org
Subject: Re: LANANA: To Pending Device Number Registrants
In-Reply-To: <80x0jOtXw-B@khms.westfalen.de>
Message-ID: <Pine.GSO.4.21.0105160335030.24199-100000@weyl.math.psu.edu>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On 16 May 2001, Kai Henningsen wrote:

> hpa@transmeta.com (H. Peter Anvin)  wrote on 15.05.01 in <3B01A044.F72BFDD1@transmeta.com>:
> 
> > Personally, I would also like to see network devices manifest in the
> > filesystem namespace like everything else.
> 
> Yes.
> 
> Can we have a meta-rule?
> 
> *Every* by-name kernel interface should have a filesystem variant.
> 
> That is, if there's a kernel interface where you give the kernel a string  
> to identify an in-kernel object, there should be some place in the file  
> system (after mounting any prerequisites) that will respond to a path  
> ending in that name.

You'll get in trouble with that in exactly one case: filesystem types.
No, it would make a lot of sense to have them as fs objects. For one
thing, we could turn mount(2) into
	open appropriate fs type
	convince the sucker that you are allowed, tell which device you want,
etc.
	open mountpoint
	mount(fs_fd, dir_fd)
Would work like charm, especially since we could fit the network filesystems
into the same scheme and get rid of the kludges a-la ncpfs mount sequence.

There's only one sore spot: how'd you mount _that_ fs? ;-)

