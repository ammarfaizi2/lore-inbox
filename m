Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129226AbRAHUVo>; Mon, 8 Jan 2001 15:21:44 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129387AbRAHUVe>; Mon, 8 Jan 2001 15:21:34 -0500
Received: from neon-gw.transmeta.com ([209.10.217.66]:55313 "EHLO
	neon-gw.transmeta.com") by vger.kernel.org with ESMTP
	id <S129226AbRAHUVX>; Mon, 8 Jan 2001 15:21:23 -0500
To: linux-kernel@vger.kernel.org
From: torvalds@transmeta.com (Linus Torvalds)
Subject: Re: setfsuid on ext2 weirdness (2.4)
Date: 8 Jan 2001 12:21:15 -0800
Organization: Transmeta Corporation
Message-ID: <93d7fr$429$1@penguin.transmeta.com>
In-Reply-To: <Pine.LNX.3.96.1010108025520.14610B-100000@medusa.sparta.lu.se>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

In article <Pine.LNX.3.96.1010108025520.14610B-100000@medusa.sparta.lu.se>,
Bjorn Wesen  <bjorn@sparta.lu.se> wrote:
>
>in fact, 0 and 500 are the ONLY ones who let a filesystem op through after
>the setfsuid call. all other cause an EACCESS error on the open (or any
>other fs op). and yes, the actual filepermissions on /etc and /etc/passwd
>are correct.

Please show them, anyway. What does "ls -ld / /etc /etc/passwd" say?

>so... the quick question is... is there anything in EXT2 or VFS that can
>cause a quite normal ext2 filesystem on a 2.4.0 kernel to behave remotely
>like this ?

Most easily if /etc/passwd (or /etc or /) is owned by uid 500 (your
normal uid).  That would do this.  And it's pretty much the _only_ thing
that I can see doing it. 

I seriously doubt it has anything to do with the kernel or with RH 7.
The fact that uid 500 is special, and the fact that uid 500 is your
regular uid makes me suspect _very_ stronly that you've done something
as root to make some path be special to your regular uid.

The only paths that /etc/passwd touches are /, /etc and /etc/passwd. 
99% says that one of the three will be wrong (probably "/", because you
probably checked the others already and overlooked root), and you'll
feel really silly. 

Oh, there is _one_ special case.  Is either / or /etc a mount-point (ie
you may be playing games with over-mounting)? The permissions _under_
the mount-point can actually matter, and they are not visible when doing
an "ls", because the mounted thing will be shown.

And hey, if you think the above is confusing, try making your /dev/null
a regular (writable) file by mistake.  Now THAT will be confusing as
hell: things will actually work surprisingly well, but some thing
_really_ don't work the way they are intended to.  And chasing it down
is an exercise in futility.  Yes, I've done that at least twice as root
by mistake. 

		Linus
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
