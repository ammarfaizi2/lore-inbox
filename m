Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S268712AbRG3XJR>; Mon, 30 Jul 2001 19:09:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S268730AbRG3XJH>; Mon, 30 Jul 2001 19:09:07 -0400
Received: from [207.195.147.16] ([207.195.147.16]:49167 "EHLO
	MAILCLUSTER.lith.com") by vger.kernel.org with ESMTP
	id <S268712AbRG3XJA>; Mon, 30 Jul 2001 19:09:00 -0400
Message-ID: <AF020C5FC551DD43A4958A679EA16A1501349556@mailcluster.lith.com>
From: Erik De Bonte <erikd@lithtech.com>
To: linux-kernel@vger.kernel.org
Subject: Determining IP:port corresponding to an ICMP port unreachable
Date: Mon, 30 Jul 2001 16:08:56 -0700
MIME-Version: 1.0
X-Mailer: Internet Mail Service (5.5.2650.21)
Content-Type: text/plain;
	charset="iso-8859-1"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org
Original-Recipient: rfc822;linux-kernel-outgoing

When an ICMP port unreachable message is received and corresponds to a UDP
socket, is there a way to determine the corresponding unreachable IP and
port?  I'm able to retrieve the IP, but not the port.  From looking through
the kernel source, it appears that the port is never extracted from the
payload section of the ICMP message.  If this is indeed a limitation of the
kernel, is there a plan to "fix" it in the future?

Here are the details on my particular situation:

I'm working on a game server which interacts with a large number of clients
via a single UDP socket.  Occasionally, one of the clients will die without
sending a disconnect message.  When this happens, I'd like to remove the
client as quickly as possible to avoid leaving a ghost in the world that
other players will see.  In the worst case scenario, the session will time
out after the server hasn't heard from the client in x seconds.  However, if
I watch for ICMP port unreachable messages, I should frequently be able to
react more quickly.

With Winsock, this is easy to do.  Recvfrom fails, an error code tells me
that an ICMP port unreachable was received, and the address parameter of
recvfrom is filled in with the dead client's IP and port.  On Linux (I'm
using 2.2.16, but 2.4.x code appears to be the same in this respect),
recvfrom fails and errno is set to ECONNREFUSED indicating an ICMP port
unreachable was received.  However, the address is not filled in.  I'm able
to retrieve the IP via recvmsg with the MSG_ERRQUEUE flag (and the
IP_RECVERR sockopt), but the port that it gives me is bogus.

I apologize if this seems too application specific for linux-kernel, but
this appears to be a limitation of the kernel, and I haven't been able to
find any info elsewhere.

Thanks,
Erik

Erik L. De Bonte
Lead Server Programmer
LithTech, Inc. - http://www.lithtech.com
