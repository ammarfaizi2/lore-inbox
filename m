Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S131350AbRAQOxX>; Wed, 17 Jan 2001 09:53:23 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131781AbRAQOxN>; Wed, 17 Jan 2001 09:53:13 -0500
Received: from relay.dera.gov.uk ([192.5.29.49]:5448 "HELO relay.dera.gov.uk")
	by vger.kernel.org with SMTP id <S131350AbRAQOxE>;
	Wed, 17 Jan 2001 09:53:04 -0500
Message-ID: <XFMail.20010117145010.gale@syntax.dera.gov.uk>
X-Mailer: XFMail 1.4.4 on Linux
X-Priority: 3 (Normal)
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
In-Reply-To: <Pine.LNX.4.30.0101171530150.20661-100000@shodan.irccrew.org>
Date: Wed, 17 Jan 2001 14:50:10 -0000 (GMT)
From: Tony Gale <gale@syntax.dera.gov.uk>
To: Jussi Hamalainen <count@theblah.org>
Subject: RE: ipchains blocking port 65535
Cc: linux-kernel@vger.kernel.org
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


It looks like this is due to the odd way in which ipchains handles
fragments. Try:

echo 1 > /proc/sys/net/ipv4/ip_always_defrag

-tony


On 17-Jan-2001 Jussi Hamalainen wrote:
> There seems to be a bug in ipchains. Matching port 65535 seems to
> always fail. If I set the chain policy to REJECT or DENY and then
> add a rule that accepts TCP to/from ports 0:65535, packets going to
> port 65535 will still be caught by the kernel. Is there a fix for
> this? It's driving me nuts. The firewall box is a 486 with 3 NICs
> and
> is running kernel 2.2.18 vanilla.
> 
> Here is a piece of the kernel log:
> 
> Jan 17 15:13:03 galileo kernel: Packet log: forward REJECT eth0
> PROTO=6 213.173.130.69:65535 xxx.xxx.xxx.xxx:65535 L=44 S=0x00
> I=16815 F=0x00B6 T=56 (#25)
> Jan 17 15:15:03 galileo kernel: Packet log: forward REJECT eth0
> PROTO=6 213.173.130.69:65535 xxx.xxx.xxx.xxx:65535 L=44 S=0x00
> I=19969 F=0x00B6 T=56 (#25)
> Jan 17 15:17:03 galileo kernel: Packet log: forward REJECT eth0
> PROTO=6 213.173.130.69:65535 xxx.xxx.xxx.xxx:65535 L=44 S=0x00
> I=21869 F=0x00B6 T=56 (#25)
> 
> And here a piece of my forward chain:
> 
> ACCEPT     tcp  ------  anywhere              myhomenet/27
> any ->   1024:65535
> ACCEPT     udp  ------  anywhere              myhomenet/27
> any ->   1024:65535
> 
> -- 
> -=[ Count Zero / TBH - Jussi Hämäläinen - email count@theblah.org
> ]=-
> 
> -
> To unsubscribe from this list: send the line "unsubscribe
> linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> Please read the FAQ at http://www.tux.org/lkml/

---
E-Mail: Tony Gale <gale@syntax.dera.gov.uk>
Never trust anybody whose arm is bigger than your leg.

The views expressed above are entirely those of the writer
and do not represent the views, policy or understanding of
any other person or official body.
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
