Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030381AbWBNHwF@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030381AbWBNHwF (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 14 Feb 2006 02:52:05 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030401AbWBNHwF
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 14 Feb 2006 02:52:05 -0500
Received: from rrzmta2.rz.uni-regensburg.de ([132.199.1.17]:3226 "EHLO
	rrzmta2.rz.uni-regensburg.de") by vger.kernel.org with ESMTP
	id S1030381AbWBNHwE (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 14 Feb 2006 02:52:04 -0500
From: "Ulrich Windl" <ulrich.windl@rz.uni-regensburg.de>
Organization: Universitaet Regensburg, Klinikum
To: linux-kernel@vger.kernel.org
Date: Tue, 14 Feb 2006 08:51:45 +0100
MIME-Version: 1.0
Subject: net socket load balancing
Message-ID: <43F19A21.14245.561E76D@Ulrich.Windl.rkdvmks1.ngate.uni-regensburg.de>
X-mailer: Pegasus Mail for Windows (4.31)
Content-type: text/plain; charset=US-ASCII
Content-transfer-encoding: 7BIT
Content-description: Mail message body
X-Content-Conformance: HerringScan-0.25/Sophos-P=4.02.0+V=4.02+U=2.07.127+R=06 February 2006+T=118673@20060214.074841Z
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

Occasionally I'm a masochist: Recently I configured PPP dialup over a 2400 baud 
modem. That modem has some big advantages: It has separate LEDs for about any 
MODEM state (like Rx and Tx). The device being connected to had a web interface 
and SSH.

While the web interface was loading a Java applet over https for minutes, I 
decided to login in via SSH instead.

Looking at the modem's LEDs I could see that the modem was receiving many long 
chunks, while transmitting infrequent short chunks (packet ACKs) periodically. 
However the "ssh -v" stalled during key exchange: The device (SSH server) could 
not send the data in the socket buffer (for over a minute) before the SSH client 
timed out key exchange.

That (and a periodic netstat on the server box) gave me the impression that the 
kernel code does not do fair bandwidth sharing between sockets sending to one 
specific device (those few bytes in the send queue of the SSH socket just stayed 
there). It seems the send queue for one socket is completely flushed before 
another socket is considered, regardless of the MTU. While on fast devices this is 
hardly ever a problem, it can be for slow devices.

I just wanted to point out that problem, together with a cheap method to 
demonstrate.

For reference, the embedded device has a 48MHz PPC with Linux 2.6.11, and the 
client was Novell/SuSE Linux 10.0 with Linux 2.6.13.

Regards,
Ulrich
(renowned for not being subscribed to lkml, always asking for a CC:)

