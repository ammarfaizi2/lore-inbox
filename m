Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S275571AbRJ0TCf>; Sat, 27 Oct 2001 15:02:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S275843AbRJ0TCZ>; Sat, 27 Oct 2001 15:02:25 -0400
Received: from leibniz.math.psu.edu ([146.186.130.2]:48005 "EHLO math.psu.edu")
	by vger.kernel.org with ESMTP id <S275571AbRJ0TCO>;
	Sat, 27 Oct 2001 15:02:14 -0400
Date: Sat, 27 Oct 2001 15:02:46 -0400 (EDT)
From: Alexander Viro <viro@math.psu.edu>
To: linux-kernel@vger.kernel.org
cc: Linus Torvalds <torvalds@transmeta.com>,
        Richard Gooch <rgooch@ras.ucalgary.ca>
Subject: more devfs fun
In-Reply-To: <Pine.GSO.4.21.0110271422520.21545-100000@weyl.math.psu.edu>
Message-ID: <Pine.GSO.4.21.0110271458300.21545-100000@weyl.math.psu.edu>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

	BTW, what the hell is that?
/*
 * hwgraph_bdevsw_get - returns the fops of the given devfs entry.
*/
struct file_operations * 
hwgraph_bdevsw_get(devfs_handle_t de)
{
        return(devfs_get_ops(de));
}

	It's arch/ia64/sn/io/hcl.c.  The funny thing being, the thing
you will get from devfs_get_ops() will _not_ be struct file_operations *.
And that's aside of the fact that any use of that function is very
likely to be racy as hell.  Sigh...

