Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129094AbRBLLvq>; Mon, 12 Feb 2001 06:51:46 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129107AbRBLLvg>; Mon, 12 Feb 2001 06:51:36 -0500
Received: from ns.suse.de ([213.95.15.193]:774 "HELO Cantor.suse.de")
	by vger.kernel.org with SMTP id <S129094AbRBLLvV>;
	Mon, 12 Feb 2001 06:51:21 -0500
Date: Mon, 12 Feb 2001 12:51:15 +0100
From: Olaf Hering <olh@suse.de>
To: Trond Myklebust <trond.myklebust@fys.uio.no>
Cc: "H. Peter Anvin" <hpa@transmeta.com>, autofs@linux.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: race in autofs / nfs
Message-ID: <20010212125115.B30552@suse.de>
In-Reply-To: <20010211211701.A7592@suse.de> <3A86F6AA.1416F479@transmeta.com> <shsbss8i8iq.fsf@charged.uio.no> <20010212111448.A28932@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <20010212111448.A28932@suse.de>; from olh@suse.de on Mon, Feb 12, 2001 at 11:14:48AM +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Feb 12, Olaf Hering wrote:

> On Mon, Feb 12, Trond Myklebust wrote:
> 
> > >>>>> " " == H Peter Anvin <hpa@transmeta.com> writes:
> > 
> >      > Olaf Hering wrote:
> >     >>
> >     >> Hi,
> >     >>
> >     >> there is a race in 2.4.1 and 2.4.2-pre3 in autofs/nfs.  When
> >     >> the cwd is on the nfs mounted server (== busy) and you try to
> >     >> reboot the shutdown hangs in "rcautofs stop". I can reproduce
> >     >> it everytime.
> >     >>
> > 
> >      > Sounds like an NFS bug in umount.
> > 
> > Or a dcache bug: the above points to a corruption of the mnt_count
> > which is supposed to be > 0 if the partition is in use. I'm seeing a
> > similar leak for ext2 partitions (not involving autofs or NFS).
> 
> (hmm, it loads autofs and not autofs4 on 7.0?)

The autofs4.o is the culprit, it works perfect with autofs.o.

What would happen if I stick with autofs.o now?
The docu recommends autofs4 in modules.conf.



Gruss Olaf

-- 
 $ man clone

BUGS
       Main feature not yet implemented...
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
