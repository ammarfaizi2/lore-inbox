Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S268017AbRHaQMu>; Fri, 31 Aug 2001 12:12:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267997AbRHaQMl>; Fri, 31 Aug 2001 12:12:41 -0400
Received: from node14760.a2000.nl ([24.132.71.96]:17404 "HELO
	sahara.openoffice.nl") by vger.kernel.org with SMTP
	id <S268017AbRHaQM3>; Fri, 31 Aug 2001 12:12:29 -0400
Message-ID: <3B8FB778.E055FBD7@openoffice.nl>
Date: Fri, 31 Aug 2001 18:12:40 +0200
From: Valentijn Sessink <valentyn+sessink@openoffice.nl>
Reply-To: valentyn@nospam.openoffice.nl
Organization: Open Office - Linux for the Desktop
X-Mailer: Mozilla 4.77 [en] (X11; U; Linux 2.2.19-cadmium i686)
X-Accept-Language: nl, en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: iproute2, portfw oddities (2.2.19 ppp)
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello list,

I have a machine (Pentium, 2.2.19, Debian 2.2) with an internal network
(192.168.0.x) and 4 external ppp connections (actually: pptp connections
to the ISP).

The ppp's all could have a "default route" to the Internet, only the ISP
filters source addresses, so you cannot possibly send a ppp0 IP-address
through ppp1 or vice versa.

Now policy routing seemed the correct solution for this and I tried this
for ppp1:

# ip ru list
0:      from all lookup local 
1001:   from 194.10.21.181 lookup ppp1 
32766:  from all lookup main 
32767:  from all lookup default 
# ip route list table ppp1
default dev ppp1  scope link 

This works, as I can ping the ppp1 address from the outside. (which
could not be done before).

Unfortunately, when I try to put a portfw rule on top of this, things go
wrong:

# ipmasqadm portfw -a -P tcp -L 194.10.21.181 80 -R 192.168.0.133 80

Strangely, this results in packets from 192.168.0.133 being renamed
194.10.21.181 *but being directed via ppp0*: tcpdump ppp0 sees packets
coming from IP address 194.10.21.181.

Unfortunately, the ISP does not like this and drops those. However,
after issueing

ip rule add from 192.168.0.133 table ppp1

... the thing works.

This seems a bit odd. Could anyone comment on this? Please cc: my
E-mail-address, as I'm not subscribed to linux-kernel (and yes, the
"nospam" stuff works, I read it, it just seems to scare spambots :)

Best regards,

Valentijn
--
