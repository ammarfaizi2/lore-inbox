Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S314446AbSHMKIs>; Tue, 13 Aug 2002 06:08:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S314459AbSHMKIs>; Tue, 13 Aug 2002 06:08:48 -0400
Received: from codepoet.org ([166.70.99.138]:5542 "EHLO winder.codepoet.org")
	by vger.kernel.org with ESMTP id <S314446AbSHMKIr>;
	Tue, 13 Aug 2002 06:08:47 -0400
Date: Tue, 13 Aug 2002 04:12:37 -0600
From: Erik Andersen <andersen@codepoet.org>
To: Alexander Viro <viro@math.psu.edu>
Cc: "H. Peter Anvin" <hpa@zytor.com>, linux-kernel@vger.kernel.org
Subject: Re: klibc and logging
Message-ID: <20020813101237.GA27879@codepoet.org>
Reply-To: andersen@codepoet.org
Mail-Followup-To: Erik Andersen <andersen@codepoet.org>,
	Alexander Viro <viro@math.psu.edu>, "H. Peter Anvin" <hpa@zytor.com>,
	linux-kernel@vger.kernel.org
References: <20020813075256.GA26384@codepoet.org> <Pine.GSO.4.21.0208130356480.1689-100000@weyl.math.psu.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.GSO.4.21.0208130356480.1689-100000@weyl.math.psu.edu>
User-Agent: Mutt/1.3.28i
X-Operating-System: Linux 2.4.18-rmk7, Rebel-NetWinder(Intel StrongARM 110 rev 3), 185.95 BogoMips
X-No-Junk-Mail: I do not want to get *any* junk mail.
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue Aug 13, 2002 at 04:04:59AM -0400, Alexander Viro wrote:
> We do have nfsroot support in the kernel.  If we are going to move it
> into the userland, we _must_ have the code for that.  "Use glibc" is
> laughable - try to link anything statically against that dungpile and
> see what size you'll get.

Using the version of mount from util-linux-2.11n: 

Staticly linked vs glibc 2.2.5:
    $ ls -l ./mount
    -rwxr-xr-x    1 andersen andersen   533912 Aug 13 03:41 ./mount*

Staticly linked vs uClibc 0.9.14:
    $ ls -l ./mount
    -rwxr-xr-x    1 andersen andersen   115844 Aug 13 03:40 ./mount*

Busybox mount w/NFS enabled, statically linked vs uClibc 0.9.14:
$ ls -l ./busybox
-rwxr-xr-x    1 andersen andersen    62628 Aug 13 03:46 ./busybox*

And uClibc's RPC code accounts for 33k of the 62k...

> Said that, we don't need anywhere near the full RPC support for nfsroot
> and I'm not sure that we want it in libc even if it will be implemented.
> "Use -lrpc" is perfectly OK.
> 
> Stuff needed for nfsroot
> 	a) is purely sequential (full-sync)
> 	b) we need 2 or 3 RPC calls
> 	c) we can open-code marshalling for these
> IOW, the most complex part of that is handling of timeout and possibly -
> logics with retransmit.  Other than that it's filling an array, doing
> sendmsg(), waiting for reply, and checking several words in received array.

I would love to see an example of how to do an NFS mount w/o
resorting to the C library at all.  Plainly, having generic RPC
code in the C library sucks, even if you trim it down.  Having
the entire NFS mount process live in application space, and not
in the C library, is clearly a win....

 -Erik

--
Erik B. Andersen             http://codepoet-consulting.com/
--This message was written using 73% post-consumer electrons--
