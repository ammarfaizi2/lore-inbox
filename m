Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S276973AbRJ0Tuv>; Sat, 27 Oct 2001 15:50:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S276956AbRJ0Tuc>; Sat, 27 Oct 2001 15:50:32 -0400
Received: from leibniz.math.psu.edu ([146.186.130.2]:4041 "EHLO math.psu.edu")
	by vger.kernel.org with ESMTP id <S276914AbRJ0Tu0>;
	Sat, 27 Oct 2001 15:50:26 -0400
Date: Sat, 27 Oct 2001 15:50:59 -0400 (EDT)
From: Alexander Viro <viro@math.psu.edu>
To: linux-kernel@vger.kernel.org
cc: Linus Torvalds <torvalds@transmeta.com>,
        Richard Gooch <rgooch@ras.ucalgary.ca>
Subject: Re: more devfs fun (Piled Higher and Deeper)
In-Reply-To: <Pine.GSO.4.21.0110271513580.21545-100000@weyl.math.psu.edu>
Message-ID: <Pine.GSO.4.21.0110271536190.21545-100000@weyl.math.psu.edu>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

devfs_rmdir() checks that directory is empty.  Then it calls
devfsd_notify_one(), which can block.  Then it marks the entry
unregistered and reports success.

Guess what will happen if devfs_register() will happen at that
moment...

/me _seriously_ considers hostile takeover of the damn thing

I mean, when holes are found at that rate just by cursory look through
the code...  And that stuff had been there for at least 2 years.
Richard, I hate to break it on you, but dealing with that crap is
generally considered a maintainer's job.  And it is supposed to happen
slightly faster - 2 years would be bad even for MS.  If you don't
have time for that work - say so and step down, nobody will blame
you for that.  Repeating that everything will be fine RSN is getting
real old by now...

