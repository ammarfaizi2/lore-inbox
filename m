Return-Path: <linux-kernel-owner+willy=40w.ods.org-S265211AbUGGPhc@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265211AbUGGPhc (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 7 Jul 2004 11:37:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265212AbUGGPhc
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 7 Jul 2004 11:37:32 -0400
Received: from moon.tuniv.szczecin.pl ([212.14.18.12]:55817 "EHLO
	moon.tuniv.szczecin.pl") by vger.kernel.org with ESMTP
	id S265211AbUGGPh3 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 7 Jul 2004 11:37:29 -0400
Date: Wed, 7 Jul 2004 16:54:01 +0200 (CEST)
From: Adam Popik <popik@moon.tuniv.szczecin.pl>
To: Mark Watts <m.watts@eris.qinetiq.com>
cc: linux-kernel@vger.kernel.org
Subject: Re: stupied userspace programs or kernel bug ?
In-Reply-To: <200407071515.10625.m.watts@eris.qinetiq.com>
Message-ID: <Pine.LNX.4.44.0407071641430.24331-100000@moon.tuniv.szczecin.pl>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 7 Jul 2004, Mark Watts wrote:
That test was with 2 host network and no more hosts, routers and others...
linux#  shold have this address for virtual use only on that 
machine (loopback interface), 
netmask on all linuxboxes are same, onlny on lo was /32. When I use /24 
mask and router (routing was good until assinging ip address to loopback)
network traffic is broken about 40 icmp requests (outside local net)...
Is linux bugs ?
on same test on FreeBSD and Solaris 9 no problems (loopback is and only 
loopback)

Adam

> -----BEGIN PGP SIGNED MESSAGE-----
> Hash: SHA1
> 
> 
> > Hello ;
> > That is a problem:
> > linux#ifconfig eth0 192.168.1.1
> 
> Because you didn't specify a netmask, it defaulted to 255.255.255.0
Yes it C ...
> 
> > linux#ifconfig lo:1 192.168.1.100 netmask 255.255.255.255 up
> 
> Although you specified a tighter netmask here, the routing table is such that 
> 192.168.1.0/24 is routed out eth0, overriding the fact that 1.100 is on lo:1
> 
> I'll bet the kernel responds to the ICMP echo request because it knows it 
> holds the IP for 1.100 so it should respond, yet its outbound routing tells 
> it to respond via eth0. (somone connect me if I'm wrong)
> 
> This is probably a side effect of having two interfaces on the same subnet, 
> and having the /24 subnet higher up the routing rable than the /32 host.
> 
> I believe the behaviour you are seeing is 'by design' although the merits of 
> this have been discussed to death in the past (IIRC)
> 
> Mark.
> 
> - -- 
> Mark Watts
> Senior Systems Engineer
> QinetiQ Trusted Information Management
> Trusted Solutions and Services group
> GPG Public Key ID: 455420ED
> 
> -----BEGIN PGP SIGNATURE-----
> Version: GnuPG v1.2.4 (GNU/Linux)
> 
> iD8DBQFA7AVuBn4EFUVUIO0RAlXpAJ9I1FBUhqDDgV3Tvs53NjSM9BQq9QCeIVeu
> f4Jzs0L/LlvjOsm8CcMNoJs=
> =/jLZ
> -----END PGP SIGNATURE-----
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
> 

