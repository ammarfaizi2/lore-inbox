Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S280241AbRJaPti>; Wed, 31 Oct 2001 10:49:38 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S280220AbRJaPt3>; Wed, 31 Oct 2001 10:49:29 -0500
Received: from aloha.egartech.com ([62.118.81.133]:32776 "HELO
	mx02.egartech.com") by vger.kernel.org with SMTP id <S280241AbRJaPtR>;
	Wed, 31 Oct 2001 10:49:17 -0500
Message-ID: <3BE01E27.CF9A33D0@egartech.com>
Date: Wed, 31 Oct 2001 18:52:07 +0300
From: Kirill Ratkin <kratkin@egartech.com>
X-Mailer: Mozilla 4.77 [en] (X11; U; Linux 2.4.13 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Andrey Savochkin <saw@saw.sw.com.sg>
CC: Thomas =?koi8-r?Q?Lang=E5s?= <tlan@stud.ntnu.no>,
        linux-kernel@vger.kernel.org, J Sloan <jjs@pobox.com>
Subject: Re: Intel EEPro 100 with kernel drivers
In-Reply-To: <20011029021339.B23985@stud.ntnu.no> <3BDCD06E.8AF8FF69@pobox.com> <20011031090125.B10751@stud.ntnu.no> <20011031182212.A21776@castle.nmd.msu.ru>
Content-Type: text/plain; charset=koi8-r
Content-Transfer-Encoding: 8bit
X-OriginalArrivalTime: 31 Oct 2001 15:49:43.0878 (UTC) FILETIME=[A8D1BE60:01C16223]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andrey Savochkin wrote:
> 
> Hi,
> 
> On Wed, Oct 31, 2001 at 09:01:25AM +0100, Thomas Langås wrote:
> >
> > I've now tried the Intel driver, no help, still get the NFS timeouts (the
> > intel driver doesn't output anything to dmesg, so it's no way of telling if
> > the same things occur as in the eepro100 stock-kernel driver).
> >
> > This is how I do the test:
> >
> > NFS share a filesystem
> > NFS mount it on another box (not running intel e100 nic)
> > Start bonnie++ on the box that has mounted the nfs share
> >
> > After 10-20mins, the first NFS timeout comes (which means the card is out of
> > resources, and "halts" for a bit). When the card becomes out of resources,
> > it seems like it uses a few minutes before it comes online again, no wonder
> > why, tho.
> >
> > Has anyone got any suggestions on how to start tracking down, and maybe
> > fixing this problem?  Or, is this a hardware error?  Or maybe a firmware
> 
> Well, with eepro100 the start may be the following:
> 1. When the card stalls, start ping from that host.
> This way you ensure that you have something in transmit ring.
> If it's transmitting that stalls, you'll get a message from netdev watchdog.
> 2. If ping works, then your problem appear to be pure NFS one, i.e. inability
> of NFS to recover from network operation disruption.
> 3. If ping is able to transmit, but not receive (you may check it by
> tcpdump), then we have a receiver problem.
> We'll think what to do then.
> 
> 4. In any case, running eepro100-diag from scyld.com at the moment of the
> stall may give some useful information.
> 5. In any case, searching eepro100 mailing list archive on scyld.com is a
> good idea, you may learn what other people observe/do.
> 
>         Andrey
> 
> > error?  Should I start contacting Dell and tell them that's there's a
> > possible error in their PowerEdge 2550-series?

Guys. This is Network section of my config:
#
# Networking options
#
CONFIG_PACKET=y
# CONFIG_PACKET_MMAP is not set
# CONFIG_NETLINK is not set
# CONFIG_NETFILTER is not set
# CONFIG_FILTER is not set
CONFIG_UNIX=y
CONFIG_INET=y
CONFIG_IP_MULTICAST=y
# CONFIG_IP_ADVANCED_ROUTER is not set
# CONFIG_IP_PNP is not set
# CONFIG_NET_IPIP is not set
# CONFIG_NET_IPGRE is not set
# CONFIG_IP_MROUTE is not set
# CONFIG_INET_ECN is not set
# CONFIG_SYN_COOKIES is not set
# CONFIG_IPV6 is not set
# CONFIG_KHTTPD is not set
# CONFIG_ATM is not set
# CONFIG_IPX is not set
# CONFIG_ATALK is not set
# CONFIG_DECNET is not set
# CONFIG_BRIDGE is not set
# CONFIG_X25 is not set
# CONFIG_LAPB is not set
# CONFIG_LLC is not set
# CONFIG_NET_DIVERT is not set
# CONFIG_ECONET is not set
# CONFIG_WAN_ROUTER is not set
# CONFIG_NET_FASTROUTE is not set
# CONFIG_NET_HW_FLOWCONTROL is not set
 
#
# QoS and/or fair queueing
#
# CONFIG_NET_SCHED is not set

I work on this config (2.4.13) now and my machine has eepro100.o loaded.
Now I test it. This problem is appear when some options of IP section is
enabled. Now I can't say which of them. (I think SYN or MROUTE but it's
my assumption). 


> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
