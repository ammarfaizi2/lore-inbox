Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S130758AbRAGLyA>; Sun, 7 Jan 2001 06:54:00 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S130668AbRAGLxu>; Sun, 7 Jan 2001 06:53:50 -0500
Received: from limes.hometree.net ([194.231.17.49]:45844 "EHLO
	limes.hometree.net") by vger.kernel.org with ESMTP
	id <S130758AbRAGLxk>; Sun, 7 Jan 2001 06:53:40 -0500
To: linux-kernel@vger.kernel.org
Date: Sun, 7 Jan 2001 11:40:10 +0000 (UTC)
From: "Henning P. Schmiedehausen" <hps@tanstaafl.de>
Message-ID: <939kiq$11s$1@forge.intermeta.de>
Organization: INTERMETA - Gesellschaft fuer Mehrwertdienste mbH
In-Reply-To: <Pine.GSO.4.30.0101062253440.18916-100000@shell.cyberus.ca>, <200101070543.VAA24689@pizda.ninka.net>
Reply-To: hps@tanstaafl.de
Subject: [little bit OT] ip _IS_ _NOT_ ifconfig and route ! (was Re: [PATCH] hashed device lookup (Does NOT meet Linus' sumission policy!))
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

davem@redhat.com (David S. Miller) writes:

>   Date:   Sat, 6 Jan 2001 23:00:10 -0500 (EST)
>   From: jamal <hadi@cyberus.ca>

>   I think someone should just flush ifconfig down some toilet. a wrapper
>   around "ip" to to give the same look and feel as ifconfig would be a good
>   thing so that some stupid program that depends on ifconfig look and feel
>   would be a good start.

>I could not agree more.  This reminds me to do something I could not
>justify before, making netlink be enabled in the kernel and
>non-configurable.

The fact there there are no man pages, no backward compatibility and
no information for people coming from other unixes (and pretty much
everything else _has_ ifconfig and friends), that iproute does not
work with older kernels, that everyone that reads the docs and looks
for ifconfig and that booting another kernel completely breaks your ip
configuration (which is, in the times of co-located, headless servers
some 3,000 miles away somehow a concern to administrators and users)
should IMNSVHO count at least a little towards keeping the older
tools.

As long as "man ip" on my machines returns "ip(7) - ip - Linux IPv4
protocol implementation", using "ip" exclusively instead of ifconfig
and route is IMHO not an option for anyone else than bleeding edge
hackers and linux gurus.

ip is an ultra-powerful command for the linux ip routing
subsystem. But at least IMHO it introduces so many new and different
concepts that there should be an "ip_lite" config command that at
least related semantically to the ifconfig/route/arp combo, so that
you can tell newbies (and I consider in this case people with 10+
years of Solaris experience as "linux routing command newbies") that

ifconfig eth0 ----> ip link show eth0

and so on. Give a small command with a small man page for these
"normal" cases and give all-powerful "ip" for all the cool, advanced
stuff.

Maybe the major distribution vendors should pay a decent technical
writer to work with Alexey to whip up man pages for these tools. There
are none in the iproute-current package (I looked) which contains all
the informations in an unix-compatible format. 

And yes, I don't consider HTML, tex, texinfo or info or (horrors) PS
and PDF format "decent documentation", Unix-style wise. At least as
long as we don't have a man command that understands HTML like Solaris
man does.

yes, it _is_ cool to type "ip route show" and pretend to be on level
with Cisco. But where is the documentation to _parse_ the displayed
information aside from reading lots of mailing list articles and code?
And don't tell me it's in the docs in the package. There is a
reference with at best terse examples. 

To quote a randomly picked part (p.25):

--- cut ---
scope SCOPE_VAL

- scope of the destinations covered by the route prefix. SCOPE_VAL may
  be a number or a string from the file /etc/iproute2/rt_scopes. If
  this parameter is omitted, ip assumes scope global for all gatewayed
  unicast routes, scope link for direct unicast routes and broadcasts
  and scope host for local routes.

--- cut ---

% ip route show
192.168.2.4 dev eth0  scope link 
192.168.2.0/24 dev eth0  proto kernel  scope link  src 192.168.2.4 
127.0.0.0/8 dev lo  scope link 
default via 192.168.2.1 dev eth0 

fine. Why is the last route (which is IMHO a gatewayed unicast route)
not

0.0.0.0/0 vial 192.168.2.1 dev eth0 scope global

?

In fact it behaves like this:

% ip route show scope global
default via 192.168.2.1 dev eth0 

I didn't find any "the default route is displayed different and scope
global is normally omitted" in the documentation. And the list goes
on.

And, please, convert all this "link" "route" "show" with abreviations
and abiguities into either getopt "-l" "-r" "s" or long_getopts
"--link" "--route" "--show" command line options. Why? Easy: consider

link == "-t link"   and show == "-s"

then

"ip -t link -s"  yields the same result as "ip -s -t link"

but

% ip link show
1: lo: <LOOPBACK,UP> mtu 3924 qdisc noqueue 
    link/loopback 00:00:00:00:00:00 brd 00:00:00:00:00:00
2: eth0: <BROADCAST,MULTICAST,UP> mtu 1500 qdisc pfifo_fast qlen 100
    link/ether 00:50:04:48:b9:f0 brd ff:ff:ff:ff:ff:ff
% ip show link
Object "show" is unknown, try "ip help".

any further questions? If you write scripts where you push your
arguments on a stack and then do a " join arguments into line, execute
line", having position independend argument order is a clear win over
every syntactic sugar. But then again, it is a real world use.

	Regards
		Henning
-- 
Dipl.-Inf. (Univ.) Henning P. Schmiedehausen       -- Geschaeftsfuehrer
INTERMETA - Gesellschaft fuer Mehrwertdienste mbH     hps@intermeta.de

Am Schwabachgrund 22  Fon.: 09131 / 50654-0   info@intermeta.de
D-91054 Buckenhof     Fax.: 09131 / 50654-20   
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
