Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261778AbUKIXeo@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261778AbUKIXeo (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 9 Nov 2004 18:34:44 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261780AbUKIXea
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 9 Nov 2004 18:34:30 -0500
Received: from ns1.g-housing.de ([62.75.136.201]:22660 "EHLO mail.g-house.de")
	by vger.kernel.org with ESMTP id S261766AbUKIXa0 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 9 Nov 2004 18:30:26 -0500
Message-ID: <4191530D.8020406@g-house.de>
Date: Wed, 10 Nov 2004 00:30:21 +0100
From: Christian Kujau <evil@g-house.de>
User-Agent: Mozilla Thunderbird 0.8 (X11/20040926)
X-Accept-Language: de-DE, de, en-us, en
MIME-Version: 1.0
To: Kernel Mailing List <linux-kernel@vger.kernel.org>
CC: Linus Torvalds <torvalds@osdl.org>, Pekka Enberg <penberg@gmail.com>,
       Greg KH <greg@kroah.com>, Matt_Domsch@dell.com
Subject: Re: Oops in 2.6.10-rc1 (almost solved)
References: <4180F026.9090302@g-house.de>  <Pine.LNX.4.58.0411070831200.2223@ppc970.osdl.org>  <20041107182155.M43317@g-house.de> <418EB3AA.8050203@g-house.de>  <Pine.LNX.4.58.0411071653480.24286@ppc970.osdl.org>  <418F6E33.8080808@g-house.de>  <Pine.LNX.4.58.0411080951390.2301@ppc970.osdl.org>  <418FDE1F.7060804@g-house.de> <419005F2.8080800@g-house.de>  <41901DF0.8040302@g-house.de> <84144f02041108234050d0f56d@mail.gmail.com> <4190B910.7000407@g-house.de> <20041109164238.M12639@g-house.de> <Pine.LNX.4.58.0411091026520.2301@ppc970.osdl.org>
In-Reply-To: <Pine.LNX.4.58.0411091026520.2301@ppc970.osdl.org>
X-Enigmail-Version: 0.86.1.0
X-Enigmail-Supports: pgp-inline, pgp-mime
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

Linus Torvalds schrieb:
> 
> Very strange. There's not a lot of stuff that affects EDD directly that I 
> can see, but there is:
> 
> 	ChangeSet@1.2000.5.108, 2004-10-20 08:36:22-07:00, Matt_Domsch@dell.com
> 	  [PATCH] EDD: use EXTENDED READ command, add CONFIG_EDD_SKIP_MBR

and i say: good catch! that does it!

i did "bk undo -a1.2000.5.108" on a current tree, booting this still gives
an oops:

http://www.nerdbynature.de/bits/prinz/2.6.10-rc1/dmesg-2.6.9_a1.2000.5.108.txt

excluding this single ChangeSet with "bk undo -r1.2118" does work with
CONFIG_EDD=y:

http://www.nerdbynature.de/bits/prinz/2.6.10-rc1/dmesg-2.6.9_r1.2000.5.108.txt

(the filename here should really read "...r1.2118.txt" because that was
the number of the changeset representing the above [PATCH] *after* i did
"bk undo -a1.2000.5.108". right?)

> However, even that would just change the EDD _data_, it doesn't change the 
> code that actually runs in the kernel. And I _really_ don't see what EDD 
> has got to do with anything.

understanding a lot less of all this than you guys i also wonder why only
this single driver broke. i've always loaded a couple of drivers here,
maybe i could play around a bit e.g. CONFIG_SND_ENS1371=y instead of =m or
see if other hw drivers break too.

> I wonder if the EDD stuff corrupts the sysfs tree or something, and you're
> just seeing some strange kobject interference.

do userspace tools matter here? there is "sysfsutils-1.1.0-1" and
"libsysfs1-1.1.0-1" (both debian/unstable) installed here, /sys is mounted:

   sysfs on /sys type sysfs (rw)

> Christian, finding which change triggers this would be very good indeed. I 
> think the merge with greg is still a good place to start, although even 

i'll look again over the -bk magic you told me about and see what it gives.

thanks so far to all involved here, i really enjoyed "working" with you.
first class support at no charge...it's just incredible.

you guys rock,
Christian.
- --
BOFH excuse #112:

The monitor is plugged into the serial port
-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.5 (GNU/Linux)
Comment: Using GnuPG with Thunderbird - http://enigmail.mozdev.org

iD8DBQFBkVMN+A7rjkF8z0wRAqu4AKCtxZxE2spjZGgSnxTWzTTB0CWCkACgi2f3
RmHQXbnkcI1OEcLORhP1dmA=
=5Dot
-----END PGP SIGNATURE-----
