Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S316723AbSEVUHo>; Wed, 22 May 2002 16:07:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S316724AbSEVUHn>; Wed, 22 May 2002 16:07:43 -0400
Received: from nat9.steeleye.com ([65.114.3.137]:31236 "EHLO
	fenric.sc.steeleye.com") by vger.kernel.org with ESMTP
	id <S316723AbSEVUHl>; Wed, 22 May 2002 16:07:41 -0400
Date: Wed, 22 May 2002 16:06:59 -0400 (EDT)
From: Paul Clements <kernel@steeleye.com>
Reply-To: Paul.Clements@steeleye.com
To: Kirk <kirk@scriptdoggie.com>
cc: linux-kernel@vger.kernel.org
Subject: Re: ipfwadm problems
In-Reply-To: <017201c201ca$13054810$320e10ac@irvine.hnc.com>
Message-ID: <Pine.LNX.4.10.10205221601440.31335-100000@clements.sc.steeleye.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

There should still be ipchains support in 2.4.18, maybe not by default, but
I've got it in my 2.4.18 kernel. You may need to "insmod ipchains", which may
also require "rmmod iptables" first, depending upon how the kernel is being
setup at boot time. At any rate, iptables certainly has all the capabilities
of ipchains plus a lot more (that's why it's so complicated, and why I don't
use it... :). I don't know if "ipfwadm" will still work (that's old 2.0 kernel
stuff), but the ipchains command definitely works on 2.4.18:

titan:/usr/src/linux-2.4.18.PRISTINE# ls -l net/ipv4/netfilter/ipchains_core.c 
-rw-r--r--    1 root     root        50368 Apr 29 10:44 net/ipv4/netfilter/ipchains_core.c

titan:/usr/src/linux-2.4.18.PRISTINE# ipchains -L -n
Chain input (policy ACCEPT):
target     prot opt     source                destination           ports
ACCEPT     udp  ------  172.17.4.1           0.0.0.0/0             53 ->   1025:65535
ACCEPT     udp  ------  172.17.4.7           0.0.0.0/0             53 ->   1025:65535
icmp       icmp ------  0.0.0.0/0            0.0.0.0/0             * ->   *
Chain forward (policy ACCEPT):
Chain output (policy ACCEPT):
Chain icmp (1 references):
target     prot opt     source                destination           ports
ACCEPT     all  ------  0.0.0.0/0            0.0.0.0/0             n/a

titan:/usr/src/linux-2.4.18.PRISTINE# uname -r
2.4.18


Hope that helps.

-- 
Paul Clements
SteelEye Technology
Paul.Clements@SteelEye.com



On Wed, 22 May 2002, Kirk wrote:

> Does iptables have or allow IP Masqurading?  This is really what I'm trying
> to do as I have a network behind my linux server (acting as a router) and
> need to forward packets from 192.168.0.x to my WAN port on the same Linux
> server.  I had this working with ipchains until the upgrade to 2.4.18.
> 
> Thanks,
> Kirk
> 
> 
> ----- Original Message -----
> From: "Ambrish Verma" <averma@marantinetworks.com>
> To: <kirk@scriptdoggie.com>
> Sent: Wednesday, May 22, 2002 12:15 PM
> Subject: Re: ipfwadm problems
> 
> 
> In the new kernels ipchains is not included by default (probably if you put
> some effort you can include it.).
> There is an alternate for ipchains is available called iptables, with which
> you should be able to do most of the things you expect from ipchains.
> 
> --
> Ambrish
> 
> 
> "Kirk" <kirk@scriptdoggie.com> wrote in message
> news:011101c201bd$91ccccc0$320e10ac@irvine.hnc.com...
> > I'm trying to issue an "ipfwadm" to create ipchains and am getting:
> >
> > > Generic IP Firewall Chains not in this kernel
> >
> > Looking for help with re-compiling the 2.4.18-2 (latest from CD's 7.3
> > install).  Can someone point me in the right direction?
> >
> > Thanks
> >
> >
> > -
> > To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> > the body of a message to majordomo@vger.kernel.org
> > More majordomo info at  http://vger.kernel.org/majordomo-info.html
> > Please read the FAQ at  http://www.tux.org/lkml/
> 
> 
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
> 

