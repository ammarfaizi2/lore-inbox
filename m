Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S285424AbSBUW7n>; Thu, 21 Feb 2002 17:59:43 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S286895AbSBUW7e>; Thu, 21 Feb 2002 17:59:34 -0500
Received: from tone.orchestra.cse.unsw.EDU.AU ([129.94.242.28]:10449 "HELO
	tone.orchestra.cse.unsw.EDU.AU") by vger.kernel.org with SMTP
	id <S285424AbSBUW7M>; Thu, 21 Feb 2002 17:59:12 -0500
From: Neil Brown <neilb@cse.unsw.edu.au>
To: "Lever, Charles" <Charles.Lever@netapp.com>
Date: Fri, 22 Feb 2002 09:58:50 +1100 (EST)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <15477.31658.527423.667947@notabene.cse.unsw.edu.au>
Cc: Jeff Garzik <jgarzik@mandrakesoft.com>, linux-kernel@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, phil@off.net,
        "Peter J. Braam" <braam@clusterfs.com>
Subject: RE: tmpfs, NFS, file handles
In-Reply-To: message from Lever, Charles on Thursday February 21
In-Reply-To: <6440EA1A6AA1D5118C6900902745938E50CD87@black.eng.netapp.com>
X-Mailer: VM 6.72 under Emacs 20.7.2
X-face: [Gw_3E*Gng}4rRrKRYotwlE?.2|**#s9D<ml'fY1Vw+@XfR[fRCsUoP?K6bt3YD\ui5Fh?f
	LONpR';(ql)VM_TQ/<l_^D3~B:z$\YC7gUCuC=sYm/80G=$tt"98mr8(l))QzVKCk$6~gldn~*FK9x
	8`;pM{3S8679sP+MbP,72<3_PIH-$I&iaiIb|hV1d%cYg))BmI)AZ
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thursday February 21, Charles.Lever@netapp.com wrote:
> > That means you are only hashing inodes exported by NFS, and you have
> > a pretty good guarantee of uniqueness (providing time doesn't go
> > backwards).
> 
> this may be obvious... apologies.
> 
> don't use the TOD directly -- it can go backwards if ntpd or an admin
> sets it back.  better to use a monotonically increasing number that
> you completely control yourself.
> 
> also, if your timer resolution isn't good enough, a window opens 
> where two generated "uniquifiers" can be the same for all intents
> and purposes.

Certainly timeofday by itself isn't enough for the various reasons you
mention.  But it does help to avoid accepting filehandles from before
the last reboot.
In my proposal there there were three numbers:
   An address
   A sequentially assigned inode number
   A time of day.

Any two of these is probably adequate most of the time, but could
occasionally result in equal filehandles for different files.  Adding
a third makes collision virtually impossible.

NeilBrown
