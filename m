Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S311871AbSDCOw2>; Wed, 3 Apr 2002 09:52:28 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S311834AbSDCOwS>; Wed, 3 Apr 2002 09:52:18 -0500
Received: from london.rubylane.com ([208.184.113.40]:43901 "HELO
	london.rubylane.com") by vger.kernel.org with SMTP
	id <S311884AbSDCOwD>; Wed, 3 Apr 2002 09:52:03 -0500
Message-ID: <20020403145202.27388.qmail@london.rubylane.com>
From: jim@rubylane.com
Subject: Re: Update on Promise 100TX2 + Serverworks IDE issues -- 2.2.20
To: tbrown@baremetal.com (Tom Brown)
Date: Wed, 3 Apr 2002 06:52:02 -0800 (PST)
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <Pine.LNX.4.10.10204022311020.24257-100000@tom2.baremetal.com> from "Tom Brown" at Apr 02, 2002 11:12:18 PM
X-Mailer: ELM [version 2.5 PL1]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> 
> On Tue, 2 Apr 2002 jim@rubylane.com wrote:
> 
> > > 
> > > On Tue, 2 Apr 2002 jim@rubylane.com wrote:
> > > > 2. The MB IDE ports transfer data at about 18000K/sec while doing
> > > > cat /dev/hda >/dev/null and looking at vmstat.
> > > 
> > > I think the serverworks IDE is only mode4, not even UDMA33.  I heard a lot of
> > > bad things about it, and removed all the IDE drives from our serverworks
> > > system's controller.
> > > 
> > > > hdk.  In a 32-bit slot, cat /dev/hdx >/dev/null shows 31300K/sec.  But
> > > > doing cat /dev/hde4 (a specific partition) for example gives
> > > > 8400K/sec.  That makes no sense to me.
> > > 
> > > The outer cylinders of a drive are faster than the inner cylinders.  Try
> > > repartitioning the drive so that hde4 starts at cylinder 1, and see if that
> > > changes the speed.
> > 
> > That's not it because all 4 drives are partitioned the same, yet hde4
> > gives 8400K/sec and hdk4 gives 31000K.  Also there are the same number
> > of interrupts/sec and context switches per sec according to vmstat in
> > the 8400 and 31000 case.
> 
> sure you've got the same block size?  8400 * 4 is suspiciously close the
> 31000 ... I don't use vmstat, so I'm not sure if it reports blocks or
> kbyte /sec

Yeah, I even remade the file systems on both drives and got the same
result.  

After moving the drives around on the Promise controller and moving 1
drive back to the MB IDE port, it looks like all drives are running at
high speed.  I dunno - it's weird.  I wouldn't be surprised if one of
the drives arbitrarily reverts back to the slower speed at some point
or after a future reboot, though it hasn't yet.

I was thinking maybe burst mode was not getting turned on, not working,
or getting turned off on some of the Promise ports for some reason.

vmstat reports KB/sec.

Jim
