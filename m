Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S270795AbTGNUZB (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 14 Jul 2003 16:25:01 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S270794AbTGNUYb
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 14 Jul 2003 16:24:31 -0400
Received: from pc2-cwma1-4-cust86.swan.cable.ntl.com ([213.105.254.86]:8900
	"EHLO lxorguk.ukuu.org.uk") by vger.kernel.org with ESMTP
	id S270800AbTGNUWC (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 14 Jul 2003 16:22:02 -0400
Subject: Re: Alan Shih: "TCP IP Offloading Interface"
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: David griego <dagriego@hotmail.com>
Cc: alan@storlinksemi.com,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
In-Reply-To: <Sea2-F42G9i3HGRgKuw00017dcf@hotmail.com>
References: <Sea2-F42G9i3HGRgKuw00017dcf@hotmail.com>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Organization: 
Message-Id: <1058214842.606.151.camel@dhcp22.swansea.linux.org.uk>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.2.2 (1.2.2-5) 
Date: 14 Jul 2003 21:34:08 +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Llu, 2003-07-14 at 21:19, David griego wrote:
> Embedded does not simply include toasters and fridges, it also includes NAS 
> and SAN appliances as well as telco gear.  These types of devices have 

I have some sympathy with SAN developers, because you can treat the link
as dedicated and just for the SAN so you can implement iSCSI optimised
code. The right engineering approach probably consists of removing iSCSI
and doing the job right but I appreciate there are non engineering
issues.

> advanced memory subsystems and run processors such as PPC and ARM.  One of 
> the most limiting factors in these types of devices is power consumption.  

Memory bandwidth is your killer quite often, you have to keep the CPU
away from the data and often even off the memory bus holding most of the
data.

> >deeply embedded stuff also doesn't run with MMUs or runs 'partially
> >trusted' most of the VM games and the socket api games also go away.
> 
> See PPC and ARM architecture for the use of MMUs in embedded systems

You still have the partial trust stuff and the ability to violate the
socket api in the interest of speed - that helps.

> >TCP/IP is an exercise in two things when you are running at speed
> >
> >1.	Finding the memory bandwidth - ToE doesn't help, checksums do,
> >	sg does, on card target buffers do with decent chipsets.
> 
> A TOE enabled with RDDP would help eliminate the kernel to user space copy 
> (and in the case of SAMBA the copy back to the kernel).  This would reduce 
> the memory system loading by a third to a half.

Thats mostly an API issue. Socket API found non optimal after 20 years.
Hardly shocking news - the cluster people already changed API, Larry
McVoy proposed stuff like splice years ago because he saw it coming.

> >2.	Handling in order perfectly predicted data streams. ToE is
> >	overkill for this. Thats about latency to memory and touching
> >	as little as possible. The main CPU has a rather good connection
> >	to main memory.
> >
> Yes, RDDP would be nice to have though for the reason stated for #1, so the 
> hardware would need to at least be TCP aware.

TCP aware hardware is good, segmentation, prediction, buffer/sequence
matchers etc but you don't want the policy parts in silicon

> >repeatedly been screwed by attackers hitting software or other slow
> >paths in the device to attack it.
> The use of ASICs could ensure that TCP processing is as quick as wire speed

Only if your ASIC worst case is wire speed. If your ASIC has one path it
must drop to software for and has a low powered internal CPU to fix up,
you just lost and you'll plow like a cisco with too many filter rules to
do in silicon.

> Try to keep the datapath processing on the TOE, and everything else in the 
> OS.  Also give the API the ability to turn of the TOE if a hole exists and 
> use it like a regular NIC.

Some of this is certainly about how you partition the load - its no
different to things like RAID. We've had hardware raid, software raid,
and finally people are popping up with neat hybrids. We've had software
audio, hardware audio and again now we are seeing hybrids that do
different bits in hardware and software - ditto modems.

> >The internet land speed record is held by a non ToE system, let me know
> >when that changes.
> >
> Layer one network processing is often handled by ASICS, also some of the 
> fastest encryption engines are hardware.  I suggest we don't wait until your 
> proven wrong before making a decision on TOE.

You don't have to. You can go build and test and maintain a set of TOE patches.
Nobody is stopping you. Lots of Linux code exists because someone decided that
the official story was wrong and proved it so.

Alan

