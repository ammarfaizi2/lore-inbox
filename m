Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S318428AbSHKW01>; Sun, 11 Aug 2002 18:26:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S318432AbSHKW01>; Sun, 11 Aug 2002 18:26:27 -0400
Received: from shill.XCF.Berkeley.EDU ([128.32.112.247]:7955 "EHLO
	wilber.gimp.org") by vger.kernel.org with ESMTP id <S318428AbSHKW00>;
	Sun, 11 Aug 2002 18:26:26 -0400
Date: Sun, 11 Aug 2002 15:30:11 -0700
From: Joshua Uziel <uzi@uzix.org>
To: Kieran <kieran@esperi.demon.co.uk>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Ultrasparc 1 network freeze
Message-ID: <20020811223010.GB16890@uzix.org>
References: <Pine.LNX.4.43.0208112110500.391-100000@amaterasu.srvr.nix>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.43.0208112110500.391-100000@amaterasu.srvr.nix>
User-Agent: Mutt/1.3.28i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

* Kieran <kieran@esperi.demon.co.uk> [020811 13:58]:
> I've got an ultra 1 with on-board HME that I'm trying to install linux
> on via the serial console.
...
> NETDEV WATCHDOG: eth0: transmit timed out
> eth0: transmit timed out, resetting
> eth0: Happy Status 03030000 TX[000003ff:00000101]
... 
> Reboot seems to cure the problem (via break on the console and then
> issuing a boot command at the prom monitor), until further stress is
> applied.

Yep... known issue with the sunhme driver.  AFAIK, it only affects the
HME onboard the U1E systems and no other HMEs.  The quick band-aid
work-around is at the end of this email... seems to be some weirdo
timing issue.  This patch has resolved the issue for several people with
U1E's.  (E == enterprise... UPA (for a Creator3D), wide scsi and hme
(insted of an le on the non-E models)).

--- drivers/net/sunhme.c.orig	Mon Jul 15 02:38:27 2002
+++ drivers/net/sunhme.c	Mon Jul 15 03:09:03 2002
@@ -1983,6 +1983,7 @@
 	}
 	hp->tx_old = elem;
 	TXD((">"));
+	udelay(1);
 
 	if (netif_queue_stopped(dev) &&
 	    TX_BUFFS_AVAIL(hp) > (MAX_SKB_FRAGS + 1))

