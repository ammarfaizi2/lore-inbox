Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S135183AbRAHXWc>; Mon, 8 Jan 2001 18:22:32 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S133051AbRAHXWW>; Mon, 8 Jan 2001 18:22:22 -0500
Received: from penguin.e-mind.com ([195.223.140.120]:59178 "EHLO
	penguin.e-mind.com") by vger.kernel.org with ESMTP
	id <S131901AbRAHXWU>; Mon, 8 Jan 2001 18:22:20 -0500
Date: Tue, 9 Jan 2001 00:22:36 +0100
From: Andrea Arcangeli <andrea@suse.de>
To: Andries.Brouwer@cwi.nl
Cc: linux-kernel@vger.kernel.org, viro@math.psu.edu
Subject: Re: `rmdir .` doesn't work in 2.4
Message-ID: <20010109002236.K27646@athlon.random>
In-Reply-To: <UTC200101082250.XAA147777.aeb@texel.cwi.nl>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <UTC200101082250.XAA147777.aeb@texel.cwi.nl>; from Andries.Brouwer@cwi.nl on Mon, Jan 08, 2001 at 11:50:44PM +0100
X-GnuPG-Key-URL: http://e-mind.com/~andrea/aa.gnupg.asc
X-PGP-Key-URL: http://e-mind.com/~andrea/aa.asc
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jan 08, 2001 at 11:50:44PM +0100, Andries.Brouwer@cwi.nl wrote:
>     From: Andrea Arcangeli <andrea@suse.de>
> 
>     > But in fact it fails with EINVAL, and
>     > 
>     > [EINVAL]: The path argument contains a last component that is dot.
> 
>     I can't confirm. The specs I'm checking are here:
> 
>         http://www.opengroup.org/onlinepubs/007908799/xsh/rmdir.html
> 
> That is the SUSv2 text, one of the ingredients for the new
> POSIX standard. I quoted the current Austin draft, the current
> draft for the next version of the POSIX standard.
> 
> Quoting a text fragment:
> 
>         The rmdir( ) function shall remove a directory whose name is given by
>         path. The directory is removed only if it is an empty directory.
>         If the directory is the root directory or the current working
>         directory of any process, it is unspecified whether the function
>         succeeds, or whether it shall fail and set errno to [EBUSY].
>         If path names a symbolic link, then rmdir( ) shall fail and
>         set errno to [ENOTDIR]. If the path argument refers to a path
>         whose final component is either dot or dot-dot, rmdir( ) shall
>         fail. ...

I trust your specs said so, however I'm not sure which are the specs
we should follow for Linux.

At least for LFS 2.2.x fixage I always followed the SuSv2 specs and they
doesn't even say that rmdir can return -EINVAL. So returning -EINVAL is wrong
in first place according to SuSv2.

> from the directory "foo", but rmdir("foo/.") does not finish
> by removing the name "." from the directory "foo".

Sure. Also `rmdir .` doesn't mean remove "." from current directory but it
means "remove the directory pointed out by path `.'". The kernel/We definitely
knows which is such directory. That is in sync with the specs: "The rmdir()
function removes a directory whose name is given by path". You agree that the
path "." identifys one directory.

Andrea
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
