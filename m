Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S132850AbREBMXm>; Wed, 2 May 2001 08:23:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S132883AbREBMXc>; Wed, 2 May 2001 08:23:32 -0400
Received: from cr803443-a.flfrd1.on.wave.home.com ([24.156.64.178]:22161 "EHLO
	fxian.jukie.net") by vger.kernel.org with ESMTP id <S132850AbREBMXR>;
	Wed, 2 May 2001 08:23:17 -0400
Date: Wed, 2 May 2001 08:22:54 -0400 (EDT)
From: Feng Xian <fxian@fxian.jukie.net>
X-X-Sender: <fxian@tiger>
To: "Sim, CT (Chee Tong)" <CheeTong.Sim@sin.rabobank.com>
cc: "'Michel Wilson'" <michel@procyon14.yi.org>,
        <linux-kernel@vger.kernel.org>
Subject: RE: Linux NAT questions- (kernel upgrade??)
In-Reply-To: <1E8992B3CD28D4119D5B00508B08EC5627E8A4@sinxsn02.ap.rabobank.com>
Message-ID: <Pine.LNX.4.33.0105020821480.1388-100000@tiger>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

i think iptables is a new feature in kernel 2.4.x(and you have to build
it in the kernel or as module). you can use ipchains if
you are running kernel with lower version, 2.2.something.

Alex

On Wed, 2 May 2001, Sim, CT (Chee Tong) wrote:

> Hi.. I follow your instruction, but I encounter this issue, my kernel need
> to be upgrade? MAy I know how to determine the current kernel version and
> how to upgrade it??
>
>
> [root@guava /root]# iptables -t nat -A PREROUTING -p tcp --dst 1.1.1.160 -i
> eth1 -j D
> NAT --to-destination 192.168.200.2
> iptables v1.1.1: can't initialize iptables table `nat': iptables who? (do
> you need to insm
> od?)
> Perhaps iptables or your kernel needs to be upgraded.
>
>
> [root@guava simc]# rpm -ivh iptables-1_2_0-6_i386.rpm
> error: failed dependencies:
>         kernel >= 2.4.0 is needed by iptables-1.2.0-6
>
>
> -----Original Message-----
> From: Michel Wilson [mailto:michel@procyon14.yi.org]
> Sent: Wednesday, May 02, 2001 5:13 PM
> To: Sim, CT (Chee Tong)
> Cc: linux-kernel@vger.kernel.org
> Subject: RE: Linux NAT questions
>
>
> > what I am trying to do is this. I have a genuine network, say 1.1.1.x, and
> > my Linux host is on it, as 1.1.1.252 (eth0). I also have a second
> > network at
> > the back of the Linux box, 192.168.200.x, and a web server on
> > that network,
> > 192.168.200.2. The Linux address is 192.168.200.1 on eth1.
> >
> > What I want to do is make the web server appear on the 1.1.1.x network as
> > 1.1.1.160. I have done this before with Firewall-1 on NT, by
> > putting an arp
> > entry for 1.1.1.160 to point to the Linux machine eth0. The packets get
> > redirected into the Linux machine, then translated, and then routed out of
> > eth1.
> >
> > The benefit is that there is no routing change to the 1.1.1.x network, and
> > the Linux box isn't even seen as a router.
> >
> > I would appreciate any help with this. Any command to do this?
> >
> > Chee Tong
> This isn't really a kernel question. I think you'd better ask it on some
> linux network list/newsgroup. But here's an answer anyway....
>
> You could add 1.1.1.160 to eth0:
>    ip addr add 1.1.1.160 dev eth0
> and then use NAT to redirect these to the webserver:
>    iptables -t nat -A PREROUTING -p tcp --dst 1.1.1.160 -i eth1 -j
> DNAT --to-destination 192.168.200.2
>
> This should work, AFAIK, but i didn't try it myself. You could also try to
> use the arp command (see 'man arp'), but i don't know exactly how that
> works.
>
> Good luck!
>
> Michel Wilson.
>
>
> ==================================================================
> De informatie opgenomen in dit bericht kan vertrouwelijk zijn en
> is uitsluitend bestemd voor de geadresseerde. Indien u dit bericht
> onterecht ontvangt wordt u verzocht de inhoud niet te gebruiken en
> de afzender direct te informeren door het bericht te retourneren.
> ==================================================================
> The information contained in this message may be confidential
> and is intended to be exclusively for the addressee. Should you
> receive this message unintentionally, please do not use the contents
> herein and notify the sender immediately by return e-mail.
>
>
> ==================================================================
>
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
>

-- 
        Feng Xian
   _o)     .~.      (o_
   /\\     /V\      //\
  _\_V    // \\     V_/_
         /(   )\
          ^^-^^
           ALEX

