Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S130392AbRBLKPL>; Mon, 12 Feb 2001 05:15:11 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129146AbRBLKPC>; Mon, 12 Feb 2001 05:15:02 -0500
Received: from ns.suse.de ([213.95.15.193]:17163 "HELO Cantor.suse.de")
	by vger.kernel.org with SMTP id <S129282AbRBLKOt>;
	Mon, 12 Feb 2001 05:14:49 -0500
Date: Mon, 12 Feb 2001 11:14:48 +0100
From: Olaf Hering <olh@suse.de>
To: Trond Myklebust <trond.myklebust@fys.uio.no>
Cc: "H. Peter Anvin" <hpa@transmeta.com>, autofs@linux.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: race in autofs / nfs
Message-ID: <20010212111448.A28932@suse.de>
In-Reply-To: <20010211211701.A7592@suse.de> <3A86F6AA.1416F479@transmeta.com> <shsbss8i8iq.fsf@charged.uio.no>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <shsbss8i8iq.fsf@charged.uio.no>; from trond.myklebust@fys.uio.no on Mon, Feb 12, 2001 at 09:57:01AM +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Feb 12, Trond Myklebust wrote:

> >>>>> " " == H Peter Anvin <hpa@transmeta.com> writes:
> 
>      > Olaf Hering wrote:
>     >>
>     >> Hi,
>     >>
>     >> there is a race in 2.4.1 and 2.4.2-pre3 in autofs/nfs.  When
>     >> the cwd is on the nfs mounted server (== busy) and you try to
>     >> reboot the shutdown hangs in "rcautofs stop". I can reproduce
>     >> it everytime.
>     >>
> 
>      > Sounds like an NFS bug in umount.
> 
> Or a dcache bug: the above points to a corruption of the mnt_count
> which is supposed to be > 0 if the partition is in use. I'm seeing a
> similar leak for ext2 partitions (not involving autofs or NFS).

Some more updates:

This machines run the upcoming 7.1-ppc with autofs-4.0.0pre9.
When I install 7.0-ppc it runs rocksolid with the same kernel binary.
7.0 came with autofs-4.0.0pre7:

Linux plum 2.4.1 #1 Sun Feb 11 11:56:01 GMT 2001 ppc unknown
Kernel modules         2.4.1
Gnu C                  2.95.3
Binutils               2.9.5.0.24
Linux C Library        x   1 root     root      4209204 Oct  4 21:42
/lib/libc.so.6
Dynamic linker         ldd (GNU libc) 2.1.3
Procps                 2.0.6
Mount                  2.10m
Net-tools              1.56
Kbd                    0.99
Sh-utils               2.0
Modules Loaded         snd-card-awacs snd-pcm snd-timer snd-mixer snd
soundcore ipv6 netlink_dev nfsd autofs bmac pcmcia_core

(hmm, it loads autofs and not autofs4 on 7.0?)


It hangs again after a while, in this case:
cc1plus  19126   181495  2903920        4 u01783c18 c44ca000   1 current
automoun 19129   183289  2932624       54 u0176a368 c42ca000   0 current
_spin_lock(c021b754) CPU#1 NIP c0 072f18 holder: cpu 0 pc C0057A18


I will try the older autofs package now.




Gruss Olaf

-- 
 $ man clone

BUGS
       Main feature not yet implemented...
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
