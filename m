Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S288804AbSATXGP>; Sun, 20 Jan 2002 18:06:15 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S288828AbSATXGG>; Sun, 20 Jan 2002 18:06:06 -0500
Received: from dsl-213-023-060-247.arcor-ip.net ([213.23.60.247]:13839 "HELO
	spot.local") by vger.kernel.org with SMTP id <S288804AbSATXF6>;
	Sun, 20 Jan 2002 18:05:58 -0500
Date: Mon, 21 Jan 2002 00:09:04 +0100
From: Oliver Feiler <kiza@gmx.net>
To: Richard Gooch <rgooch@ras.ucalgary.ca>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Removing files in devfs
Message-ID: <20020121000904.A23198@gmxpro.net>
In-Reply-To: <20020119094424.A239@gmxpro.net> <200201202255.g0KMtYh15207@vindaloo.ras.ucalgary.ca>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <200201202255.g0KMtYh15207@vindaloo.ras.ucalgary.ca>; from rgooch@ras.ucalgary.ca on Sun, Jan 20, 2002 at 03:55:34PM -0700
X-Operating-System: Linux 2.4.16 i686
X-Species: Snow Leopard
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Richard Gooch wrote:
> 
> What is "every other system"?
> 

	Sorry, the last mail didn't get a followup to the list... that should 
explain it:

----forwarded mail----

>>>>> "oliver" == Oliver Feiler <kiza@gmxpro.net> writes:

oliver> Juan Quintela wrote:
>> 
>> Since 2.4.16-preX, you can't remove a {file,symlink} in devfs created
>> by devfs :(

oliver> Hmm, that'll be it. Since the other systems I tried were both running
oliver> 2.4.17 kernels and I'm with .16 at the moment. Thanks for the hint.  


this patch should make the trick (it is a workaround, but it is not
trivial to do it an easier way without still more incestuous
relations,  Wating for Richard to do something to the respect.

Later, Juan.

diff -u linux/fs/super.c.orig linux/fs/super.c
--- linux/fs/super.c.orig       Fri Jan  4 21:28:24 2002
+++ linux/fs/super.c    Fri Jan  4 21:09:45 2002
@@ -1056,8 +1056,8 @@
        putname(fs_names);
        if (path_start >= 0) {
                name = path + path_start;
-               devfs_mk_symlink (NULL, "root", DEVFS_FL_DEFAULT,
-                                 name + 5, NULL, NULL);
+//             devfs_mk_symlink (NULL, "root", DEVFS_FL_DEFAULT,
+//                               name + 5, NULL, NULL);
                memcpy (name, "/dev/", 5);
        }
        vfsmnt = alloc_vfsmnt();


----end forward----


-- 
Oliver Feiler                                               kiza@gmx.net
http://www.lionking.org/~kiza/pgpkey              PGP key ID: 0x561D4FD2
http://www.lionking.org/~kiza/
