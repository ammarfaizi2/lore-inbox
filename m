Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S274790AbRIZCkY>; Tue, 25 Sep 2001 22:40:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S274791AbRIZCkP>; Tue, 25 Sep 2001 22:40:15 -0400
Received: from mailout00.sul.t-online.com ([194.25.134.16]:32778 "EHLO
	mailout00.sul.t-online.de") by vger.kernel.org with ESMTP
	id <S274790AbRIZCkF>; Tue, 25 Sep 2001 22:40:05 -0400
Subject: Serious allocating/freeing memory or ReiserFS problem in 2.4.10
From: Veit Wahlich <cru@zodia.de>
To: linux-kernel@vger.kernel.org
Content-Type: multipart/signed; micalg=pgp-sha1; protocol="application/pgp-signature";
	boundary="=-4IjOc6Pp1LMcac85Z0TL"
X-Mailer: Evolution/0.13 (Preview Release)
Date: 26 Sep 2001 04:40:26 +0200
Message-Id: <1001472028.805.92.camel@instructor.localnet>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--=-4IjOc6Pp1LMcac85Z0TL
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable

Hi!

When I upgraded my kernel from 2.4.9 to 2.4.10 I experienced the problem
described in this posting. Because I lack in time, I am not able to read
this mailing list regularly, so I do not know whether this problem is
known or not. Because I am short on time and this caused crashes on my
system I can not apply any screenshots/hardcopys but I will try to help
fetching information about this wherever I can. For this please contact
cru@zodia.de .

I discovered this while using donkey (www.edonkey2000.com), a
non-opensource P2P solution applying a Linux client. Contact is
info@edonkey2000.com , I will forward this email to them.

As donkey is a MFTP implementation it begins to "hash" all incomplete
files in the download queue when run. This means it reads the whole file
and builds a kind of checksum (as I suppose) of all segments that are
already downloaded. During this process, the amount of memory in use
steadily grows, while the memory used by all processes (including
donkey) stays nearly unchanged. Because I am running ReiserFS and donkey
is reading huge files, this could also be a ReiserFS problem. I have no
experience with donkey and kernels <2.4.9.


Using 384Mb RAM on Linux 2.4.9 with CONFIG_NOHIGHMEM:

When memory usage is up to 95%, the system begins to push all other
processes to swap. This includes some daemons, XF86 4.0.3, some killer
applications (Mozilla, Evolution) and even parts of the donkey itself.
Working becomes nearly impossible but the system keeps working.
When "hashing" has been completed, memory usage stays at 99.9% but all
processes can be used again, pulling them from swap. Opening and closing
bigger applications also "frees" some memory, closing the donkey frees
not more memory than the few Mb the donkey processes really used. But in
this state working with the machine is possible as every day.


Using 384Mb RAM on Linux 2.4.10 with CONFIG_NOHIGHMEM:

The first time I ran the donkey I discovered that it was much slower and
took twice the time it usually takes for hashing, but work on the
machine after hashing was fine. I decided to buy more RAM.


Using 1023Mb RAM on Linux 2.4.10 with CONFIG_HIGHMEM4G:

As the kernel told me on boot, I enabled CONFIG_HIGHMEM4G to use more
than 896Mb. That gave me 896+127Mb.
Now running donkey ended with X to hang, when the system began to swap
at 99% mem usage. I was able to ssh to the machine, ps told me X was
using 1160% of MEM and killing it was impossible, kill gave no msg on
STDOUT/-ERR, the process stayed in state R. Shutting it down failed,
shutdown became a zombie.

On next run I started watching the donkey hashing and inspected the
memory usage with top. When mem usage reached 99% and swap 72Mb, several
processes collapsed with a segfault (some Gnome applets and Evolution),
top got some "/proc/*: out of memory" messages on the screen, than also
top segfaulted. Donkey stopped working without completing the hashing
because one of its own processes collapsed. Still running processes
looked fine with ps but shutting down failed as described above.

The third run exactly was like run #2.


Using 896Mb RAM on Linux 2.4.10 with CONFIG_NOHIGHMEM:

When donkey was hashing and swap reached about 70Mb, X collapsed (and
got restarted by init), donkey was killed by this. Gracefully shutting
down the machine was possible.


Using 896Mb RAM on Linux 2.4.9 with CONFIG_NOHIGHMEM:

Run #2: I booted the 2.4.9 kernel without highmem support and donkey
runs fine, I am even able to work a bit while it is hashing (and
swapping).


I was unable to test 2.4.9 with CONFIG_HIGHMEM4G because I deleted the
source tree backup after 2.4.10 seemed to run fine and I had no time to
download and build it again.

The kernel is Linux 2.4.9/2.4.10 without third-party patches. I am
running nVidia's NVdriver/GLX v1.0-1512 but this module was disabled in
one unsuccessful run, gcc is 2.95.2.1. The new RAM has been successfully
tested for 8h by memtest86 on this machine.


Please CC any comments, answers, questions, solutions regarding this
posting to cru@zodia.de .=20

Thanks.
// Veit Wahlich


--=-4IjOc6Pp1LMcac85Z0TL
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.0.6 (GNU/Linux)
Comment: Weitere Infos: siehe http://www.gnupg.org

iD8DBQA7sUAarDxCW1octZcRAiACAKCQREGl9jX0EfFJTfmOo16Dh+emvgCfUzAr
x4Va78k6BbRaj3QrV3I9/9o=
=6Aru
-----END PGP SIGNATURE-----

--=-4IjOc6Pp1LMcac85Z0TL--

