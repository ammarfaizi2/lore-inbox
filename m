Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261595AbREXRjp>; Thu, 24 May 2001 13:39:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261593AbREXRjf>; Thu, 24 May 2001 13:39:35 -0400
Received: from c1608841-a.fallon1.nv.home.com ([65.5.95.44]:13069 "EHLO
	tarot.mentasm.org") by vger.kernel.org with ESMTP
	id <S261577AbREXRjV>; Thu, 24 May 2001 13:39:21 -0400
Date: Thu, 24 May 2001 10:38:42 -0700
To: Petr Vandrovec <VANDROVE@vc.cvut.cz>
Cc: "peter k." <spam-goes-to-dev-null@gmx.net>, linux-kernel@vger.kernel.org,
        adrianb@ntsp.nec.co.jp
Subject: Re: patch to put IDE drives in sleep-mode after an halt
Message-ID: <20010524103842.A3677@ferret.phonewave.net>
In-Reply-To: <3D34A656448@vcnet.vc.cvut.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.15i
In-Reply-To: <3D34A656448@vcnet.vc.cvut.cz>; from VANDROVE@vc.cvut.cz on Thu, May 24, 2001 at 03:16:44PM +0000
From: idalton@ferret.dyndns.org
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, May 24, 2001 at 03:16:44PM +0000, Petr Vandrovec wrote:
> On 24 May 01 at 14:59, peter k. wrote:
> 
> > > auto-parking), and since all drives are voice coil drives, then they
> > > should auto-park. But i've had problems with some hard drives that were
> > > spinned down (when Win____ was shutdown)..  if i reset the PC (instead
> > > of turning it off), the hard drives wouldn't come back on so i'd have to
> > > do a full shutdown of the machine.
> > 
> > well, my new 40gb ones are auto-parking i think but all the other ones from
> > last year aren't
> > and older hardware (although 1 year isnt even old for a hd) should be
> > supported by the kernel, right?
> > plus, its really not difficult to implement spinning down the hds before
> > halt anyway and then the kernel
> > leaves the system as clean as it was before booting ;) !!
> 
> I'm using (at the end of /etc/init.d/halt):
> 
> cat /sbin/halt > /dev/null
> cat /bin/sleep > /dev/null
> hdparm -Y /dev/hdd
> hdparm -Y /dev/hdc
> hdparm -Y /dev/hdb
> hdparm -Y /dev/hda
> /bin/sleep 2
> /sbin/halt -d -f -i -p
> 
> It works fine for me for years... I had to put sleep 2 here, as otherwise
> CDROM drive does not park its head correctly (as hdparm /dev/hdc causes
> ide-cd/cdrom to load - and this causes CDROM to spin up :-( )
> So I do not see any reason for doing HDD park by kernel...

I do something similar to this on my non-poweroff machines, except currently
I have only the hard drives coded in. Also, since two of the machines are SCSI,
I have generic built-in so I can spin those down too. (unless hdparm no longer
needs sg loaded to spin down a drive)

Though, having a compile-time or boot-time kernel option to spin down all
attached drives at halt may not be a bad idea.

-- Ferret
