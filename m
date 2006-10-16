Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751306AbWJPBkL@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751306AbWJPBkL (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 15 Oct 2006 21:40:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751304AbWJPBkK
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 15 Oct 2006 21:40:10 -0400
Received: from pool-72-66-199-112.ronkva.east.verizon.net ([72.66.199.112]:11973
	"EHLO turing-police.cc.vt.edu") by vger.kernel.org with ESMTP
	id S1751298AbWJPBkJ (ORCPT <RFC822;linux-kernel@vger.kernel.org>);
	Sun, 15 Oct 2006 21:40:09 -0400
Message-Id: <200610160139.k9G1dds0012638@turing-police.cc.vt.edu>
X-Mailer: exmh version 2.7.2 01/07/2005 with nmh-1.2
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Cc: Jesse Huang <jesse@icplus.com.tw>, linux-kernel@vger.kernel.org,
       netdev@vger.kernel.org, akpm@osdl.org, jgarzik@pobox.com
Subject: Re: [PATCH 1/5] remove TxStartThresh and RxEarlyThresh
In-Reply-To: Your message of "Mon, 16 Oct 2006 07:26:37 +1000."
             <1160947597.22522.3.camel@localhost.localdomain>
From: Valdis.Kletnieks@vt.edu
References: <1160855725.2266.1.camel@localhost.localdomain>
            <1160947597.22522.3.camel@localhost.localdomain>
Mime-Version: 1.0
Content-Type: multipart/signed; boundary="==_Exmh_1160962778_4950P";
	 micalg=pgp-sha1; protocol="application/pgp-signature"
Content-Transfer-Encoding: 7bit
Date: Sun, 15 Oct 2006 21:39:38 -0400
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

--==_Exmh_1160962778_4950P
Content-Type: text/plain; charset=us-ascii

On Mon, 16 Oct 2006 07:26:37 +1000, Benjamin Herrenschmidt said:
> Somebody patented FIFO thresholds ? Gack ?

The US PTO is fundamentally busticated.

http://www.engadget.com/2006/10/14/cisco-patents-the-triple-play/

Cisco got a patent on the concept of delivering voice, internet, and
cable TV over one cable.  Now admittedly, when they applied for it in 2000,
it wasn't a buzzword yet - but I'm pretty sure that there was prior art.

Back to the case at hand...

In the case of the TxStartThresh and RxEarlyThresh, I don't think it's
FIFO thresholds per se that are a problem - the note specifically mentioned
cut-through, which is a specific technique of starting to deal with the
alread-arrived head end of the packet *before* the tail end has arrived
yet. e.g. if you read a packet that has 16 bytes of control info followed
by 64 bytes of data, you have finished parsing the first 16 and have set
stuff up by the time the 64 bytes starts arriving - even though you only
started *one* read of 80 bytes).

Of course, even *that* is an old technique - I remember discussion (and
possibly implementation) of being able to read the front of an Ethernet
packet, and do the routing table lookup fast enough so that you could start
transmitting the packet on the outbound interface before it had finished
arriving on the inbound.  Of course, this was back when Proteon and Bay
were start-ups, nobody did IP option fields or router ACLs or stuff like
that, and level-3 routers were not much smarter (and perhaps stupider) than
today's level-2 switches that filter/route based on MAC address...

Maybe the patent is on the fact that you can't do cut-through routing well
without enforcing certain relationships on the Rx and Tx FIFO thresholds...

--==_Exmh_1160962778_4950P
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.5 (GNU/Linux)
Comment: Exmh version 2.5 07/13/2001

iD8DBQFFMuLacC3lWbTT17ARAt/cAKDiQBdeCijkYUsjchqsyE9XM4og0QCeODTu
MyEdOzs93nRFWCm291gzNQo=
=yAFu
-----END PGP SIGNATURE-----

--==_Exmh_1160962778_4950P--
