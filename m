Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S293007AbSB0XBU>; Wed, 27 Feb 2002 18:01:20 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S293028AbSB0XBI>; Wed, 27 Feb 2002 18:01:08 -0500
Received: from outpost.ds9a.nl ([213.244.168.210]:11182 "HELO
	outpost.powerdns.com") by vger.kernel.org with SMTP
	id <S293024AbSB0XAx>; Wed, 27 Feb 2002 18:00:53 -0500
Date: Thu, 28 Feb 2002 00:00:46 +0100
From: bert hubert <ahu@ds9a.nl>
To: Bjorn Wesen <bjorn.wesen@axis.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: What is TCPRenoRecoveryFail ?
Message-ID: <20020228000046.A26358@outpost.ds9a.nl>
Mail-Followup-To: bert hubert <ahu@ds9a.nl>,
	Bjorn Wesen <bjorn.wesen@axis.com>, linux-kernel@vger.kernel.org
In-Reply-To: <20020227152705.A18366@outpost.ds9a.nl> <Pine.LNX.3.96.1020227153315.18713F-101000@fafner.axis.se>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <Pine.LNX.3.96.1020227153315.18713F-101000@fafner.axis.se>; from bjorn.wesen@axis.com on Wed, Feb 27, 2002 at 06:33:43PM +0000
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Feb 27, 2002 at 06:33:43PM +0000, Bjorn Wesen wrote:

> > Please show a tcpdump -v of this happening, including the initial SYN
> > packets. I strongly suspect something in your network of mucking with TCP
> > options.
> 
> Ok this is mangled by the email client but i attached the binary dump of
> the relevant packets. The dump is taken on the windows machine, which
> complicates the analysis because perhaps the network card itself is
> screwing up, but that is a low probability because all succeeding

This dump is somewhat inconclusive. I miss the SYN packets, but I'm
especially interested in this bit:

> 23:46:43.011000 10.13.18.46.http > dh10-13-18-213.axis.se.squid: . [tcp
> sum ok] 7300:8760(1460) ack 1 win 5840 (DF) (ttl 64, id 37963, len 1500)
> 23:46:43.011000 dh10-13-18-213.axis.se.squid > 10.13.18.46.http: . [tcp
> sum ok] ack 4380 win 8760 (DF) (ttl 128, id 55373, len 40)
> 23:46:43.011000 10.13.18.46.http > dh10-13-18-213.axis.se.squid: . [tcp
> sum ok] 8760:10220(1460) ack 1 win 5840 (DF) (ttl 64, id 37964, len 1500)
> 23:46:43.011000 dh10-13-18-213.axis.se.squid > 10.13.18.46.http: . [tcp
> sum ok] ack 4380 win 8760 (DF) (ttl 128, id 55629, len 40)
> 23:46:43.012000 10.13.18.46.http > dh10-13-18-213.axis.se.squid: P [tcp
> sum ok] 10220:11680(1460) ack 1 win 5840 (DF) (ttl 64, id 37965, len 1500)
> 23:46:43.012000 dh10-13-18-213.axis.se.squid > 10.13.18.46.http: . [tcp
> sum ok] ack 4380 win 8760 (DF) (ttl 128, id 55885, len 40)
> 
> .. long timeout here until the server finally gives up the connection ..

how does this continue? I see the linux machine continuing to send data with
higher sequence numbers, but how does it end? It looks like the linux
machine never sent anything beyond 11680, relative.

To know more, dump at both ends. I really think something in between is
messing up - either a network adaptor or a ""smart"" network element.

Regards,

bert

-- 
http://www.PowerDNS.com          Versatile DNS Software & Services
http://www.tk                              the dot in .tk
http://lartc.org           Linux Advanced Routing & Traffic Control HOWTO
