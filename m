Return-Path: <linux-kernel-owner+willy=40w.ods.org-S265135AbUGGOTh@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265135AbUGGOTh (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 7 Jul 2004 10:19:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265146AbUGGOTh
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 7 Jul 2004 10:19:37 -0400
Received: from ns0.eris.qinetiq.com ([128.98.1.1]:43 "HELO
	mail.eris.qinetiq.com") by vger.kernel.org with SMTP
	id S265135AbUGGOTf convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 7 Jul 2004 10:19:35 -0400
From: Mark Watts <m.watts@eris.qinetiq.com>
Organization: QinetiQ
To: linux-kernel@vger.kernel.org
Subject: Re: stupied userspace programs or kernel bug ?
Date: Wed, 7 Jul 2004 15:15:10 +0100
User-Agent: KMail/1.6.1
Cc: Adam Popik <popik@moon.tuniv.szczecin.pl>
References: <Pine.LNX.4.44.0407071421180.23555-100000@moon.tuniv.szczecin.pl>
In-Reply-To: <Pine.LNX.4.44.0407071421180.23555-100000@moon.tuniv.szczecin.pl>
MIME-Version: 1.0
Content-Disposition: inline
Content-Type: Text/Plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Message-Id: <200407071515.10625.m.watts@eris.qinetiq.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1


> Hello ;
> That is a problem:
> linux#ifconfig eth0 192.168.1.1

Because you didn't specify a netmask, it defaulted to 255.255.255.0

> linux#ifconfig lo:1 192.168.1.100 netmask 255.255.255.255 up

Although you specified a tighter netmask here, the routing table is such that 
192.168.1.0/24 is routed out eth0, overriding the fact that 1.100 is on lo:1

I'll bet the kernel responds to the ICMP echo request because it knows it 
holds the IP for 1.100 so it should respond, yet its outbound routing tells 
it to respond via eth0. (somone connect me if I'm wrong)

This is probably a side effect of having two interfaces on the same subnet, 
and having the /24 subnet higher up the routing rable than the /32 host.

I believe the behaviour you are seeing is 'by design' although the merits of 
this have been discussed to death in the past (IIRC)

Mark.

- -- 
Mark Watts
Senior Systems Engineer
QinetiQ Trusted Information Management
Trusted Solutions and Services group
GPG Public Key ID: 455420ED

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.4 (GNU/Linux)

iD8DBQFA7AVuBn4EFUVUIO0RAlXpAJ9I1FBUhqDDgV3Tvs53NjSM9BQq9QCeIVeu
f4Jzs0L/LlvjOsm8CcMNoJs=
=/jLZ
-----END PGP SIGNATURE-----
