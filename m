Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S276707AbRJ0TQ1>; Sat, 27 Oct 2001 15:16:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S276695AbRJ0TQR>; Sat, 27 Oct 2001 15:16:17 -0400
Received: from leibniz.math.psu.edu ([146.186.130.2]:15513 "EHLO math.psu.edu")
	by vger.kernel.org with ESMTP id <S276708AbRJ0TQH>;
	Sat, 27 Oct 2001 15:16:07 -0400
Date: Sat, 27 Oct 2001 15:16:39 -0400 (EDT)
From: Alexander Viro <viro@math.psu.edu>
To: linux-kernel@vger.kernel.org
cc: Linus Torvalds <torvalds@transmeta.com>,
        Richard Gooch <rgooch@ras.ucalgary.ca>
Subject: Re: more devfs fun
In-Reply-To: <Pine.GSO.4.21.0110271458300.21545-100000@weyl.math.psu.edu>
Message-ID: <Pine.GSO.4.21.0110271513580.21545-100000@weyl.math.psu.edu>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

	It just gets better and better...

in get_removable_partition()
        if (strcmp (de->name, "disc") == 0) return check_disc_changed (de);

with 
    if ( name && (namelen < 1) ) namelen = strlen (name);
    if ( ( new = kmalloc (sizeof *new + namelen, GFP_KERNEL) ) == NULL )
        return NULL;
...
    if (name) memcpy (new->name, name, namelen);

in create_entry().

IOW, ->name is not NUL-terminated.

