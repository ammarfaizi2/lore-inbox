Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S270734AbTGNTcV (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 14 Jul 2003 15:32:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S270847AbTGNTcU
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 14 Jul 2003 15:32:20 -0400
Received: from pc2-cwma1-4-cust86.swan.cable.ntl.com ([213.105.254.86]:59587
	"EHLO lxorguk.ukuu.org.uk") by vger.kernel.org with ESMTP
	id S270734AbTGNTal (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 14 Jul 2003 15:30:41 -0400
Subject: Re: Alan Shih: "TCP IP Offloading Interface"
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: David griego <dagriego@hotmail.com>
Cc: alan@storlinksemi.com,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
In-Reply-To: <Sea2-F18ekWo76UaiRN00008964@hotmail.com>
References: <Sea2-F18ekWo76UaiRN00008964@hotmail.com>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Organization: 
Message-Id: <1058211772.554.120.camel@dhcp22.swansea.linux.org.uk>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.2.2 (1.2.2-5) 
Date: 14 Jul 2003 20:42:53 +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Llu, 2003-07-14 at 19:46, David griego wrote:
> IMHO, there are several cases for some type of TCP/IP offload.  One is for 
> embedded systems that are just not capable of doing 1Gbps+.  Another is with 

My fridge doesn't need to do 10Gbit a second, and for most other
embedded the constraints are ram bandwidth and nothing else. Since
deeply embedded stuff also doesn't run with MMUs or runs 'partially
trusted' most of the VM games and the socket api games also go away.

I've done deeply embedded tcp/ip. I don't buy the argument, embedded
gains the least of all from ToE. 

> 10GbE, even high end servers will not be able keep up with TCP 
> processing/data movement at these speeds.  Not being proactive in adopting 

They said that about 10Mbit until Van showed them a thing or two. They
said it about 100Mbit, they said it about gigabit.

> TCP/IP offload will force Linux into accepting some scheme that will not 
> necissarily be best.

TCP/IP is an exercise in two things when you are running at speed

1.	Finding the memory bandwidth - ToE doesn't help, checksums do,
	sg does, on card target buffers do with decent chipsets.

2.	Handling in order perfectly predicted data streams. ToE is 
	overkill for this. Thats about latency to memory and touching
	as little as possible. The main CPU has a rather good connection
	to main memory.

ToE is also horribly vulnerable to attack because putting it on a card
dictates relatively low CPU power and low power consumption as well as
rather nasty pricing issues. Historically low power devices have 
repeatedly been screwed by attackers hitting software or other slow
paths in the device to attack it.

This is before we get into the delights of multipath routing across
different vendors cards, firewalling, traffic shaping, retrofitting new
features, questions about what happens with an old ToE card when its
got a hole...

The internet land speed record is held by a non ToE system, let me know
when that changes.

