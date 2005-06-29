Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262739AbVF2Xk1@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262739AbVF2Xk1 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 29 Jun 2005 19:40:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262740AbVF2Xk1
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 29 Jun 2005 19:40:27 -0400
Received: from mxout04.versatel.de ([212.7.152.118]:29083 "EHLO
	mxout04.versatel.de") by vger.kernel.org with ESMTP id S262733AbVF2XkE
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 29 Jun 2005 19:40:04 -0400
Message-ID: <42C33149.3090305@web.de>
Date: Thu, 30 Jun 2005 01:39:53 +0200
From: Christian Trefzer <ctrefzer@web.de>
User-Agent: Mozilla Thunderbird 1.0.2 (X11/20050617)
X-Accept-Language: de-DE, de, en-us, en
MIME-Version: 1.0
To: "Darryl L. Miles" <darryl@netbauds.net>
CC: linux-kernel@vger.kernel.org
Subject: Re: 2.6.12 initrd module loading seems parallel on bootup
References: <42BDFEC2.3030004@netbauds.net> <20050625234611.118b391d.akpm@osdl.org> <42BE7E38.9070703@netbauds.net> <42BE98C5.1070102@web.de> <20050626141106.GA12223@shuttle.vanvergehaald.nl> <42BF92D4.3040609@netbauds.net>
In-Reply-To: <42BF92D4.3040609@netbauds.net>
X-Enigmail-Version: 0.92.0.0
OpenPGP: id=6B99E3A5
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature";
 boundary="------------enig8CAF2C5E135AE9A170DAE2FE"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is an OpenPGP/MIME signed message (RFC 2440 and 3156)
--------------enig8CAF2C5E135AE9A170DAE2FE
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Hi Darry,
first of all thanks for your questions, and sorry for answering late, 
I've been away for some time.

Darryl L. Miles schrieb:
> 
> Are we sure we are not talking about two different problems here.
> 
> I'm using RedHat and mkinitrd, in the initrd image there is already a 
> skeleton /dev tree that contains my real-root device.  udev also exists 
> in the initrd image.  I don't think any /dev device magic was necessary 
> for me too mount root.
> 
> It is not clear Chris which tools you are using on initrd, standard 
> Gentoo methods or a home brew setup ?  What shell is calling modprobe ?  
> Can you confirm at what point you are seeing modprobe exit ?

I am using a self-made initramfs setup using the "standard" binaries 
from the live system, usable for instance as rescue system with tools 
identical to anything I have installed, including bash as shell for the 
init script, udev, module-init-tools, lvm2, mdadm, and so on and so 
forth. There are only the most basic device nodes in the supplied /dev 
tree, like null, console, etc.
Unfortunately, I don't really "see" modprobe exit, it just takes less 
time until the "modprobe $mod && e_done" prints its "done." yet related 
device nodes are still missing. Waiting for any required nodes fixes the 
problem so far, but maybe bash-3.00 is having a similar issue as nash. 
I'll try using sash or busybox ASAP to check if the problem is somewhere 
else.

The funny thing is that with kernels up to 2.6.11.12, I don't see this 
problem. The patch mentioned further up this thread was against 
2.6.11-rc1 and should have been applied long before I even touched 
2.6.11, so I just don't understand why I have problems now.

> * Immediatly (before device driver has detected hardware and reported / 
> registered its findings).  This is the symptom I was seeing, but the 
> cause was incorrect shell handling. * After detection but before device 
> node creation.

Well, so far I cannot distinguish both of these cases, but it definitely 
is _not_ the third one:

> * After device node creation.
> 
> 
Otherwise I would not run into problems like mdadm failing trying to 
assemble arrays while disk nodes are still missing in action.

> FYI - This looks like the snippet from nash.c
> 
> [snip]

Thanks for the patch, I'll look into similarities in the bash code if 
the shell really is the cause of my trouble.

--------------enig8CAF2C5E135AE9A170DAE2FE
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.1 (GNU/Linux)
Comment: Using GnuPG with Thunderbird - http://enigmail.mozdev.org

iQIVAwUBQsMxTV2m8MprmeOlAQKrQg//SnNcSLysIH83MWk7ZWVgMLUax0nIGG9U
cL0hrm6QOM25O1t937Pz3sXxxv9EtwiPZcqG5V9V3vRCk2LFzWvW4xFhIw75hBNp
gi1dWPSx1gBKfdpF3qcstc5Hxul0zPmP6/99Nei4dfSlD5wZ3NhMSFOnooEJOobP
CrMH3LTB5M1riJDkwqVvSC4siQ6C8fdGfVM0XyRSvNVeH67zKli85kedr4wPMEmK
9fRr+zrbGVRjOgtsXyAtuCUxqKbby8gVCT/tNRciu6b1RiHANspLANMU6wSST1u4
3pAcmIaEDwFEdhin08DQcmd6h8xbPAl8v/k2zrANx6xVdX9wIlt86wPusDdBFywz
TnUw0DYsdmw+xcTj7XpcZmKaRx52UKOcWorRUcZqyu4B+M7yw7E3K6pt54QJDRj2
/fZdkByfrZDt26QQw4kzVCJfopLspskolAcsjB3TaIZfME1UXnzNnySf4v5QPafl
l/VlfRDbRSeerj8pwGSH6IqRTKQ9bFK6/AqJVIMBI4UHzJMIOlRnZDTw9QFTfkMx
2JjV736POMAMFGdCfuXLWyDTzoMvG5E4c/vwPlOEckgdPUX4eK2HtVZKyqJuMfl8
0G8xKLxe/8DrjWcHNDXTgOHhBVHBYGwYypVEO585sZqOiewesop5JwrawpZB+51J
bFa66cqLBbs=
=8p9I
-----END PGP SIGNATURE-----

--------------enig8CAF2C5E135AE9A170DAE2FE--
