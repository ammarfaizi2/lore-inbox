Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S270798AbTGNUNY (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 14 Jul 2003 16:13:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S270797AbTGNUJS
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 14 Jul 2003 16:09:18 -0400
Received: from sea2-f42.sea2.hotmail.com ([207.68.165.42]:15369 "EHLO
	hotmail.com") by vger.kernel.org with ESMTP id S270793AbTGNUEl
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 14 Jul 2003 16:04:41 -0400
X-Originating-IP: [143.182.124.3]
X-Originating-Email: [dagriego@hotmail.com]
From: "David griego" <dagriego@hotmail.com>
To: alan@lxorguk.ukuu.org.uk
Cc: alan@storlinksemi.com, linux-kernel@vger.kernel.org
Subject: Re: Alan Shih: "TCP IP Offloading Interface"
Date: Mon, 14 Jul 2003 13:19:29 -0700
Mime-Version: 1.0
Content-Type: text/plain; format=flowed
Message-ID: <Sea2-F42G9i3HGRgKuw00017dcf@hotmail.com>
X-OriginalArrivalTime: 14 Jul 2003 20:19:29.0948 (UTC) FILETIME=[3AFEC5C0:01C34A45]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Embedded does not simply include toasters and fridges, it also includes NAS 
and SAN appliances as well as telco gear.  These types of devices have 
advanced memory subsystems and run processors such as PPC and ARM.  One of 
the most limiting factors in these types of devices is power consumption.  
This usually limits the number of cores and frequency these cores.  
Offloading the processing of protocol stacks to ASICS would have a great 
impact in performance.  If you are going to embed a high frequency chip in 
your embedded devices I would recommend developing a heater not a fridge.


>From: Alan Cox <alan@lxorguk.ukuu.org.uk>
>To: David griego <dagriego@hotmail.com>
>CC: alan@storlinksemi.com,   Linux Kernel Mailing List 
><linux-kernel@vger.kernel.org>
>Subject: Re: Alan Shih: "TCP IP Offloading Interface"
>Date: 14 Jul 2003 20:42:53 +0100
>
>On Llu, 2003-07-14 at 19:46, David griego wrote:
> > IMHO, there are several cases for some type of TCP/IP offload.  One is 
>for
> > embedded systems that are just not capable of doing 1Gbps+.  Another is 
>with
>
>My fridge doesn't need to do 10Gbit a second, and for most other
>embedded the constraints are ram bandwidth and nothing else. Since
>deeply embedded stuff also doesn't run with MMUs or runs 'partially
>trusted' most of the VM games and the socket api games also go away.

See PPC and ARM architecture for the use of MMUs in embedded systems

>
>I've done deeply embedded tcp/ip. I don't buy the argument, embedded
>gains the least of all from ToE.
>
> > 10GbE, even high end servers will not be able keep up with TCP
> > processing/data movement at these speeds.  Not being proactive in 
>adopting
>
>They said that about 10Mbit until Van showed them a thing or two. They
>said it about 100Mbit, they said it about gigabit.

Not the case for embedded.  I understand your viewpoint from the server 
space though.
>
> > TCP/IP offload will force Linux into accepting some scheme that will not
> > necessarily be best.
>
>TCP/IP is an exercise in two things when you are running at speed
>
>1.	Finding the memory bandwidth - ToE doesn't help, checksums do,
>	sg does, on card target buffers do with decent chipsets.

A TOE enabled with RDDP would help eliminate the kernel to user space copy 
(and in the case of SAMBA the copy back to the kernel).  This would reduce 
the memory system loading by a third to a half.
>
>2.	Handling in order perfectly predicted data streams. ToE is
>	overkill for this. Thats about latency to memory and touching
>	as little as possible. The main CPU has a rather good connection
>	to main memory.
>
Yes, RDDP would be nice to have though for the reason stated for #1, so the 
hardware would need to at least be TCP aware.

>ToE is also horribly vulnerable to attack because putting it on a card
>dictates relatively low CPU power and low power consumption as well as
>rather nasty pricing issues. Historically low power devices have
>repeatedly been screwed by attackers hitting software or other slow
>paths in the device to attack it.
The use of ASICs could ensure that TCP processing is as quick as wire speed

>
>This is before we get into the delights of multipath routing across
>different vendors cards, firewalling, traffic shaping, retrofitting new
>features, questions about what happens with an old ToE card when its
>got a hole...
Try to keep the datapath processing on the TOE, and everything else in the 
OS.  Also give the API the ability to turn of the TOE if a hole exists and 
use it like a regular NIC.
>
>The internet land speed record is held by a non ToE system, let me know
>when that changes.
>
Layer one network processing is often handled by ASICS, also some of the 
fastest encryption engines are hardware.  I suggest we don't wait until your 
proven wrong before making a decision on TOE.

_________________________________________________________________
MSN 8 helps eliminate e-mail viruses. Get 2 months FREE*.  
http://join.msn.com/?page=features/virus

