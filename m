Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261861AbTAJGza>; Fri, 10 Jan 2003 01:55:30 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262452AbTAJGza>; Fri, 10 Jan 2003 01:55:30 -0500
Received: from 169.imtp.Ilyichevsk.Odessa.UA ([195.66.192.169]:21267 "EHLO
	Port.imtp.ilyichevsk.odessa.ua") by vger.kernel.org with ESMTP
	id <S261861AbTAJGz3>; Fri, 10 Jan 2003 01:55:29 -0500
Message-Id: <200301100658.h0A6vxs14580@Port.imtp.ilyichevsk.odessa.ua>
Content-Type: text/plain; charset=US-ASCII
From: Denis Vlasenko <vda@port.imtp.ilyichevsk.odessa.ua>
Reply-To: vda@port.imtp.ilyichevsk.odessa.ua
To: Nix <nix@esperi.demon.co.uk>,
       Linux Kernel Development <linux-kernel@vger.kernel.org>
Subject: Re: strange sparc64 -> i586 intermittent but reproducible NFS write errors to one and only one fs
Date: Fri, 10 Jan 2003 08:57:52 +0200
X-Mailer: KMail [version 1.3.2]
References: <87bs2q3paq.fsf@amaterasu.srvr.nix>
In-Reply-To: <87bs2q3paq.fsf@amaterasu.srvr.nix>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 10 January 2003 00:56, Nix wrote:
> When I rebooted my systems into 2.4.20 (from 2.4.19), I started
> seeing EIO write() errors to files in my ext3 home directory
> (NFS-mounted, exported async).
>
> So I knocked up a test program (included below) to try to track the
> failing writes down, and got more confused.
>
> The properties of the failing writes that I've been able to determine
> thus far are as follows; look out, they're weird as hell:
>
>  - the failures are definitely from write(), not open().
>
>  - writes from sparc64 to one filesystem, and only one filesystem, on
>    i586, both running 2.4.20, UDP NFSv3; rquotad and quotas are on,
> but I am well within my quota. (quota 3.06, nfs-utils 1.0). Writes to
> other filesystems on the same machine, even if they too are using
> ext3, even if they too have user quotas for the same user.
>
>    What differs between filesystems that work and the one that fails
> I can't tell; other FSen *on the same block device* work... (the
> block device is an un-RAIDed SCSI disk.)
>
>  - local writes to the same filesystem, with the same test program,
>    never fail.
>
>  - writes from another IA32 box (all these boxes are near-clones of
>    each other as far as software is concerned) to the NFS server box
>    never fail.
>
>  - It happens if I mount the fs with -o soft (my default for all NFS
>    mounts for robustness-in-the-presence-of-machine-failure reasons),
>    but also if I mount with -o hard :(( besides, the timeouts happen
> far too fast for it to be major timeout expiry that casues the EIOs.
>
>  - The failure always occurs for writes that cross the 2^21 byte
>    boundary, but not all such writes fail. You seem to need to have
>    done a lot of write()s before, perhaps even starting with O_TRUNC
>    and write()ing like mad from there on up (the WRITES_PER_OPEN
>    #define is a way to test that; I've never had a failure for a file
>    opened with O_APPEND, even if it crossed the 2^21 byte boundary).
>
>  - It happens whether _LARGEFILE_SOURCE / _FILE_OFFSET_BITS are
>    defined or not (I'd be amazed if this affected it, actually, but
>    it never hurts to check).
>
>  - Despite the EIO, the write actually *succeeds* most of the time
>    (perhaps not all the time; again, I'm not sure yet). In fact...
>
>  - It is quite thoroughly inconsistent. If you #define REPRODUCE to 1
>    in the test program and fill out sizes_to_reproduce[] with a set
>    of write() sizes that have caused the error in the past, the error
>    happens again, but not always:

This beast is most probably Sparc64 or 64-bit arch specific.

Try to pin down the first 2.4.20-preN where it appears.
Then inform NFS and Sparc64 folks.

If you won't get any useful hint by then, you can continue playing
patch-o-rama by reading changelog and slowly mutating last working
2.4.20-preN into first non-working pre.
--
vda
