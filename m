Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750807AbVKJM0y@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750807AbVKJM0y (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 10 Nov 2005 07:26:54 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750808AbVKJM0y
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 10 Nov 2005 07:26:54 -0500
Received: from imap.gmx.net ([213.165.64.20]:9957 "HELO mail.gmx.net")
	by vger.kernel.org with SMTP id S1750807AbVKJM0x (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 10 Nov 2005 07:26:53 -0500
X-Authenticated: #14842415
Date: Thu, 10 Nov 2005 13:26:51 +0100
From: Alessandro Di Marco <dmr@gmx.it>
To: linux-kernel@vger.kernel.org
Subject: [ANNOUNCE] Sluggard is a lazy translucent filesystem that may help
 to save resources
Message-ID: <20051110132651.4aaa5c87@nicetas.disi.unige.it>
X-Mailer: Sylpheed-Claws 1.9.15 (GTK+ 2.6.10; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: multipart/signed;
 boundary=Signature_Thu__10_Nov_2005_13_26_51_+0100_Ylm_XjZhvtXhhBmi;
 protocol="application/pgp-signature"; micalg=PGP-SHA1
X-Y-GMX-Trusted: 0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

--Signature_Thu__10_Nov_2005_13_26_51_+0100_Ylm_XjZhvtXhhBmi
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Excerpt from: "The linux-kernel mailing list FAQ"
<http://vger.kernel.org/lkml/#s7-7>

# The kernel source is HUUUUGE and takes too long to download. Couldn't
# it be split in various tarballs?
#=20
# <snip>
#=20
# Under no circumstances should you complain to the kernel list. I
# promise you that Linus and the core developers will completely ignore
# such messages, so whinging about it is a complete waste of
# bandwidth. The only message on this subject that should be posted is
# an announcement of a new service providing split kernel sources.

Hi everyone.

Not so long time ago I was wondering whether a more handy solution to
this problem could consist in a "lazy" filesystem interfaced with a
rsync repository containing the full kernel tree. So, when a new kernel
release goes out, the user has simply to resynchronize the lazy
filesystem with the repository, and in few seconds the user is able to
start its job. In fact, in this way the downloading takes place per file
basis, as soon as some of them are accessed in the lazy structure (on
demand). Clearly this would save both a lot of bandwidth and disk space,
because all the files that haven't been accessed will never be
downloaded.

If someone is wondering how it could work, please find here below a
possible answer. In fact I have developed a filesystem prototype for the
2.6 version of the kernel, called "Sluggard", implementing exactly the
lazy behavior above sketched. So, if everything is already clear for
you and you would like to try, please follow the link below.

http://dmrlsn.altervista.org/tarballs/Sluggard.tgz

Clearly you will need of a working rsync repository containing an
uncompressed kernel tree - or whatever you want (gentoo portage may be a
good start) - in order to play with Sluggard. Please note that it is
designed to be interfaced with rsync 2.6.0 (no patches are needed at
all), so you may get in trouble with different versions of this
software.

Also note that Sluggard has been obtained by cutting down pieces of code
from a larger project, so it may not be 100% as stable and full featured
as you wish (it is a prototype after all). Nevertheless I was able to
build simultaneously and without a glitch four distinct 2.6.14 trees
(each of them coming from a different rsync repository) on it.

For the sake of the performance, I can say that experiments have shown
how, for a typical laptop/workstation kernel setup, Sluggard has been
able to save approximately 70% of the disk space occupied by a
traditionally compiled 2.6.14 tree (100MB vs. 314MB), transferring only
the 25% of the compressed tarball published by kernel.org (9.5MB
vs. 37.35MB). Please note that the reported percents can still be
improved if we switch to a typical server setup, where most of features
(sound, graphics, usb, etc) are turned off.

Unfortunately, the meaning of "typical kernel setup" is quite unclear
almost for me, so I will not bother you anymore with statistics in this
sense. In case of interest Sluggard could be easily tested with the most
suitable setup according to your needs.

Every time a new file has been accessed, an rsync request is
synchronously sent to the rsync server managing the remote
repository. This means that every process accessing such a file will has
to wait that the rsync server finishes its job before it can go
ahead. Now, depending on the underlying network speed/latency and
processor power this behavior might slow down the overall build
process. Anyway, this problem can be readily overcome introducing a
certain degree of concurrency in the make process (make
-j<n>). Experiments performed on a gigabit (round trip 0.192ms) ethernet
connecting two dual Xeon 2.8GHz workstations show that four concurrent
make processes (make -j4) are able to maintain the Sluggard overhead
below the 39% of the time spent by a traditional build session on the
same hardware (3m34.361s vs. 2m33.129s). I agree that the gigabit test
bed is a "bit" off-target for the aim of the prototype, but
unfortunately I still haven't got any time to benchmarking on different
platforms/networks.

Now, trying to anticipate those who are just thinking that there's
nothing new under the sun here, I respond that Sluggard is essentially
an implementation of the "translucent filesystem" idea coupled with a
"lazy filesystem" one. Probably it might also be implemented in various
flavors, each with its pro and cons (using FUSE is an
alternative). Nevertheless it represents an attempt to save precious
resources just where they are never enough. In other words, the Linux
kernel is one of those beautiful albums that are downloaded every two
months, but are played only once and for most neither in full.

Now, for further information about Sluggard functioning and/or setup
please refer to the "README" file contained in the source archive,
download-able from the above link.

Thank you for your attention.

Best,
Alessandro

--Signature_Thu__10_Nov_2005_13_26_51_+0100_Ylm_XjZhvtXhhBmi
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.1 (GNU/Linux)

iD8DBQFDczyL6kvnLXl7RwERAh82AJ42mjNK6C6w+Sg3lncG959yntfupwCg1FPD
zg91c2y/L3UqevhQNDLaTiM=
=L1On
-----END PGP SIGNATURE-----

--Signature_Thu__10_Nov_2005_13_26_51_+0100_Ylm_XjZhvtXhhBmi--
