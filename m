Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S275813AbRJUKPc>; Sun, 21 Oct 2001 06:15:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S275816AbRJUKPX>; Sun, 21 Oct 2001 06:15:23 -0400
Received: from tartarus.telenet-ops.be ([195.130.132.34]:62700 "EHLO
	tartarus.telenet-ops.be") by vger.kernel.org with ESMTP
	id <S275813AbRJUKPO>; Sun, 21 Oct 2001 06:15:14 -0400
Subject: Xircom card problems on apm resume (xirc2ps_cs)
From: Roel Teuwen <Roel.Teuwen@advalvas.be>
To: linux-kernel@vger.kernel.org
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Evolution/0.16.99+cvs.2001.10.18.15.19 (Preview Release)
Date: 21 Oct 2001 12:21:54 +0200
Message-Id: <1003659714.1087.17.camel@omniroel>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello all, 

When resuming after an apm -s, my xircom card (REM56G-100) is no longer
functional. I need to ifdown,rmmod,modprobe,ifup in order to get it to
work again. On suspend, all leds on the connector go off, upon resume
the link light comes back on, but the activity light remains off when
doing a ping for example. 
When starting the ping (as a test, any traffic will do) the following is
displayed in dmesg every second, even after stopping the ping. ifdown
stops these : 

eth0: media 10Base2, silicon revision 4 
NETDEV WATCHDOG: eth0: transmit timed out 
eth0: transmit timed out 

No packets are shown as RX,TX or error in ifconfig.

An ifdown/ifup appears to get rid of these messages and causes the
following to be printed in dmesg :
eth0: media 10Base2, silicon revision 4

However, the interface still does not work (ping reports destination
host unreachable) and no packets are shown in ifconfig stats.

Please note that a successful modprobe shows a different media and chip
revision than the watchdog message and ifdown/ifup, and also shows MII
messages : 

xirc2ps_cs.c 1.31 1998/12/09 19:32:55 (dd9jn+kvh) 
eth0: MII link partner: 0021 
eth0: MII selected 
eth0: media 10BaseT, silicon revision 0 
eth0: MII link partner: 0021 
eth0: MII selected 
eth0: media 10BaseT, silicon revision 0 
eth0: Xircom: port 0x300, irq 3, hwaddr 00:10:A4:93:5D:78 

After this, all is well.

I am running kernel 2.4.12-ac3, but I haven't found a past 2.4 kernel
(yet) that makes this work without problems.

Maybe unrelated, on this laptop the apm -s command only succeeds when it
is running on battery power, trying to suspend with the AC cord plugged
in causes it to resume (if it ever suspends at all) nearly instantly.

I hope all this isn't too vague. If you need more information, don't
hesistate to contact me.

Kind Regards,

Roel Teuwen

