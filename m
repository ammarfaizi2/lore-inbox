Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751061AbWC0PDz@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751061AbWC0PDz (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 27 Mar 2006 10:03:55 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751058AbWC0PDz
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 27 Mar 2006 10:03:55 -0500
Received: from canuck.infradead.org ([205.233.218.70]:17820 "EHLO
	canuck.infradead.org") by vger.kernel.org with ESMTP
	id S1751061AbWC0PDy (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 27 Mar 2006 10:03:54 -0500
Message-ID: <4427FEC9.4010803@torque.net>
Date: Mon, 27 Mar 2006 10:03:37 -0500
From: Douglas Gilbert <dougg@torque.net>
Reply-To: dougg@torque.net
User-Agent: Mozilla Thunderbird 1.0.7-1.1.fc4 (X11/20050929)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Linus Torvalds <torvalds@osdl.org>
CC: Bodo Eggert <7eggert@gmx.de>, linux-scsi@vger.kernel.org,
       linux-kernel@vger.kernel.org
Subject: Re: [PATCH] Move SG_GET_SCSI_ID from sg to scsi
References: <Pine.LNX.4.58.0603262108500.13001@be1.lrz> <Pine.LNX.4.64.0603261424590.15714@g5.osdl.org>
In-Reply-To: <Pine.LNX.4.64.0603261424590.15714@g5.osdl.org>
X-Enigmail-Version: 0.92.0.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Linus Torvalds wrote:
> 
> On Sun, 26 Mar 2006, Bodo Eggert wrote:
> 
>>Having a SCSI ID is a generic SCSI property
> 
> 
> No it's not.
> 
> Havign a SCSI ID is a f*cking idiotic thing to do.
> 
> Only idiots like Joerg Schilling thinks that any such thing even _exists_. 
> It does not, never has, and never will.
> 
> The way you reach a SCSI device is through the device filename, and trying 
> to use controller/channel/id/lun naming IS INSANE!
> 
> Stop it now. We should kill that ioctl, not try to make it look like it is 
> sensible. It's not a sensible way to look up SCSI devices, and the fact 
> that some SCSI people think it is is doesn't make it so.
> 
> The fact is, you CANNOT ID a SCSI device that way. Look at how /sys does 
> it, and realize that there's a damn good reason we do it that way. We ID 
> the same device in many different ways, because different people want to 
> ID it differently.
> 
> You can ask "what's the first device we enumerated", you can ask "what's 
> the physical path to the device" or you can ask "what's the intrisic UUID 
> of the device". But the controller/channel/id/lun thing is just stupid. 
> You can look it up that way if you want to, but I refuse to have idiotic 
> interfaces that somehow try to make that the "official" name, when it 
> clearly is NOT.

Linus,
There are two things that really count:
  1) the identifier (preferably a world wide unique name)
     of the logical unit that is being addressed
  2) a topological description of how that logical unit
     is connected

For the last 25 years various OS SCSI subsystems have used
variants of 2) as a proxy for 1). Modern SCSI disks (and
soon SATA disks) have a world wide unique name associated
with their logical unit.

So why are modern SCSI standards full of terms like
I_T_L ** and I_T_L_Q nexus? Probably because the topology,
especially when there are multiple paths to the same
logical unit, is significant.

Linux's <hctl> may be a ham fisted way of describing
a path through a topology, but it easily beats /dev/sdabc
and /dev/sg4711 .
With a device node name like /dev/sdabc, a SCSI INQUIRY or
an ATA IDENTIFY DEVICE command can be sent to ascertain 1)
but I am unaware of any command sent to a logical unit that
will yield 2).


** that is: the nexus of an Initiator port, a Target port
   and a Logical unit number.

Doug Gilbert

