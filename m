Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264843AbUEQBIj@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264843AbUEQBIj (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 16 May 2004 21:08:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264847AbUEQBIj
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 16 May 2004 21:08:39 -0400
Received: from metawire.org ([24.73.230.118]:43821 "EHLO mail.metawire.org")
	by vger.kernel.org with ESMTP id S264843AbUEQBIg (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 16 May 2004 21:08:36 -0400
Date: Sun, 16 May 2004 20:08:51 -0500 (EST)
From: jnf <jnf@datakill.org>
X-X-Sender: jnf@metawire.org
To: "P. Christeas" <p_christ@hol.gr>
Cc: Jan De Luyck <lkml@kcore.org>, lkml <linux-kernel@vger.kernel.org>
Subject: Re: [2.6.6] Synaptics driver is 'jumpy'
In-Reply-To: <200405161427.44859.p_christ@hol.gr>
Message-ID: <Pine.BSO.4.58.0405162007260.20177@metawire.org>
References: <200405161427.44859.p_christ@hol.gr>
X-SUPPORT: 0xDEADFED5 lab pr0ud supp0rt3rz 0f pr0j3kt m4yh3m
X-GPG-FINGRPRINT: 7DB1 AEED B2C7 FE09 433C  5106 B0A0 1E4C 084B 8821
X-GPG-PUBLIC_KEY: http://www.bombtrack.org/~jnf/jnf.asc
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

I just wanted to add that I also have a synaptics mouse, running 2.6.6 and 
yesterday i was compiling 2 copies of xfree86, glibc and gcc at the same 
time getting loads into the 5.x range per uptime and havent experienced 
any problems; well other than my occasional problem of putting an extra 
finger on the mouse pad and then wondering whats wrong.



- -- 

It is only the great men who are truly obscene.  If they had not dared to 
be obscene, they could never have dared to be great.
                -- Havelock Ellis
 


On Sun, 16 May 2004, P. Christeas wrote:

> > Hello List,
> > 
> > Since installing 2.6.6 on my trusty laptop, I can't use the built-in 
> synaptics
> > touchpad anymore. The tracking is totally broken:
> > 
> > When you touch-drag on the touchpad, the mouse cursor will jump to where you
> > stopped your action approx. 1/1.5 seconds _after_ your move. This makes 
> using
> > the touchpad virtually impossible.
> > 
> > This problem is not present under 2.6.5, which I'm running right now.
> > Same .config.
> > 
> > Nothing seems to show up in the logs that could reflect any problem.
> > 
> > Any pointers?
> > 
> > Jan
> > 
> 
> Under normal load this shouldn't happen. It could only have to do with 
> interrupts from PS/2 port.
> However, this shows the actual problem with using Synaptics' absolute mode. I 
> vote against having this as the default setting.
> In the absolute mode, the CPU must process the absolute movements of the 
> finger in order to translate them to mouse movements. That means that, under 
> some system load, the mouse will not respond smoothly any more. I wouldn't 
> like to have increased priority or so just for the mouse.
> In the relative mode, the touchpad processor calculates the movements and 
> queues them as mouse events to the PS/2. This buffering provides smooth 
> movement even under heavy CPU usage. The downside is that in relative mode, 
> the touchpad has no adjustments (only default ones) and no extra features 
> (Z-axis, scroll zones). It may even not have the middle button (which I'm 
> missing most)
> Perhaps we should ask Synaptics for a better relative mode. AFAIK the PIC 
> processor inside the touchpad is not upgradeable, but future models could 
> offer better code..
> 
> Try running the touchpad in relative mode, with 'options psmouse proto=exps' 
> at /etc/modprobe.conf, which disables the Synaptics (i.e. absolute mode).
> 
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
> 
-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.2 (OpenBSD)

iD8DBQFAqBCnsKAeTAhLiCERAl8UAJ0d3cyQg+Qh16N2m2DyoYUcRzBVpACfc1hO
DF/SQKwG/VySAactWl3akJA=
=V5Nx
-----END PGP SIGNATURE-----
