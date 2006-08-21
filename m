Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751134AbWHUVWq@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751134AbWHUVWq (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 21 Aug 2006 17:22:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751140AbWHUVWq
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 21 Aug 2006 17:22:46 -0400
Received: from faui03.informatik.uni-erlangen.de ([131.188.30.103]:20385 "EHLO
	faui03.informatik.uni-erlangen.de") by vger.kernel.org with ESMTP
	id S1751134AbWHUVWp (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 21 Aug 2006 17:22:45 -0400
Date: Mon, 21 Aug 2006 23:22:43 +0200
From: Thomas Glanzmann <sithglan@stud.uni-erlangen.de>
To: LKML <linux-kernel@vger.kernel.org>
Cc: Stephen Hemminger <shemminger@osdl.org>
Subject: sky2 doesn't receive any packages after I ssh in via ipv6 and edit a file in vim (reproducable)
Message-ID: <20060821212243.GA1558@cip.informatik.uni-erlangen.de>
Mail-Followup-To: Thomas Glanzmann <sithglan@stud.uni-erlangen.de>,
	LKML <linux-kernel@vger.kernel.org>,
	Stephen Hemminger <shemminger@osdl.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.11-2006-07-11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,
I have the newest sky2 driver (with the newest fix in version 1.5)
running on my intel mac mini running under legacy bios modus. However if
I ssh in via IPv6 and start vim in the shell to edit a file the sky2
network adapter stops to work. This is reproducable. A friend of mine
thought that maybe the IPv6 code doesn't request the right checksum. But
I have no clue if it is related to this. I can give access to the
machine via ssh (including root) if someone is willing to track this
down. I have a userland programming running which reboots the machine if
the network connectivity is lost. At least this one is reliable. If
noone wants a shell account maybe someone can guide me through
debugging and tracking this down.

(mini) [/var/log] grep sky2 kern.log
Aug 20 20:52:10 mini kernel: sky2 v1.5 addr 0x90200000 irq 17 Yukon-EC (0xb6) rev 2
Aug 20 20:52:10 mini kernel: sky2 eth0: addr 00:16:cb:a3:91:3c
Aug 20 20:52:12 mini kernel: sky2 eth0: enabling interface
Aug 20 20:52:12 mini kernel: sky2 eth0: Link is up at 100 Mbps, full duplex, flow control both
Aug 20 21:01:34 mini kernel: sky2 eth0: hw error interrupt status 0x30
Aug 20 21:01:34 mini kernel: sky2 eth0: ram data read parity error
Aug 20 21:01:34 mini kernel: sky2 eth0: ram data write parity error
Aug 20 21:01:34 mini kernel: sky2 eth0: hw error interrupt status 0x8
Aug 20 21:01:34 mini kernel: sky2 eth0: MAC parity error
Aug 20 21:01:34 mini kernel: sky2 eth0: hw error interrupt status 0x20
Aug 20 21:01:34 mini kernel: sky2 eth0: ram data read parity error
Aug 20 21:01:34 mini kernel: sky2 eth0: hw error interrupt status 0x8
Aug 20 21:01:34 mini kernel: sky2 eth0: MAC parity error
Aug 21 11:23:49 mini kernel: sky2 v1.5 addr 0x90200000 irq 17 Yukon-EC (0xb6) rev 2
Aug 21 11:23:49 mini kernel: sky2 eth0: addr 00:16:cb:a3:91:3c
Aug 21 11:23:50 mini kernel: sky2 eth0: enabling interface
Aug 21 11:23:50 mini kernel: sky2 eth0: Link is up at 100 Mbps, full duplex, flow control both
Aug 21 18:38:44 mini kernel: sky2 eth0: hw error interrupt status 0x30
Aug 21 18:38:44 mini kernel: sky2 eth0: ram data read parity error
Aug 21 18:38:44 mini kernel: sky2 eth0: ram data write parity error
Aug 21 18:38:44 mini kernel: sky2 eth0: hw error interrupt status 0x8
Aug 21 18:38:44 mini kernel: sky2 eth0: MAC parity error
Aug 21 18:38:44 mini kernel: sky2 eth0: hw error interrupt status 0x20
Aug 21 18:38:44 mini kernel: sky2 eth0: ram data read parity error
Aug 21 18:38:44 mini kernel: sky2 eth0: hw error interrupt status 0x8
Aug 21 18:38:44 mini kernel: sky2 eth0: MAC parity error
Aug 21 18:48:31 mini kernel: sky2 v1.5 addr 0x90200000 irq 17 Yukon-EC (0xb6) rev 2
Aug 21 18:48:31 mini kernel: sky2 eth0: addr 00:16:cb:a3:91:3c
Aug 21 18:48:32 mini kernel: sky2 eth0: enabling interface
Aug 21 18:48:32 mini kernel: sky2 eth0: Link is up at 100 Mbps, full duplex, flow control both
Aug 21 20:53:56 mini kernel: sky2 eth0: tx timeout
Aug 21 20:53:56 mini kernel: sky2 eth0: transmit ring 53 .. 30 report=54 done=54
Aug 21 20:53:56 mini kernel: sky2 status report lost?
Aug 21 20:54:01 mini kernel: sky2 eth0: tx timeout
Aug 21 20:54:01 mini kernel: sky2 eth0: transmit ring 53 .. 30 report=54 done=54
Aug 21 20:54:01 mini kernel: sky2 status report lost?
Aug 21 20:54:06 mini kernel: sky2 eth0: tx timeout
Aug 21 20:54:06 mini kernel: sky2 eth0: transmit ring 53 .. 30 report=54 done=54
Aug 21 20:54:06 mini kernel: sky2 status report lost?
Aug 21 20:54:11 mini kernel: sky2 eth0: tx timeout
Aug 21 20:54:11 mini kernel: sky2 eth0: transmit ring 53 .. 30 report=54 done=54
Aug 21 20:54:11 mini kernel: sky2 status report lost?
Aug 21 20:54:16 mini kernel: sky2 eth0: tx timeout
Aug 21 20:54:16 mini kernel: sky2 eth0: transmit ring 53 .. 30 report=54 done=54
Aug 21 20:54:16 mini kernel: sky2 status report lost?
Aug 21 20:54:21 mini kernel: sky2 eth0: tx timeout
Aug 21 20:54:21 mini kernel: sky2 eth0: transmit ring 53 .. 30 report=54 done=54
Aug 21 20:54:21 mini kernel: sky2 status report lost?
Aug 21 20:54:26 mini kernel: sky2 eth0: tx timeout
Aug 21 20:54:26 mini kernel: sky2 eth0: transmit ring 53 .. 30 report=54 done=54
Aug 21 20:54:26 mini kernel: sky2 status report lost?
Aug 21 20:54:31 mini kernel: sky2 eth0: tx timeout
Aug 21 20:54:31 mini kernel: sky2 eth0: transmit ring 53 .. 30 report=54 done=54
Aug 21 20:54:31 mini kernel: sky2 status report lost?
Aug 21 20:54:36 mini kernel: sky2 eth0: tx timeout
Aug 21 20:54:36 mini kernel: sky2 eth0: transmit ring 53 .. 30 report=54 done=54
Aug 21 20:54:36 mini kernel: sky2 status report lost?
Aug 21 20:54:41 mini kernel: sky2 eth0: tx timeout
Aug 21 20:54:41 mini kernel: sky2 eth0: transmit ring 53 .. 30 report=54 done=54
Aug 21 20:54:41 mini kernel: sky2 status report lost?
Aug 21 20:54:46 mini kernel: sky2 eth0: tx timeout
Aug 21 20:54:46 mini kernel: sky2 eth0: transmit ring 53 .. 30 report=54 done=54
Aug 21 20:54:46 mini kernel: sky2 status report lost?
Aug 21 20:54:51 mini kernel: sky2 eth0: tx timeout
Aug 21 20:54:51 mini kernel: sky2 eth0: transmit ring 53 .. 30 report=54 done=54
Aug 21 20:54:51 mini kernel: sky2 status report lost?
Aug 21 20:56:17 mini kernel: sky2 v1.5 addr 0x90200000 irq 17 Yukon-EC (0xb6) rev 2
Aug 21 20:56:17 mini kernel: sky2 eth0: addr 00:16:cb:a3:91:3c
Aug 21 20:56:18 mini kernel: sky2 eth0: enabling interface
Aug 21 20:56:18 mini kernel: sky2 eth0: Link is up at 100 Mbps, full duplex, flow control both

This log messgaes are all related to the same problem. At the moment my
userland watchdog reboots the machine after 500 seconds:

(mini) [/var/log] grep watchdog-tg daemon.log
Aug 20 20:42:32 mini watchdog-tg[1763]: No PONG received from 192.168.0.3 (failure 1 of 50)
...
Aug 20 20:50:48 mini watchdog-tg[1763]: No PONG received from 192.168.0.3 (failure 50 of 50)
Aug 20 20:50:48 mini watchdog-tg[1763]: Telling init to reboot and no longer feed watchdog
Aug 21 18:38:49 mini watchdog-tg[1761]: No PONG received from 192.168.0.3 (failure 1 of 50)
...
Aug 21 18:47:07 mini watchdog-tg[1761]: No PONG received from 192.168.0.3 (failure 50 of 50)
Aug 21 18:47:07 mini watchdog-tg[1761]: Telling init to reboot and no longer feed watchdog
Aug 21 20:46:31 mini watchdog-tg[1755]: No PONG received from 192.168.0.3 (failure 1 of 50)
...
Aug 21 20:54:49 mini watchdog-tg[1755]: No PONG received from 192.168.0.3 (failure 50 of 50)
Aug 21 20:54:49 mini watchdog-tg[1755]: Telling init to reboot and no longer feed watchdog

        Thomas
