Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261526AbTCKTMW>; Tue, 11 Mar 2003 14:12:22 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261528AbTCKTMW>; Tue, 11 Mar 2003 14:12:22 -0500
Received: from quake.mweb.co.za ([196.2.45.76]:22993 "EHLO quake.mweb.co.za")
	by vger.kernel.org with ESMTP id <S261526AbTCKTMU>;
	Tue, 11 Mar 2003 14:12:20 -0500
Date: Tue, 11 Mar 2003 21:17:22 +0200
From: Martin Schlemmer <azarah@gentoo.org>
To: "Theodore Ts'o" <tytso@mit.edu>
Cc: adilger@clusterfs.com, linux-kernel@vger.kernel.org
Subject: Re: Corruption problem with ext3 and htree
Message-Id: <20030311211722.0fee84cc.azarah@gentoo.org>
In-Reply-To: <20030311061911.GF1965@think.thunk.org>
References: <20030307063940.6d81780e.azarah@gentoo.org>
	<20030306234819.Q1373@schatzie.adilger.int>
	<20030309063345.47046254.azarah@gentoo.org>
	<20030311061911.GF1965@think.thunk.org>
X-Mailer: Sylpheed version 0.8.10claws (GTK+ 1.2.10; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: multipart/mixed;
 boundary="Multipart_Tue__11_Mar_2003_21:17:22_+0200_095daed0"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.

--Multipart_Tue__11_Mar_2003_21:17:22_+0200_095daed0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Tue, 11 Mar 2003 01:19:11 -0500
Theodore Ts'o <tytso@mit.edu> wrote:

> Hmm... can you help construct a test case that doesn't rely on the
> presence of the Gentoo distribution?  Is there some way we can
> instrument the python code so we can see the exact filesystem
> operations (renames, deletions, moves, etc.) that is going on?  The
> good news is that you say that you're able to reproduce it every
> single time, which implies it's not a timing related problem.
> 

I just compile perl-5.8.0, and then install it.

----------------------------------------------------
nosferatu perl-5.8.0 # ls /space/var/tmp/portage/perl-5.8.0-r10/image
nosferatu perl-5.8.0 # make
DESTDIR="/space/var/tmp/portage/perl-5.8.0-r10/image"
INSTALLMAN1DIR="/space/var/tmp/portage/perl-5.8.0-r10/image/usr/share/m
an/man1"
INSTALLMAN3DIR="/space/var/tmp/portage/perl-5.8.0-r10/image/foo/usr/sha
re/man/man3" install > /dev/null make[1]: [extras.make] Error 1
(ignored) make[2]: [extras.install] Error 1 (ignored)
nosferatu perl-5.8.0 # ls
/space/var/tmp/portage/perl-5.8.0-r10/image/usr/share/man/man3/Hash\:\:
Util.* -al ls:
/space/var/tmp/portage/perl-5.8.0-r10/image/usr/share/man/man3/Hash::Ut
il.tmp: No such file or directory-rw-r--r--    1 root     root        
6435 Mar 11 20:54
/space/var/tmp/portage/perl-5.8.0-r10/image/usr/share/man/man3/Hash::Ut
il.3pm nosferatu perl-5.8.0 #
-------------------------------------------------------------

Bad past, thus attached as well.

> It could possibly be a hash value dependent problem, which case it
> could be related to the filename.  That's not very likely, but it is
> possible.  If you could send us the result of "dumpe2fs -h /dev/XXXX",
> that would be useful.  In particular the last two lines:
> 
>   Default directory hash:   tea
>   Directory Hash Seed:      407dbbca-8326-4bed-bc7c-bb0453f79049
> 
> The most important thing though is to be able to reduce the test case
> to something which is slightly easier for us ext2/3 developers to run.
>  

Seems like its creating 'Hash::Util.tmp' as a directory for some reason,
while it should be a 'tmp' file when installing the man pages.

Is there some other hash algorithm I could try ?  Just to verify if it
is that ?  Problem is that If I try to recreate it without the make
install, I do not really succeed.


Regards,

-- 

Martin Schlemmer


--Multipart_Tue__11_Mar_2003_21:17:22_+0200_095daed0
Content-Type: application/octet-stream;
 name="foo"
Content-Disposition: attachment;
 filename="foo"
Content-Transfer-Encoding: base64

bm9zZmVyYXR1IHBlcmwtNS44LjAgIyBscyAvc3BhY2UvdmFyL3RtcC9wb3J0YWdlL3BlcmwtNS44
LjAtcjEwL2ltYWdlCm5vc2ZlcmF0dSBwZXJsLTUuOC4wICMgbWFrZSBERVNURElSPSIvc3BhY2Uv
dmFyL3RtcC9wb3J0YWdlL3BlcmwtNS44LjAtcjEwL2ltYWdlIiBJTlNUQUxMTUFOMURJUj0iL3Nw
YWNlL3Zhci90bXAvcG9ydGFnZS9wZXJsLTUuOC4wLXIxMC9pbWFnZS91c3Ivc2hhcmUvbWFuL21h
bjEiIElOU1RBTExNQU4zRElSPSIvc3BhY2UvdmFyL3RtcC9wb3J0YWdlL3BlcmwtNS44LjAtcjEw
L2ltYWdlL2Zvby91c3Ivc2hhcmUvbWFuL21hbjMiIGluc3RhbGwgPiAvZGV2L251bGwKbWFrZVsx
XTogW2V4dHJhcy5tYWtlXSBFcnJvciAxIChpZ25vcmVkKQptYWtlWzJdOiBbZXh0cmFzLmluc3Rh
bGxdIEVycm9yIDEgKGlnbm9yZWQpCm5vc2ZlcmF0dSBwZXJsLTUuOC4wICMgbHMgL3NwYWNlL3Zh
ci90bXAvcG9ydGFnZS9wZXJsLTUuOC4wLXIxMC9pbWFnZS91c3Ivc2hhcmUvbWFuL21hbjMvSGFz
aFw6XDpVdGlsLiogLWFsCmxzOiAvc3BhY2UvdmFyL3RtcC9wb3J0YWdlL3BlcmwtNS44LjAtcjEw
L2ltYWdlL3Vzci9zaGFyZS9tYW4vbWFuMy9IYXNoOjpVdGlsLnRtcDogTm8gc3VjaCBmaWxlIG9y
IGRpcmVjdG9yeQotcnctci0tci0tICAgIDEgcm9vdCAgICAgcm9vdCAgICAgICAgIDY0MzUgTWFy
IDExIDIwOjU0IC9zcGFjZS92YXIvdG1wL3BvcnRhZ2UvcGVybC01LjguMC1yMTAvaW1hZ2UvdXNy
L3NoYXJlL21hbi9tYW4zL0hhc2g6OlV0aWwuM3BtCm5vc2ZlcmF0dSBwZXJsLTUuOC4wICMK

--Multipart_Tue__11_Mar_2003_21:17:22_+0200_095daed0--
