Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S275082AbRKFFR5>; Tue, 6 Nov 2001 00:17:57 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S276956AbRKFFRr>; Tue, 6 Nov 2001 00:17:47 -0500
Received: from vindaloo.ras.ucalgary.ca ([136.159.55.21]:25532 "EHLO
	vindaloo.ras.ucalgary.ca") by vger.kernel.org with ESMTP
	id <S275082AbRKFFRd>; Tue, 6 Nov 2001 00:17:33 -0500
Date: Mon, 5 Nov 2001 22:17:29 -0700
Message-Id: <200111060517.fA65HTb19121@vindaloo.ras.ucalgary.ca>
From: Richard Gooch <rgooch@ras.ucalgary.ca>
To: Alexander Viro <viro@math.psu.edu>
Cc: linux-kernel@vger.kernel.org, Linus Torvalds <torvalds@transmeta.com>
Subject: Re: more devfs fun
In-Reply-To: <Pine.GSO.4.21.0110271513580.21545-100000@weyl.math.psu.edu>
In-Reply-To: <Pine.GSO.4.21.0110271458300.21545-100000@weyl.math.psu.edu>
	<Pine.GSO.4.21.0110271513580.21545-100000@weyl.math.psu.edu>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Alexander Viro writes:
> 	It just gets better and better...

Sorry, Al. You're wrong on this one...

> in get_removable_partition()
>         if (strcmp (de->name, "disc") == 0) return check_disc_changed (de);
> 
> with 
>     if ( name && (namelen < 1) ) namelen = strlen (name);
>     if ( ( new = kmalloc (sizeof *new + namelen, GFP_KERNEL) ) == NULL )
>         return NULL;
> ...
>     if (name) memcpy (new->name, name, namelen);
> 
> in create_entry().
> 
> IOW, ->name is not NUL-terminated.

In fact, it is. Take a look at the declaration of struct devfs_entry
and you'll see that there is one byte already taken up for the name
string. So adding the length of the string yields storage for len+1
bytes. IOW, space for the NULL-terminator. And right after the call to
kmalloc(), I call:
	memset (new, 0, sizeof *new + namelen);

which zeros everything, including the terminator.

If I missed something as basic as NULL-termination, the thing probably
wouldn't even boot!

				Regards,

					Richard....
Permanent: rgooch@atnf.csiro.au
Current:   rgooch@ras.ucalgary.ca
