Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264667AbTF0SsA (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 27 Jun 2003 14:48:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264682AbTF0SsA
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 27 Jun 2003 14:48:00 -0400
Received: from cs180094.pp.htv.fi ([213.243.180.94]:6272 "EHLO hades.pp.htv.fi")
	by vger.kernel.org with ESMTP id S264667AbTF0Srx (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 27 Jun 2003 14:47:53 -0400
Subject: Re: TCP send behaviour leads to cable modem woes
From: Mika Liljeberg <mika.liljeberg@welho.com>
To: Svein Ove Aas <svein.ove@aas.no>
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <200306272020.57502.svein.ove@aas.no>
References: <200306272020.57502.svein.ove@aas.no>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Message-Id: <1056740526.645.2.camel@hades>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.0 
Date: 27 Jun 2003 22:02:06 +0300
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Try enabling tcp_frto on your Linux box to see if that helps the
uploads.

	MikaL

On Fri, 2003-06-27 at 21:20, Svein Ove Aas wrote:
> -----BEGIN PGP SIGNED MESSAGE-----
> Hash: SHA1
> 
> My internet connection is via a cable modem, and thereon from Telenor. (A 
> Norwegian ISP.)
> 
> In general, when I download something I can get up to 1400-1500 Kb/s, which is 
> pretty good for a 1024/256 account. (They don't appear to oversubscribe their 
> lines (yahoo!), but mine is also uncapped when there is spare capacity. Think 
> traffic-control.)
> 
> So far, so good.
> 
> My account includes 4 IP addresses, and when I actually have four computers 
> directly connected I can easily get 7-8Kb/s upload from each of them.
> Oddly, when one of them is acting as a firewall/bridge for the others or I'm 
> just uploading from one, I get 7-8Kb/s for *all* of them. (Or the one.)
> 
> This is, dare I say, *not* expected behaviour.
> I've been in contact with telenor about it, and have garnered the following 
> information.
> 
> (A)	Although the line appear to be straight Ethernet attached to a 
> packet-filtering switch (just ARP-filtering, actually), it's *actually* an 
> ATM-based line. This should come as no surprise.
> 
> (B)	Whatever they have allocating the ATM cells for transfer is doing it in 
> bursts of about 16KB. Or possibly 32KB. Well, the tech I talked to was pretty 
> sure it was a power of two, at least.
> 
> (C)	This means that while I get 8 bursts (or more) of 16KB per second on 
> download (empirically confirmed, but the cable modem will tend to space it 
> out when the line is at capacity), giving me a latency of 128-256 ms and so 
> on and so forth (which I have), I get only *two* bursts per second to upload 
> things. I think. You may want to apply a multiplier somewhere.
> 
> And, finally, (D):
> 
> This thoroughly screws up TCP/IP for uploading purposes. It *completely* 
> breaks Realtek cards, screws up uploading speeds in Linux and Windows XP (I 
> assume they think there is a lot of intermittent packet loss because of the 
> delay), and has no apparent effect on Windows 9x/2000.
> 
> The cable modem in question is manufactured by Coresma and is marked NeMo. 
> It's also supposed to have a pretty large send buffer, so if I could just 
> force Linux to send at some user-defined speed without being so paranoid 
> about overloading the line, I could get a lot more use out of it.
> 
> For the curious, if I do just that with UDP, I can indeed send at up to 30KB/s 
> without losing packets. They *do* come in bursts, though.
> 
> 
> Please, save me before I lose my mind!
> 
> - - Svein Ove Aas
> -----BEGIN PGP SIGNATURE-----
> Version: GnuPG v1.2.2 (GNU/Linux)
> 
> iD8DBQE+/IsG9OlFkai3rMARAmZ4AKCeGIXGhREfh0kcA4Dr8FJs9fNuFgCg1sTb
> 1bk3+ipUs9tS35oZidxcY4I=
> =Zz5P
> -----END PGP SIGNATURE-----
> 
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
