Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S130199AbRAHWhd>; Mon, 8 Jan 2001 17:37:33 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131901AbRAHWhZ>; Mon, 8 Jan 2001 17:37:25 -0500
Received: from penguin.e-mind.com ([195.223.140.120]:7717 "EHLO
	penguin.e-mind.com") by vger.kernel.org with ESMTP
	id <S130199AbRAHWhV>; Mon, 8 Jan 2001 17:37:21 -0500
Date: Mon, 8 Jan 2001 23:37:34 +0100
From: Andrea Arcangeli <andrea@suse.de>
To: Benson Chow <blc@q.dyndns.org>
Cc: linux-kernel@vger.kernel.org
Subject: Re: `rmdir .` doesn't work in 2.4
Message-ID: <20010108233734.C27646@athlon.random>
In-Reply-To: <20010108225451.A968@stefan.sime.com> <Pine.LNX.4.31.0101081501560.10554-100000@q.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.31.0101081501560.10554-100000@q.dyndns.org>; from blc@q.dyndns.org on Mon, Jan 08, 2001 at 03:11:08PM -0700
X-GnuPG-Key-URL: http://e-mind.com/~andrea/aa.gnupg.asc
X-PGP-Key-URL: http://e-mind.com/~andrea/aa.asc
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jan 08, 2001 at 03:11:08PM -0700, Benson Chow wrote:
> Not very portable at all...
> 
> hpux = HP/UX 10.2
> 
> hpux:~$ mkdir foo
> hpux:~$ cd foo
> hpux:~/foo$ rmdir "`pwd`"
> rmdir: /home/blc/foo: Cannot remove mountable directory
> hpux:~/foo$ rmdir .
> rmdir: cannot remove .. or .
> hpux:~/foo$ rmdir /home/blc/foo
> rmdir: /home/blc/foo: Cannot remove mountable directory
> hpux:~/foo$ rmdir ./
> rmdir: ./: Cannot remove mountable directory
> hpux:~/foo$
> 
> Maybe HP/UX is messed up as well.

It seems not to return -EBUSY. As also mentioned by Andries:

	If the directory is the root directory or the current working directory
	of any process, it is unspecified whether the function succeeds, or
	whether it fails and sets errno to [EBUSY]. 

The portable way is the one I mentioned as possible change for my code:

        os.chdir("..")
        shutil.rmtree(binutils_build)

Andrea
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
