Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264678AbTF0SIY (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 27 Jun 2003 14:08:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264682AbTF0SIY
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 27 Jun 2003 14:08:24 -0400
Received: from mail59-s.fg.online.no ([148.122.161.59]:27105 "EHLO
	mail59.fg.online.no") by vger.kernel.org with ESMTP id S264678AbTF0SIW convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 27 Jun 2003 14:08:22 -0400
From: Svein Ove Aas <svein.ove@aas.no>
To: linux-kernel@vger.kernel.org
Subject: TCP send behaviour leads to cable modem woes
Date: Fri, 27 Jun 2003 20:20:54 +0200
User-Agent: KMail/1.5.2
MIME-Version: 1.0
Content-Description: clearsigned data
Content-Disposition: inline
Content-Type: Text/Plain;
  charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Message-Id: <200306272020.57502.svein.ove@aas.no>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

My internet connection is via a cable modem, and thereon from Telenor. (A 
Norwegian ISP.)

In general, when I download something I can get up to 1400-1500 Kb/s, which is 
pretty good for a 1024/256 account. (They don't appear to oversubscribe their 
lines (yahoo!), but mine is also uncapped when there is spare capacity. Think 
traffic-control.)

So far, so good.

My account includes 4 IP addresses, and when I actually have four computers 
directly connected I can easily get 7-8Kb/s upload from each of them.
Oddly, when one of them is acting as a firewall/bridge for the others or I'm 
just uploading from one, I get 7-8Kb/s for *all* of them. (Or the one.)

This is, dare I say, *not* expected behaviour.
I've been in contact with telenor about it, and have garnered the following 
information.

(A)	Although the line appear to be straight Ethernet attached to a 
packet-filtering switch (just ARP-filtering, actually), it's *actually* an 
ATM-based line. This should come as no surprise.

(B)	Whatever they have allocating the ATM cells for transfer is doing it in 
bursts of about 16KB. Or possibly 32KB. Well, the tech I talked to was pretty 
sure it was a power of two, at least.

(C)	This means that while I get 8 bursts (or more) of 16KB per second on 
download (empirically confirmed, but the cable modem will tend to space it 
out when the line is at capacity), giving me a latency of 128-256 ms and so 
on and so forth (which I have), I get only *two* bursts per second to upload 
things. I think. You may want to apply a multiplier somewhere.

And, finally, (D):

This thoroughly screws up TCP/IP for uploading purposes. It *completely* 
breaks Realtek cards, screws up uploading speeds in Linux and Windows XP (I 
assume they think there is a lot of intermittent packet loss because of the 
delay), and has no apparent effect on Windows 9x/2000.

The cable modem in question is manufactured by Coresma and is marked NeMo. 
It's also supposed to have a pretty large send buffer, so if I could just 
force Linux to send at some user-defined speed without being so paranoid 
about overloading the line, I could get a lot more use out of it.

For the curious, if I do just that with UDP, I can indeed send at up to 30KB/s 
without losing packets. They *do* come in bursts, though.


Please, save me before I lose my mind!

- - Svein Ove Aas
-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.2 (GNU/Linux)

iD8DBQE+/IsG9OlFkai3rMARAmZ4AKCeGIXGhREfh0kcA4Dr8FJs9fNuFgCg1sTb
1bk3+ipUs9tS35oZidxcY4I=
=Zz5P
-----END PGP SIGNATURE-----

