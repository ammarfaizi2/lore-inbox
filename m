Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261693AbUKIVVq@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261693AbUKIVVq (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 9 Nov 2004 16:21:46 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261685AbUKIVVq
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 9 Nov 2004 16:21:46 -0500
Received: from ns1.g-housing.de ([62.75.136.201]:40067 "EHLO mail.g-house.de")
	by vger.kernel.org with ESMTP id S261693AbUKIVVm (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 9 Nov 2004 16:21:42 -0500
Message-ID: <419134E0.60906@g-house.de>
Date: Tue, 09 Nov 2004 22:21:36 +0100
From: Christian Kujau <evil@g-house.de>
User-Agent: Mozilla Thunderbird 0.8 (X11/20040926)
X-Accept-Language: de-DE, de, en-us, en
MIME-Version: 1.0
To: Kernel Mailing List <linux-kernel@vger.kernel.org>
CC: Greg KH <greg@kroah.com>, Linus Torvalds <torvalds@osdl.org>,
       Pekka Enberg <penberg@gmail.com>, Matt_Domsch@dell.com
Subject: Re: [PATCH] kobject: fix double kobject_put() in error path of kobject_add()
References: <418F6E33.8080808@g-house.de> <Pine.LNX.4.58.0411080951390.2301@ppc970.osdl.org> <418FDE1F.7060804@g-house.de> <419005F2.8080800@g-house.de> <41901DF0.8040302@g-house.de> <84144f02041108234050d0f56d@mail.gmail.com> <4190B910.7000407@g-house.de> <20041109164238.M12639@g-house.de> <Pine.LNX.4.58.0411091026520.2301@ppc970.osdl.org> <20041109190420.GA2498@kroah.com> <20041109190809.GA2628@kroah.com>
In-Reply-To: <20041109190809.GA2628@kroah.com>
X-Enigmail-Version: 0.86.1.0
X-Enigmail-Supports: pgp-inline, pgp-mime
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

Greg KH schrieb:
> 
> Christian, I don't know if this patch explicitly fixes your problem, but
> it fixes problems other people have been having with the driver core
> lately.  I'd appreciate it if you could test it out and let me know if
> it solves your problem, with CONFIG_EDD enabled, or if it doesn't help
> at all.
> 

yes, i'll do so and test the patch. is this in current -BK yet? because
applying your patch [1] to 2.6.10-rc1 gives:

Hunk #1 FAILED at 181.
1 out of 1 hunk FAILED -- saving rejects to file lib/kobject.c.rej

i've done a few other things before, let me just post the results before i
go on with your suggestions:

i've compiled a recent (BK) 2.6.10-rc1 again with CONFIG_EDD=m|y|n

http://www.nerdbynature.de/bits/prinz/2.6.10-rc1/config-2.6.10-rc1_edd-modular.txt
http://www.nerdbynature.de/bits/prinz/2.6.10-rc1/config-2.6.10-rc1_edd.txt
http://www.nerdbynature.de/bits/prinz/2.6.10-rc1/config-2.6.10-rc1_no-edd.txt

the results:

http://www.nerdbynature.de/bits/prinz/2.6.10-rc1/dmesg-2.6.10-rc1_edd-modular.txt
http://www.nerdbynature.de/bits/prinz/2.6.10-rc1/dmesg-2.6.10-rc1_edd.txt
http://www.nerdbynature.de/bits/prinz/2.6.10-rc1/dmesg-2.6.10-rc1_no-edd.txt

the interesting thing (for me) was, that when CONFIG_EDD=m was set, my
sound card was working properly and i could do "modprobe edd" and "rmmod
edd" as i like:

http://www.nerdbynature.de/bits/prinz/2.6.10-rc1/typescript-2.6.10-rc1_edd-modular.txt

again: i double checked and compiled on 2 different hosts, each having
it's own -BK tree.

thanks,
Christian.

[1] http://www.nerdbynature.de/bits/prinz/2.6.10-rc1/edd-fix.patch
- --
BOFH excuse #22:

monitor resolution too high
-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.5 (GNU/Linux)
Comment: Using GnuPG with Thunderbird - http://enigmail.mozdev.org

iD8DBQFBkTTg+A7rjkF8z0wRAvFPAKCCM05vqhg4u2NH2wklRRbxdVSpcwCff9a3
/KodSmgp9J4Nf2LDcTiBOCo=
=B/3X
-----END PGP SIGNATURE-----
