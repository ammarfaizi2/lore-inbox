Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S270479AbTGNAcO (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 13 Jul 2003 20:32:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S270478AbTGNAcN
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 13 Jul 2003 20:32:13 -0400
Received: from h80ad2494.async.vt.edu ([128.173.36.148]:12439 "EHLO
	turing-police.cc.vt.edu") by vger.kernel.org with ESMTP
	id S270477AbTGNAcD (ORCPT <RFC822;linux-kernel@vger.kernel.org>);
	Sun, 13 Jul 2003 20:32:03 -0400
Message-Id: <200307140046.h6E0kcMQ021180@turing-police.cc.vt.edu>
X-Mailer: exmh version 2.6.3 04/04/2003 with nmh-1.0.4+dev
To: "David S. Miller" <davem@redhat.com>
Cc: linux-kernel@vger.kernel.org, linux-net@vger.kernel.org,
       netdev@oss.sgi.com
Subject: Re: TCP IP Offloading Interface 
In-Reply-To: Your message of "Sun, 13 Jul 2003 16:53:23 PDT."
             <20030713165323.3fc2601f.davem@redhat.com> 
From: Valdis.Kletnieks@vt.edu
References: <ODEIIOAOPGGCDIKEOPILCEMBCMAA.alan@storlinksemi.com> <20030713004818.4f1895be.davem@redhat.com> <52u19qwg53.fsf@topspin.com> <20030713160200.571716cf.davem@redhat.com> <20030713233503.GA31793@work.bitmover.com> <20030713164003.21839eb4.davem@redhat.com> <20030713235424.GB31793@work.bitmover.com>
            <20030713165323.3fc2601f.davem@redhat.com>
Mime-Version: 1.0
Content-Type: multipart/signed; boundary="==_Exmh_-797710378P";
	 micalg=pgp-sha1; protocol="application/pgp-signature"
Content-Transfer-Encoding: 7bit
Date: Sun, 13 Jul 2003 20:46:38 -0400
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

--==_Exmh_-797710378P
Content-Type: text/plain; charset=us-ascii

On Sun, 13 Jul 2003 16:53:23 PDT, "David S. Miller" said:

> I really don't see why receive is so much of a big deal
> compared to send, and we do a send side version of this
> stuff already with zero problems.

Well.... there's optimizations you can do on the send side..

> The NFS code is already basically ready to handle a fragmented packet
> (headers + pages), and could stick the page part into the page cache
> easily on receive.

For example, in this case, you know a priori what the IP header will look
like, so you can use tricks like scatter-gather to send the header from one
place and a page-aligned data buffer from another, or start the packet at
(page boundary - IP_hrd_len), or tricks of that sort.  In 20 years, I've seen
a lot of vendors do a lot of ugly things to speed up their IP stack, often
based on the fact that they knew a lot about the packet before they started
assembling it.

It's hard to do tricks like that when you don't know (for instance) how
many IP option fields the packet has until you've already started sucking
the packet off the wire - at which point either the NIC itself has to be clever
(Hmm, there's that IP offload again) or you have literally about 30 CPU cycles
to do interrrupt latency *and* decide what to do....

--==_Exmh_-797710378P
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.2 (GNU/Linux)
Comment: Exmh version 2.5 07/13/2001

iD8DBQE/Ef1ucC3lWbTT17ARArLqAJ9Nm0BoBW0sAS12YRjHQqnbS8taaACgisgU
ouu0kT76znvhJ7TPiI5Nm8I=
=J2r1
-----END PGP SIGNATURE-----

--==_Exmh_-797710378P--
