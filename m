Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S282835AbRK0Hjz>; Tue, 27 Nov 2001 02:39:55 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S282839AbRK0Hjp>; Tue, 27 Nov 2001 02:39:45 -0500
Received: from h24-64-71-161.cg.shawcable.net ([24.64.71.161]:59389 "EHLO
	lynx.adilger.int") by vger.kernel.org with ESMTP id <S282841AbRK0Hje>;
	Tue, 27 Nov 2001 02:39:34 -0500
Date: Tue, 27 Nov 2001 00:38:43 -0700
From: Andreas Dilger <adilger@turbolabs.com>
To: Andre Hedrick <andre@linux-ide.org>
Cc: Martin Eriksson <nitrax@giron.wox.org>,
        Steve Brueggeman <xioborg@yahoo.com>, linux-kernel@vger.kernel.org
Subject: Re: Journaling pointless with today's hard disks?
Message-ID: <20011127003843.Z730@lynx.no>
Mail-Followup-To: Andre Hedrick <andre@linux-ide.org>,
	Martin Eriksson <nitrax@giron.wox.org>,
	Steve Brueggeman <xioborg@yahoo.com>, linux-kernel@vger.kernel.org
In-Reply-To: <20011126170631.O730@lynx.no> <Pine.LNX.4.10.10111261614190.9508-100000@master.linux-ide.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.4i
In-Reply-To: <Pine.LNX.4.10.10111261614190.9508-100000@master.linux-ide.org>; from andre@linux-ide.org on Mon, Nov 26, 2001 at 04:16:12PM -0800
X-GPG-Key: 1024D/0D35BED6
X-GPG-Fingerprint: 7A37 5D79 BF1B CECA D44F  8A29 A488 39F5 0D35 BED6
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Nov 26, 2001  16:16 -0800, Andre Hedrick wrote:
> On Mon, 26 Nov 2001, Andreas Dilger wrote:
> > What happens if you have a slightly bad power supply?  Does it immediately
> > go read only all the time?  It would definitely need to be able to
> > recover operations as soon as the power was "normal" again, even if this
> > caused basically "sync" I/O to the disk.  Maybe it would be able to
> > report this to the user via SMART, I don't know.
> 
> ATA/SCSI SMART is already DONE!
> 
> To bad most people have not noticed.

Oh, I know SMART is implemented, although I haven't actually seen/used a
tool which takes advantage of it (do you have such a thing?).  It would
be nice if there were messages appearing in my syslog (just like the
AIX days) which said "there were 10 temporary read errors at block M on
drive X yesterday" and "1 permanent write error at block M, block remapped
on drive X yesterday", so I would know _before_ my drive craps out
after all of the remapping table is full, or the temporary read errors
become permanent.  (I have a special interest in that because my laptop
hard drive sounds like a jet engine at times... ;-).

What I was originally suggesting is that it have a field which can report
to the user that "there were 800 sync/reset operations because of power
drops that were later found not to be power failures".  That is what
I was suggesting SMART report in this case (actual power failures are
not interesting).  Note also, that this is purely hypothetical, based
on only a vague understanding on what actually happens when the drive
thinks it is losing power, and only ever having seen the hex output
of /proc/ide/hda/smart_{values,thresholds}.

Being able to get a number back from the hard drive that it is performing
poorly (i.e. synchronous I/O + lots of resets) because of a bad power supply
is exactly what SMART was designed to do - predictive failure analysis.

Cheers, Andreas
--
Andreas Dilger
http://sourceforge.net/projects/ext2resize/
http://www-mddsp.enel.ucalgary.ca/People/adilger/

