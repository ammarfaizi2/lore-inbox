Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129094AbRBKT4r>; Sun, 11 Feb 2001 14:56:47 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129129AbRBKT4i>; Sun, 11 Feb 2001 14:56:38 -0500
Received: from ns.suse.de ([213.95.15.193]:29195 "HELO Cantor.suse.de")
	by vger.kernel.org with SMTP id <S129094AbRBKT41>;
	Sun, 11 Feb 2001 14:56:27 -0500
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [reiserfs-list] Re: Apparent instability of reiserfs on 2.4.1
In-Reply-To: <E14S01O-0004Su-00@the-village.bc.nu>
From: Andi Kleen <ak@suse.de>
Date: 11 Feb 2001 20:56:16 +0100
In-Reply-To: Alan Cox's message of "11 Feb 2001 18:13:47 +0100"
Message-ID: <oupvgqhkn8f.fsf@pigdrop.muc.suse.de>
User-Agent: Gnus/5.0803 (Gnus v5.8.3) Emacs/20.7
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Alan Cox <alan@lxorguk.ukuu.org.uk> writes:

> > LADDIS is the industry standard benchmark for NFS.  It crashes for ReiserFS and
> > NFS.  We can't afford to buy it, as it is proprietary software.  Once Nikita has
> > finished testing his changes, we will ask someone to test it for us though.
> > 
> 
> Do you know if the connectathon test suites show the problem?

The reiserfs nfs problem in standard 2.4 is very simple -- it'll barf as soon 
as you run out of file handle/inode cache. Any workload that accesses
enough files in parallel can trigger it.

Fixes do exist, but require bigger changes in nfsd.  Basically you need to
hand out an 64bit inode in the nfs filehandle, and pass the upper 32bits
to the low level file system for efficient lookup (actually is all not 
too difficult to implement, just requires very uncodefreezefriendly changes
to nfsd) 


-Andi

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
