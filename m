Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S282805AbRK0FEj>; Tue, 27 Nov 2001 00:04:39 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S282802AbRK0FEa>; Tue, 27 Nov 2001 00:04:30 -0500
Received: from fluent1.pyramid.net ([206.100.220.212]:31015 "EHLO
	fluent1.pyramid.net") by vger.kernel.org with ESMTP
	id <S282804AbRK0FER>; Tue, 27 Nov 2001 00:04:17 -0500
Message-Id: <4.3.2.7.2.20011126204425.00bcdbd0@10.1.1.42>
X-Mailer: QUALCOMM Windows Eudora Version 4.3.2
Date: Mon, 26 Nov 2001 21:04:03 -0800
To: Steve Underwood <steveu@coppice.org>, linux-kernel@vger.kernel.org
From: Stephen Satchell <satch@concentric.net>
Subject: Re: Journaling pointless with today's hard disks?
In-Reply-To: <3C02F2EC.7010809@coppice.org>
In-Reply-To: <tgpu68gw34.fsf@mercury.rus.uni-stuttgart.de>
 <20011124103642.A32278@vega.ipal.net>
 <20011124184119.C12133@emma1.emma.line.org>
 <tgy9kwf02c.fsf@mercury.rus.uni-stuttgart.de>
 <4.3.2.7.2.20011124150445.00bd4240@10.1.1.42>
 <3C002D41.9030708@zytor.com>
 <0f050uosh4lak5fl1r07bs3t1ecdonc4c0@4ax.com>
 <002f01c176d4$f79a3f70$0201a8c0@HOMER>
 <p05100301b82887aff497@[207.213.214.37]>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; format=flowed
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

At 09:57 AM 11/27/01 +0800, Steve Underwood wrote:
>Quite true. The drives really need to get an "oh heck, the power's about 
>to die. Quick, tidy up" signal from the outside world (like down the 
>ribbon). Cheap, at the limit, PSUs probably couldn't give enough notice to 
>be very helpful. Server grade ones should - they can usually ride over 
>brief hiccups in the power, so they should be able to give a few 10s of ms 
>notice before the regulated power lines start to droop. Perhaps the ATA 
>command set should include such a feature, so the OS could take 
>instruction from the hardware on the power situation, and tell the drives 
>what to do.

Looking at the various interface specifications, both SCSI and ATA have the 
ability to signal to the drive that the power is going, and do it in such a 
way that the drive would have at least 10 milliseconds from the time the 
hardware signal is received by the drive before +5 and +12 go out of 
specification.

This time is based on the specifications for ATX power supplies, as I 
assume most modern boxes that are used for production applications would be 
using an ATX power supply or similar.  Lest you think this lets older 
systems off the hook, the 1981 IBM PC Technical Reference describes (in 
looser language) a similar requirement.

The question remains whether (1) modern motherboards and SCSI controllers 
pass through the POWER-OK signal to the RESET- line (IDE/ATA) and RSET 
(SCSI), and (2) the hard drives respond intelligently to power-failure 
indications.

Telling the difference between a bus-reset event and a panic reset would be 
easy:  if the reset signal is asserted for more than a millisecond or two 
(such as when the POWER-OK signal from the power supply goes away) then the 
box is in a power panic situation.  Preventing spurious power panics is the 
responsibility of the power supply designer, particularly if the supply 
uses a large energy-storage capacitor designed to let the system ride out 
power-switching events without hiccup.

Suggestion to the people contributing to ATA-7:  write some language that 
talks specifically about power-failure scenarios, and define a power-crisis 
state based on the signals available to the drives from ATA interfaces to 
determine that a power-crisis event has occurred.  If the committee would 
sit still for it, make it a separate section that appears in the table of 
contents.

Suggestion to the people contributing to SCSI standards:  ditto.

Satch

