Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S271095AbRIFOxo>; Thu, 6 Sep 2001 10:53:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S271105AbRIFOxe>; Thu, 6 Sep 2001 10:53:34 -0400
Received: from pak200.pakuni.net ([207.91.34.200]:46842 "EHLO
	smp.paktronix.com") by vger.kernel.org with ESMTP
	id <S271095AbRIFOxP>; Thu, 6 Sep 2001 10:53:15 -0400
Date: Thu, 6 Sep 2001 10:01:40 -0500 (CDT)
From: "Matthew G. Marsh" <mgm@paktronix.com>
X-X-Sender: <mgm@netmonster.pakint.net>
To: <valentyn@nospam.openoffice.nl>
cc: <linux-kernel@vger.kernel.org>
Subject: Re: iproute2, portfw oddities (2.2.19 ppp)
In-Reply-To: <3B8FB778.E055FBD7@openoffice.nl>
Message-ID: <Pine.LNX.4.31.0109060959420.14473-100000@netmonster.pakint.net>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 31 Aug 2001, Valentijn Sessink wrote:

> Hello list,
>
> I have a machine (Pentium, 2.2.19, Debian 2.2) with an internal network
> (192.168.0.x) and 4 external ppp connections (actually: pptp connections
> to the ISP).
>
> The ppp's all could have a "default route" to the Internet, only the ISP
> filters source addresses, so you cannot possibly send a ppp0 IP-address
> through ppp1 or vice versa.
>
> Now policy routing seemed the correct solution for this and I tried this
> for ppp1:
>
> # ip ru list
> 0:      from all lookup local
> 1001:   from 194.10.21.181 lookup ppp1
> 32766:  from all lookup main
> 32767:  from all lookup default
> # ip route list table ppp1
> default dev ppp1  scope link
>
> This works, as I can ping the ppp1 address from the outside. (which
> could not be done before).
>
> Unfortunately, when I try to put a portfw rule on top of this, things go
> wrong:
>
> # ipmasqadm portfw -a -P tcp -L 194.10.21.181 80 -R 192.168.0.133 80
>
> Strangely, this results in packets from 192.168.0.133 being renamed
> 194.10.21.181 *but being directed via ppp0*: tcpdump ppp0 sees packets
> coming from IP address 194.10.21.181.
>
> Unfortunately, the ISP does not like this and drops those. However,
> after issueing
>
> ip rule add from 192.168.0.133 table ppp1

Yes.

> ... the thing works.
>
> This seems a bit odd. Could anyone comment on this? Please cc: my
> E-mail-address, as I'm not subscribed to linux-kernel (and yes, the
> "nospam" stuff works, I read it, it just seems to scare spambots :)

Nothing odd about it. When a packet comes in the box the RPDB (rules,
routes, addresses) is consulted _before_ the ipchains MASQ. So your packet
was sent out ppp0 which I suspect is the default route for the box in
table main.

> Best regards,
>
> Valentijn
> --
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
>

--------------------------------------------------
Matthew G. Marsh,  President
Paktronix Systems LLC
1506 North 59th Street
Omaha  NE  68104
Phone: (402) 932-7250 x101
Email: mgm@paktronix.com
WWW:  http://www.paktronix.com
--------------------------------------------------

