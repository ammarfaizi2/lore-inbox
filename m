Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267904AbUHKDMY@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267904AbUHKDMY (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 10 Aug 2004 23:12:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267907AbUHKDMX
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 10 Aug 2004 23:12:23 -0400
Received: from out005pub.verizon.net ([206.46.170.143]:171 "EHLO
	out005.verizon.net") by vger.kernel.org with ESMTP id S267904AbUHKDLw
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 10 Aug 2004 23:11:52 -0400
From: Gene Heskett <gene.heskett@verizon.net>
Reply-To: gene.heskett@verizon.net
Organization: Organization: None, detectable by casual observers
To: linux-kernel@vger.kernel.org
Subject: Re: PATCH: cdrecord: avoiding scsi device numbering for ide devices
Date: Tue, 10 Aug 2004 23:11:46 -0400
User-Agent: KMail/1.6.82
Cc: Matthias Andree <matthias.andree@gmx.de>
References: <200408101027.i7AARuZr012065@burner.fokus.fraunhofer.de> <200408101228.27455.gene.heskett@verizon.net> <20040811002455.GA7537@merlin.emma.line.org>
In-Reply-To: <20040811002455.GA7537@merlin.emma.line.org>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Message-Id: <200408102311.46729.gene.heskett@verizon.net>
X-Authentication-Info: Submitted using SMTP AUTH at out005.verizon.net from [151.205.9.122] at Tue, 10 Aug 2004 22:11:47 -0500
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tuesday 10 August 2004 20:24, Matthias Andree wrote:
>On Tue, 10 Aug 2004, Gene Heskett wrote:
>
>[burnproof decreases CD quality]
>
>> How so Joerg?  Making a blanket statement such as this requires a
>> good proof example IMO.  You not are giving one.
>
>The switch from read mode to write mode (i. e. find end of data,
>increase LASER power to write and pick up writing) takes some time
>(order of magnitude: µs) which means some pits/lands aren't right
> during that phase. How many pits/lands are broken break depends on
> hard- and firmware, write speed and model and for CAV the radial
> position on the disc. Fast writers will need to reach a linear
> velocity around 60 m/s (216 km/h); one µs time to ramp up LASER
> power from read to write level there means up to 60 µm lost.

And just how fast do you think that laser is being modulated?  At the 
bandwidth of that, the lazer's power could be brought back to write 
power levels in at least an order of magnitude less time than that.

I'd be far more concerned with the support electronics ability to 
detect the end of the previous write in a timely manner than in how 
long it took to bring the laser back up to write power.  My guess is 
that any space lost, and therefore unwritten on the disk, is much 
more an issue of detecting the loss than in 'ramping up the power' 
which can be done in modern drives in 5ns or less.  Now if the 
electronics could detect the first missing edge and initiate the 
write on that, the written edge needn't be more than 5ns late, a very 
minor glitch in the data recovery's phase locked loop, and probably 
fully recentered before the next 100 edges have gone by, certainly 
before the intersector synch data is used up and real data begins.

But, now consider this, a drive with burnproof should have a method of 
marking a burnproof event in the intersector sync data.  The drive 
should have at the point when the burnproof kicked in, written a 
known bit pattern that identifies a burnproof event in the 
intersector housekeeping.  From that, the drive can predict the end 
of the written data to a very high degree of accuracy, and switch up 
the laser precisely on time to not miss a pits edge at all.

So I don't find this argument convincing unless the drive makers are a 
bunch of dummies and haven't thought of the above scenario.  That 
theory doesn't hold any water either. The designers of these things 
will use every possible advantage to make their product a better 
mousetrap.  You can bet the farm that this method, or one even better 
is in use in every drive featureing burnproof today.

Much of what I just wrote could, I suppose, be considered proprietary 
data to the drive makers, and if I 'blew their cover', well stuff 
happens...  You cannot argue with common sense solutions to what 
looks like a complex problem to the average Joe Six-Pack.

And there's precious few of us here who think we're the Joe Six-Packs 
of this world.  "They" are not those who would subscribe to this list 
in the first place.  Generally speaking, we like to think we're a cut 
above that label...  Granted, there are many younger, brighter brains 
than mine on this list, and for that I'm thankfull every day.

>How far good improvements in the hard- and firmware have allowed to
>reduce that gap is beyond my current knowledge. Some figures are
> posted at: http://www.digital-sanyo.com/BURN-Proof/tips/No1.html
>    http://www.digital-sanyo.com/BURN-Proof/tips/No2.html

Moot point IMO, progress is made everyday by the drive people.  
Progress they aren't going to talk about for the competitive edge 
they need because if they did, the guy down the street would be out 
with a clone later today.  So take anything that purports to be "the 
bible" with an un-healthy amount of salt.

-- 
Cheers, Gene
"There are four boxes to be used in defense of liberty:
 soap, ballot, jury, and ammo. Please use in that order."
-Ed Howdershelt (Author)
99.24% setiathome rank, not too shabby for a WV hillbilly
Yahoo.com attorneys please note, additions to this message
by Gene Heskett are:
Copyright 2004 by Maurice Eugene Heskett, all rights reserved.
