Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S316827AbSEVCDf>; Tue, 21 May 2002 22:03:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S316829AbSEVCDe>; Tue, 21 May 2002 22:03:34 -0400
Received: from samba.sourceforge.net ([198.186.203.85]:38554 "HELO
	lists.samba.org") by vger.kernel.org with SMTP id <S316827AbSEVCDd>;
	Tue, 21 May 2002 22:03:33 -0400
Date: Wed, 22 May 2002 11:53:05 +1000
From: David Gibson <hermes@gibson.dropbear.id.au>
To: Peter Chubb <peter@chubb.wattle.id.au>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Orinoco Wireless driver bugs in 2.5.17
Message-ID: <20020522015305.GJ4745@zax>
Mail-Followup-To: David Gibson <hermes@gibson.dropbear.id.au>,
	Peter Chubb <peter@chubb.wattle.id.au>,
	linux-kernel@vger.kernel.org
In-Reply-To: <15594.57612.421887.407469@wombat.chubb.wattle.id.au>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.28i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, May 22, 2002 at 10:06:36AM +1000, Peter Chubb wrote:
> 
> Hi,
> 	I see two undesireable behaviours with the Orinoco drivers in
> 2.5.17.
> 
> 1.  With a compaq WL110 in a WL210 PCI<->PCMCIA bridge, I see many 
> 
>     NETDEV WATCHDOG: eth1: transmit timed out
>     Tx timeout! Resetting card. ALLOCFID=00c0, TXCOMPLFID=00bf, EVSTAT=808a
> 
> messages, and see no activity on any other stations.

I've had one similar report, on a vaguely similar PCI<->PCMCIA
bridge.  It looks very much as if we're not receiving any interrupts.
That would appear to be a low-level problem with routing of interrupts
through the bridge.  It may well be a PCMCIA subsystem problem rather
than a driver problem.

> 2.  With a Netgear MA401, every now and then the card goes into bozo
> mode, when iwconfig reports:
> 
> eth0      IEEE 802.11-DS  Nickname:"piggle"
>           Mode:Managed  Frequency:42.9497GHz  Tx-Power=15 dBm   
>           RTS thr:off   
>           Link Quality:241  Signal level:136  Noise level:107
>           Rx invalid nwid:0  Rx invalid crypt:0  Rx invalid frag:0
>           Tx excessive retries:0  Invalid misc:0   Missed beacon:0
> 
> 
> Note the Frequency there.  A `cardctl reset' fixes the problem.

Other than the bogus frequecy reported, does the card still work?

-- 
David Gibson			| For every complex problem there is a
david@gibson.dropbear.id.au	| solution which is simple, neat and
				| wrong.  -- H.L. Mencken
http://www.ozlabs.org/people/dgibson
