Return-Path: <linux-kernel-owner+w=401wt.eu-S1751093AbXAURIk@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751093AbXAURIk (ORCPT <rfc822;w@1wt.eu>);
	Sun, 21 Jan 2007 12:08:40 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751127AbXAURIk
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 21 Jan 2007 12:08:40 -0500
Received: from lucidpixels.com ([66.45.37.187]:43051 "EHLO lucidpixels.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751093AbXAURIj (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 21 Jan 2007 12:08:39 -0500
Date: Sun, 21 Jan 2007 12:08:38 -0500 (EST)
From: Justin Piszcz <jpiszcz@lucidpixels.com>
X-X-Sender: jpiszcz@p34.internal.lan
To: thunder7@xs4all.nl
cc: Avuton Olrich <avuton@gmail.com>, linux-kernel@vger.kernel.org,
       linux-raid@vger.kernel.org
Subject: Re: 2.6.19.2, cp 18gb_file 18gb_file.2 = OOM killer, 100% reproducible
In-Reply-To: <20070121170249.GA19956@amd64.of.nowhere>
Message-ID: <Pine.LNX.4.64.0701211208310.15334@p34.internal.lan>
References: <Pine.LNX.4.64.0701201516450.3684@p34.internal.lan>
 <3aa654a40701201245s72b2f76hc70ddd94b70ba99c@mail.gmail.com>
 <Pine.LNX.4.64.0701201602570.4910@p34.internal.lan> <20070121155219.GA7413@amd64.of.nowhere>
 <Pine.LNX.4.64.0701211146530.15334@p34.internal.lan> <20070121170249.GA19956@amd64.of.nowhere>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Sun, 21 Jan 2007, thunder7@xs4all.nl wrote:

> From: Justin Piszcz <jpiszcz@lucidpixels.com>
> Date: Sun, Jan 21, 2007 at 11:48:07AM -0500
> > 
> > What about all of the changes with NAT?  I see that it operates on 
> > level-3/network wise, I enabled that and backward compatiblity support as 
> > well, but when my iptables rules kick in, it says no such driver/etc for 
> > `nat'-- is there a new target for iptables now or did I miss a kernel 
> > option?
> > 
> 
> Well, I'm typing this on my laptop, connected via my main server to the
> internet, using SNAT, according to the firehol manpage. The main server
> runs 2.6.20-rc5, and somewhere in my 2.6.20-rc5 .config, there is
> 
> CONFIG_NF_NAT=m
> CONFIG_NF_NAT_NEEDED=y
> CONFIG_IP_NF_TARGET_MASQUERADE=m
> CONFIG_IP_NF_TARGET_REDIRECT=m
> CONFIG_IP_NF_TARGET_NETMAP=m
> CONFIG_IP_NF_TARGET_SAME=m
> CONFIG_NF_NAT_SNMP_BASIC=m
> CONFIG_NF_NAT_PROTO_GRE=m
> CONFIG_NF_NAT_FTP=m
> CONFIG_NF_NAT_IRC=m
> CONFIG_NF_NAT_TFTP=m
> CONFIG_NF_NAT_AMANDA=m
> CONFIG_NF_NAT_PPTP=m
> CONFIG_NF_NAT_H323=m
> CONFIG_NF_NAT_SIP=m
> 
> and my firewall's manpage says:
> 
> FIREHOL.CONF(5)       User Contributed Perl Documentation      FIREHOL.CONF(5)
> 
> 
>        masquerade [reverse | interface] [optional rule parameters]
> 
>          Masquerading is a special from of SNAT (Source NAT) that changes the
>          source of requests when they go out and replaces their original
>          source when replies come in. This way a Linux box can become an
>          internet router for a LAN of clients having unroutable IP addresses.
>          Masquerading takes care to re-map IP addresses and ports as required.
> 
>          Masquerading is "expensive" compared to SNAT because it checks the IP
>          address of the ougoing interface every time for every packet, and
>          therefore it is suggested that if you connect to the internet with a
>          static IP address, to prefer SNAT.
> 
> while my /etc/firehol/firehol.conf has a part in it like this:
> 
> #
> # route access from the clients to the internet
> #
> router internet2network inface adsl outface switch
> 	masquerade reverse
> 	client all accept
> 
> All in all, NAT is working for me with 2.6.20-rc5. I do remember I had
> to reselect all the netfilter modules in menuconfig.
> 
> Good luck,
> Jurriaan
> -- 
> > What does ELF stand for (in respect to Linux?)
> ELF is the first rock group that Ronnie James Dio performed with back in 
> the early 1970's.  In constrast, a.out is a misspelling	 of the French word 
> for the month of August.  What the two have in common is beyond me, but 
> Linux users seem to use the two words together.
> 	seen on c.o.l.misc
> Debian (Unstable) GNU/Linux 2.6.20-rc5 2x2011 bogomips load 0.83
> the Jack Vance Integral Edition: http://www.integralarchive.org
> -
> To unsubscribe from this list: send the line "unsubscribe linux-raid" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> 

Thanks, I'll give it another go in a bit!

Justin.
