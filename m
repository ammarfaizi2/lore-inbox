Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S263740AbRFMODk>; Wed, 13 Jun 2001 10:03:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S263747AbRFMODa>; Wed, 13 Jun 2001 10:03:30 -0400
Received: from max.phys.uu.nl ([131.211.32.73]:8979 "EHLO max.phys.uu.nl")
	by vger.kernel.org with ESMTP id <S263740AbRFMODS>;
	Wed, 13 Jun 2001 10:03:18 -0400
Date: Wed, 13 Jun 2001 16:03:15 +0200 (MET DST)
From: Marijn Ros <J.M.Ros@phys.uu.nl>
To: "'mosix-list@cs.huji.ac.il'" <mosix-list@cs.huji.ac.il>
cc: <linux-kernel@vger.kernel.org>
Subject: linux 2.4.5: initrd problems: /sbin/init not found (Was: Re: mosix
 and nt)
In-Reply-To: <01061122510500.00353@snoopy>
Message-ID: <Pine.OSF.4.33.0106131528360.22133-100000@ruunat.phys.uu.nl>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 11 Jun 2001, Matthias Papesch wrote:

> Hi,
>
> I'm wondering what kind of filesystem do you exactly need on the cluster
> nodes?
>
> The way I understand it (correct me if I'm wrong) is, that MOSIX starts
> the process on the local node and then migrates the contents of the
> memory. So it should actually be enough if there is MOSIX kernel running
> with the user space tools available. This should be small enough (<8MB) to
> be used as a ramdisk.

This is the way I use it at home; a boot-floppy with a MOSIX-enabled linux
kernel (1.0.1/2.4.4 at the moment), and a ROMFS initrd image with a small
statically compiled /sbin/init C-program that sets up the network
interface and MOSIX. The kernel is about 450kb, the compressed initrd
image about 100kb.

However, when I try the same initrd image with linux 2.4.5 (with or
without the MOSIX-patch, enabled or not, compiled with gcc 2.95.2 on a
P75, run on a 486DX/33), it won't work. The kernel complains that
/sbin/init can not be found. It seems that the initialisation
restructuring broke automatic remounting of the initial ramdisk as
root-device (with root=/dev/rd/0). I had some luck when I copied my
/sbin/init to /linuxrc, as that file is run on the inial ramdisk. However,
I don't like that workaround.

Note that I have not filed a bugreport against kernel 2.4.5 (yet?), as I
don't trust my analysis of the problem, and also don't understand who
maintains the file init/main.c. However, I send a copy of this mail to the
linux-kernel mailing-list. Please send (a copy of) your reply to either
the mosix-list or my personal mail-address, as I follow linux-kernel only
through the KT summaries.

Bye,
	Marijn

-- 
-------------------------------------------------------------
 April 15 1998: fys.ruu.nl -> phys.uu.nl
-------------------------------------------------------------
 Commercial and/or unsollicited email and/or spam will be
 processed for a DFL100 handling fee. Unsolicited sending
 constitutes acceptance.
-------------------------------------------------------------

