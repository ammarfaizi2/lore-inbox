Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261894AbREXNSZ>; Thu, 24 May 2001 09:18:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261912AbREXNSO>; Thu, 24 May 2001 09:18:14 -0400
Received: from zikova.cvut.cz ([147.32.235.100]:43020 "EHLO zikova.cvut.cz")
	by vger.kernel.org with ESMTP id <S261894AbREXNSH>;
	Thu, 24 May 2001 09:18:07 -0400
From: "Petr Vandrovec" <VANDROVE@vc.cvut.cz>
Organization: CC CTU Prague
To: "peter k." <spam-goes-to-dev-null@gmx.net>
Date: Thu, 24 May 2001 15:16:44 MET-1
MIME-Version: 1.0
Content-type: text/plain; charset=US-ASCII
Content-transfer-encoding: 7BIT
Subject: Re: patch to put IDE drives in sleep-mode after an halt
CC: linux-kernel@vger.kernel.org, adrianb@ntsp.nec.co.jp
X-mailer: Pegasus Mail v3.40
Message-ID: <3D34A656448@vcnet.vc.cvut.cz>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 24 May 01 at 14:59, peter k. wrote:

> > auto-parking), and since all drives are voice coil drives, then they
> > should auto-park. But i've had problems with some hard drives that were
> > spinned down (when Win____ was shutdown)..  if i reset the PC (instead
> > of turning it off), the hard drives wouldn't come back on so i'd have to
> > do a full shutdown of the machine.
> 
> well, my new 40gb ones are auto-parking i think but all the other ones from
> last year aren't
> and older hardware (although 1 year isnt even old for a hd) should be
> supported by the kernel, right?
> plus, its really not difficult to implement spinning down the hds before
> halt anyway and then the kernel
> leaves the system as clean as it was before booting ;) !!

I'm using (at the end of /etc/init.d/halt):

cat /sbin/halt > /dev/null
cat /bin/sleep > /dev/null
hdparm -Y /dev/hdd
hdparm -Y /dev/hdc
hdparm -Y /dev/hdb
hdparm -Y /dev/hda
/bin/sleep 2
/sbin/halt -d -f -i -p

It works fine for me for years... I had to put sleep 2 here, as otherwise
CDROM drive does not park its head correctly (as hdparm /dev/hdc causes
ide-cd/cdrom to load - and this causes CDROM to spin up :-( )
So I do not see any reason for doing HDD park by kernel...
                                                 Best regards,
                                                      Petr Vandrovec
                                                      vandrove@vc.cvut.cz

P.S.: AFAIK all IDE disks autopark. At least my 41MB KALOK from 1990
did. Or at least tried...
