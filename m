Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268055AbUHKT3x@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268055AbUHKT3x (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 11 Aug 2004 15:29:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268053AbUHKT3w
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 11 Aug 2004 15:29:52 -0400
Received: from ns1.g-housing.de ([62.75.136.201]:51934 "EHLO mail.g-house.de")
	by vger.kernel.org with ESMTP id S268194AbUHKT3j (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 11 Aug 2004 15:29:39 -0400
Message-ID: <411A739D.1040000@g-house.de>
Date: Wed, 11 Aug 2004 21:29:33 +0200
From: Christian Kujau <evil@g-house.de>
User-Agent: Mozilla Thunderbird 0.7.1 (X11/20040715)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: linux-kernel <linux-kernel@vger.kernel.org>
CC: vortex@scyld.com, netdev@oss.sgi.com, nfs@lists.sourceforge.net,
       debian-kernel@lists.debian.org
Subject: oops with 2.6.8-rc4 (ipv6 / nfs / 3c59x related?)
X-Enigmail-Version: 0.84.2.0
X-Enigmail-Supports: pgp-inline, pgp-mime
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

hi list,

yesterday i encounterd several oopses with my "server". the subject of
this mail is just plain saying that it is all "2.6.8-rc4's fault". the
reality however turned out to be much more complex and confusing so i
try to recapitulate in a chronologically way:

- - the box (debian/unstable, i368 [PentiumIII] ) was running for 28 days
with 2.6.7-ck5 (no other patches but the -ck5 [1] )

- - ipv6 transition interface was down again, i had to start the freenet6
client again, to setup sit1. then i tried from a nfs-client to use this
interface by issuing "tracepath6" comamnds when i noticed my nfs-server
(the pIII-box) was dead. i could not catch the oops, had no digicam at
hand / was too lazy to write, i'll tell later on that.

- - rebooted same kernel, tried again locally (setup sit1, tracepath6 to
some ipv6 host) -> the box oopsed and locked up. (SYSRQ-s|u did not
succeed, only SYSRQ-b...rebooting)

- - ok, 2.6.8-rc4 is out anyway, time to update. compiled, booted, setup
sit1, tracepath6....-> the box oopsed and locked up.

- - am i too dumb to boot my self-built kernels? perhaps, so i used
kernel-image-2.6.7-1-686 from debian. again: i set up sit1, tracepath6
to some host -> ha! it did not lock up instantly, but tracepath6 gave
not results, so i CTRL-C'ed it and received a message:

KERNEL: assertion (!atomic_read(&sk->sk_wmem_alloc)) failed at
net/ipv4/af_inet.c (155)

everytime i CTRL-C'ed i received this message. and 2.6.7-1-686 was still
alive....for a few minutes. when i used my nfs-client to issue
tracepath6 commands, the box oopsed but this time the oops mad it to the
disk [2]. then it locked up, and the screen filled with traces.

- - today i got a camera so i was able to catch the oops [3] + [4]. now
the confusing part: i rememberd the oopses from the 2.6.8-rc4: they were
 the same as [3] is showing, so it seemed to be related to the 3c59x
module. i even suspected (sudden) harware problems so i changed the NIC
to another 3c59x card. hm, the 3c59x oopses were gone indeed (somehow i
still doubt the card is damaged), but the nfs related oopses occured
with 2.6.7-1-i686 *and* 2.6.8-rc4 [4] + [5].

- - so, the nfs-related oopses were  100% reproducable when i used the
nfs-shares on the client (both 2.6.7-1-686 and 2.6.8-rc4)

- - somehow ipv6 was always involved, i could not trigger the oops when
ipv6 was not loaded/sit1 was not setup.

- - vanilla 2.6.7 seems not affected, 2.6.8-rc[1..3] are also ok
(2.6.8-rc3 is running atm).

i hope i did not mix something up here. yes, maybe this report has to
split up into one ipv6 and one nfs report. i hope [3], [4], [5] are
helpful to find out what the oops was all about. (the "Tainted" flags in
the 2.6.7-1-686 kernels came from loop-aes modules:
"loop: no version for "struct_module" found: kernel tainted.")

sorry for the crossposting (please delete rcpts if not applicable)
Thank you for your commments.
Christian.

[1] http://ck.kolivas.org/patches/2.6/2.6.7/2.6.7-ck5/patch-2.6.7-ck5.bz2

[2] http://nerdbynature.de/bits/sheep/2.6.8/2.6.7-1-686.oops

[3] http://nerdbynature.de/bits/sheep/2.6.8/2.6.7-1-686.oops_3c59x.jpg
[4] http://nerdbynature.de/bits/sheep/2.6.8/2.6.7-1-686.oops_nfs.jpg
[5] http://nerdbynature.de/bits/sheep/2.6.8/2.6.8-rc4.oops_nfs.jpg

everything:
   http://nerdbynature.de/bits/sheep/2.6.8/

- --
BOFH excuse #78:

Yes, yes, its called a design limitation
-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.5 (GNU/Linux)
Comment: Using GnuPG with Thunderbird - http://enigmail.mozdev.org

iD8DBQFBGnOd+A7rjkF8z0wRAqK2AJ96DxaNdgXBRbDJvhZUNChmh9kDugCdFyIa
n5wJaT5zXePq7xakS2SuPsA=
=SkFV
-----END PGP SIGNATURE-----
