Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S132511AbREBJNR>; Wed, 2 May 2001 05:13:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S132503AbREBJNH>; Wed, 2 May 2001 05:13:07 -0400
Received: from e215012.upc-e.chello.nl ([213.93.215.12]:6408 "EHLO
	procyon.wilson.nl") by vger.kernel.org with ESMTP
	id <S132488AbREBJNE>; Wed, 2 May 2001 05:13:04 -0400
From: "Michel Wilson" <michel@procyon14.yi.org>
To: "Sim, CT \(Chee Tong\)" <CheeTong.Sim@sin.rabobank.com>
Cc: <linux-kernel@vger.kernel.org>
Subject: RE: Linux NAT questions
Date: Wed, 2 May 2001 11:12:57 +0200
Message-ID: <NEBBLEJBILPLHPBNEEHIMEGECEAA.michel@procyon14.yi.org>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
X-Priority: 3 (Normal)
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook IMO, Build 9.0.2416 (9.0.2910.0)
In-Reply-To: <1E8992B3CD28D4119D5B00508B08EC5627E8A1@sinxsn02.ap.rabobank.com>
X-MIMEOLE: Produced By Microsoft MimeOLE V5.50.4133.2400
Importance: Normal
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> what I am trying to do is this. I have a genuine network, say 1.1.1.x, and
> my Linux host is on it, as 1.1.1.252 (eth0). I also have a second
> network at
> the back of the Linux box, 192.168.200.x, and a web server on
> that network,
> 192.168.200.2. The Linux address is 192.168.200.1 on eth1.
>
> What I want to do is make the web server appear on the 1.1.1.x network as
> 1.1.1.160. I have done this before with Firewall-1 on NT, by
> putting an arp
> entry for 1.1.1.160 to point to the Linux machine eth0. The packets get
> redirected into the Linux machine, then translated, and then routed out of
> eth1.
>
> The benefit is that there is no routing change to the 1.1.1.x network, and
> the Linux box isn't even seen as a router.
>
> I would appreciate any help with this. Any command to do this?
>
> Chee Tong
This isn't really a kernel question. I think you'd better ask it on some
linux network list/newsgroup. But here's an answer anyway....

You could add 1.1.1.160 to eth0:
   ip addr add 1.1.1.160 dev eth0
and then use NAT to redirect these to the webserver:
   iptables -t nat -A PREROUTING -p tcp --dst 1.1.1.160 -i eth1 -j
DNAT --to-destination 192.168.200.2

This should work, AFAIK, but i didn't try it myself. You could also try to
use the arp command (see 'man arp'), but i don't know exactly how that
works.

Good luck!

Michel Wilson.

