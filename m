Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S278584AbRJSSfE>; Fri, 19 Oct 2001 14:35:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S278585AbRJSSep>; Fri, 19 Oct 2001 14:34:45 -0400
Received: from pak200.pakuni.net ([207.91.34.200]:45296 "EHLO
	smp.paktronix.com") by vger.kernel.org with ESMTP
	id <S278584AbRJSSej>; Fri, 19 Oct 2001 14:34:39 -0400
Date: Fri, 19 Oct 2001 13:44:37 -0500 (CDT)
From: "Matthew G. Marsh" <mgm@paktronix.com>
X-X-Sender: <mgm@netmonster.pakint.net>
To: Christopher Friesen <cfriesen@nortelnetworks.com>
cc: <kuznet@ms2.inr.ac.ru>, <linux-kernel@vger.kernel.org>
Subject: Re: how to see manually specified proxy arp entries using "ip neigh"
In-Reply-To: <3BCF36BE.DE10E221@nortelnetworks.com>
Message-ID: <Pine.LNX.4.31.0110191340330.17932-100000@netmonster.pakint.net>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 18 Oct 2001, Christopher Friesen wrote:

> kuznet@ms2.inr.ac.ru wrote:
>
> > > I (and others) have asked this a couple times here and on the netdev list, and
> > > so far nobody has answered it (not even negatively).
> >
> > :-) And me answered to this hundred of times: "no way". :-)
>
> Whee, an answer!
>
> > Ability to add/delete them with "ip neigh" will be removed in the next
> > snapshot as well. The feature is obsolete.
>
> Oh?  Let me present a scenario in which I use it and then you can tell me how
> better to do it.
>
> I'm using the ethertap device (in 2.2, tun/tap in 2.4 should be similar) to pass
> stuff up to userspace. I have an ethernet link.  I want the kernel to proxy arp
> for the ip address assigned to the ethertap device with the mac address of the
> NIC, without enabling proxy arping for any other addresses.

Not needed. Any address assigned to an "internal" device (tun/tap, dummy,
etc) is pingable and arpable from any other address on the system
(assuming rp_filter is set correctly per interface). I use this "feature"
all the time and there was even a big argument over "loose vs. strict"
host replies back in the Spring of 2001 about this.

> Currently I have been doing this by manually setting proxy arping on the NIC for
> the IP address assigned to the ethertap device.  If this feature is going to be
> removed, then how should I be doing this?

If an IP address is routed to on the external network then it will be
available. It does _not_ matter what interface that address is assigned
to. EX:

ip addr add 10.1.1.1/24 dev dummy0
ip link set dev dummy0 up

now ping 10.1.1.1 from another machine on eth0 that has an appropriate
route. I suspect what is really biting you is that your rp_filters are way
too restrictive on your machine.

> Thanks,
>
> Chris
>
> --
> Chris Friesen                    | MailStop: 043/33/F10
> Nortel Networks                  | work: (613) 765-0557
> 3500 Carling Avenue              | fax:  (613) 765-2986
> Nepean, ON K2H 8E9 Canada        | email: cfriesen@nortelnetworks.com
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

