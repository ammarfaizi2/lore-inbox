Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S131342AbRAHWvp>; Mon, 8 Jan 2001 17:51:45 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S135791AbRAHWvf>; Mon, 8 Jan 2001 17:51:35 -0500
Received: from hera.cwi.nl ([192.16.191.1]:40374 "EHLO hera.cwi.nl")
	by vger.kernel.org with ESMTP id <S131342AbRAHWvS>;
	Mon, 8 Jan 2001 17:51:18 -0500
Date: Mon, 8 Jan 2001 23:50:44 +0100 (MET)
From: Andries.Brouwer@cwi.nl
Message-Id: <UTC200101082250.XAA147777.aeb@texel.cwi.nl>
To: Andries.Brouwer@cwi.nl, andrea@suse.de
Subject: Re: `rmdir .` doesn't work in 2.4
Cc: linux-kernel@vger.kernel.org, viro@math.psu.edu
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

    From: Andrea Arcangeli <andrea@suse.de>

    > But in fact it fails with EINVAL, and
    > 
    > [EINVAL]: The path argument contains a last component that is dot.

    I can't confirm. The specs I'm checking are here:

        http://www.opengroup.org/onlinepubs/007908799/xsh/rmdir.html

That is the SUSv2 text, one of the ingredients for the new
POSIX standard. I quoted the current Austin draft, the current
draft for the next version of the POSIX standard.

Quoting a text fragment:

        The rmdir( ) function shall remove a directory whose name is given by
        path. The directory is removed only if it is an empty directory.
        If the directory is the root directory or the current working
        directory of any process, it is unspecified whether the function
        succeeds, or whether it shall fail and set errno to [EBUSY].
        If path names a symbolic link, then rmdir( ) shall fail and
        set errno to [ENOTDIR]. If the path argument refers to a path
        whose final component is either dot or dot-dot, rmdir( ) shall
        fail. ...


    > Indeed, rmdir("P/D") does roughly the following:
    > (i) check that P/D is a directory
    > (ii) check that P/D does not have entries other than . and ..
    > (iii) delete the names . and .. from P/D
    > (iv) delete the name D from P

    SUSv2 is straightforward. It doesn't talk about (iv).

I just made explicit what rmdir() actually does, in order to
show that a trailing dot really is a different case where
other rules than the usual ones would have to be applied.
Indeed, rmdir("foo/bar") finishes by removing the name "bar"
from the directory "foo", but rmdir("foo/.") does not finish
by removing the name "." from the directory "foo".

Andries


[Think classical Unix: there are inodes, and there are names.
The rmdir call, just like rm, removes names. Now foo and foo/.
may both be names for the same inode, but they are not the same name.]
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
