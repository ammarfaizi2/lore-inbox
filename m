Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265468AbRFVRBZ>; Fri, 22 Jun 2001 13:01:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265469AbRFVRBP>; Fri, 22 Jun 2001 13:01:15 -0400
Received: from leibniz.math.psu.edu ([146.186.130.2]:18933 "EHLO math.psu.edu")
	by vger.kernel.org with ESMTP id <S265468AbRFVRBG>;
	Fri, 22 Jun 2001 13:01:06 -0400
Date: Fri, 22 Jun 2001 13:00:58 -0400 (EDT)
From: Alexander Viro <viro@math.psu.edu>
To: Timur Tabi <ttabi@interactivesi.com>
cc: linux-kernel@vger.kernel.org
Subject: Re: What happened to lookup_dentry?
In-Reply-To: <g_XL8.A.V8G.4n3L7@dinero.interactivesi.com>
Message-ID: <Pine.GSO.4.21.0106221257330.3434-100000@weyl.math.psu.edu>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Tue, 19 Jun 2001, Timur Tabi wrote:

> Well, I didn't write the driver that I'm trying to port, so it's a little
> difficult.  The code in question is:
> 
> struct dentry *	de = lookup_dentry(zfcdb[i].fullname, NULL, LOOKUP_FOLLOW);
> if (IS_ERR(de))
> 	continue;
> if (de != zfcdb[i].dentry) 
> {
> 	print("zfc: dentry changed for %s\n", zfcdb[i].fullname);
> 	zfc_file_init(&zfcdb[i], de);
> }
> 
> So it appears it's just checking to see if the dentry for a particular file has
> changed.

Apparently, more than that. You'll need at least vfsmount in addition to
dentry. Could you send me the source? In principle, situation looks like
you need path_init() and path_walk(), but you almost definitely will need
to make changes in more places than that.

It should be easy to fix, but it's easier to mark the places that need
fixing in the source than try to describe how to find them ;-)

