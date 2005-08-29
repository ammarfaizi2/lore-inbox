Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750754AbVH2HEQ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750754AbVH2HEQ (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 29 Aug 2005 03:04:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751171AbVH2HEP
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 29 Aug 2005 03:04:15 -0400
Received: from mail03.syd.optusnet.com.au ([211.29.132.184]:63105 "EHLO
	mail03.syd.optusnet.com.au") by vger.kernel.org with ESMTP
	id S1750754AbVH2HEP (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 29 Aug 2005 03:04:15 -0400
From: Con Kolivas <kernel@kolivas.org>
To: linux-kernel@vger.kernel.org
Subject: 2.6.13-ck1
Date: Mon, 29 Aug 2005 17:03:24 +1000
User-Agent: KMail/1.8.2
Cc: ck list <ck@vds.kolivas.org>
MIME-Version: 1.0
X-Length: 4943
Content-Type: multipart/signed;
  boundary="nextPart20464847.XKIZK5kTBu";
  protocol="application/pgp-signature";
  micalg=pgp-sha1
Content-Transfer-Encoding: 7bit
Message-Id: <200508291703.26529.kernel@kolivas.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

--nextPart20464847.XKIZK5kTBu
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

These are patches designed to improve system responsiveness and interactivi=
ty.=20
It is configurable to any workload but the default ck* patch is aimed at th=
e=20
desktop and ck*-server is available with more emphasis on serverspace.


Apply to 2.6.13
http://ck.kolivas.org/patches/2.6/2.6.13/2.6.13-ck1/patch-2.6.13-ck1.bz2
or development version:
http://ck.kolivas.org/patches/2.6/2.6.13/2.6.13-ck1/patch-2.6.13-ck1+.bz2

or server version:
http://ck.kolivas.org/patches/2.6/2.6.13/2.6.13-ck1/patch-2.6.13-ck1-server=
=2Ebz2


web:
http://kernel.kolivas.org
all patches:
http://ck.kolivas.org/patches/
Split patches available.


Changes since 2.6.12-ck6:

Changed:
 -2.6.12_to_staircase11.3.diff
 +2.6.13_to_staircase12.diff
Minor cleanups. Restore 10ms round robin intervals. 5ms, while giving bette=
r=20
interactive feel, caused problems on dual core amd64 and 250Hz (for=20
reasons that I have yet to track down). The ck1+ patch has 5ms RR intervals.

 -smp-nice-support6.diff
 -smpnice6-smpnice7.diff
 +smp-nice-support7.diff
Rollup

 -batch_ionice.diff
 +isobatch_ionice2.diff
Update the link between i/o priorities and SCHED_ISO

 -mapped_watermark3.diff
This has been replaced with the split out patches that build on this work:

 +vm-mapped.diff
Turn the "swappiness" knob into one with well defined semantics. Rename it
"mapped" to correspond directly with the percentage of mapped ram or
"applications" as users think of it. Currently the swappiness algorithm can
easily lead to swapping situations on simple file copies due to the distress
algorithm which too easily overrides the swappiness value. Add a
"hardmaplimit" tunable, on by default, which only allows the vm to override
the "mapped" tunable when distress is at its greatest to prevent false
out-of-memory situations.

 +vm-lots_watermark.diff
The vm currently performs scanning when allocating ram once the watermarks
are below the pages_low value and tries to restore them to the pages_high
watermark. The disadvantage of this is that we are scanning most aggresssiv=
ely
at the same time we are allocating ram regardless of the stress the vm is
under. Add a pages_lots watermark and allow the watermark to be relaxed
according to the stress the vm is at the time (according to the priority
value). Thus we have more in reserve next time we are allocating ram and end
up scanning less aggresssively.


Added:
 +sched-iso3.1.patch
Here is a complete rewrite of the SCHED_ISO code. Having dropped SCHED_ISO =
in=20
the stable series in preference for RT RLIMITS it was clear that there is=20
still indication for SCHED_ISO for the following reasons:
It provides real-time performance without risking starvation/DoS
It is much easier to set up than RT RLIMITS without any knowledge and you c=
an=20
benefit from it without knowing anything about it (unprivileged tasks tryin=
g=20
to start real time get demoted to SCHED_ISO)
Userspace support for it is here and now

This version of SCHED_ISO is actually much more robust than the one in=20
previous -ck kernels which just had a lowish latency version of SCHED_NORMA=
L.=20
SCHED_ISO tasks now actually run like real time tasks at the equivalent=20
priority as nice -20 tasks unless they use more than 70% of the cpu for a=20
rolling 3 second time period. Then they're demoted to behave like SCHED_NOR=
MAL=20
tasks.

 +vm-background_scan.diff
Add a background scanning timer to restore the watermarks to the pages_lots
level and only call on it if kswapd has not been called upon for the last 5
seconds. This allows us to balance all zones to the more generous pages_lots
watermark at a time unrelated to page allocation thus leading to lighter
levels of vm load when called upon under page allocation.

 +pdflush-tweaks.patch
The speed we write out dirty data to disk can clash with the average time d=
isk=20
journals write out. This tweaks it to write out dirty data slightly more=20
frequently and minimise prolonged write starvation.

 +hz-default_values.patch
Hz is now configurable, so set some useful defaults as 250 is no good to=20
either desktop or server. Set 1000 for most desktop architectures (or 100 i=
n=20
ck-server).

 +2613ck1-version.diff
Version


Rolled into mainline or above patches or removed:
 -cfq-2.6.12-mm1.patch
 -sched-fix_up_build.patch
 -cfq-ts-2.diff
 -cfq-ts-4.diff
 -s11.3_s11.4.diff
 -s11.4_s11.6.diff
 -patch-2.6.12.5.bz2
 -2612ck6-version.diff


In 2.6.13-ck1+ only:
 +sched-staircase12_tweak.patch
As mentioned above, set round robin intervals to 5ms (unsuitable on some=20
hardware). Please try and if you have problems, email me with information.

 +vm-swap-prefetch.patch
This patch stores a list of ram that is put to swap and if the memory=20
subsystem is idle for a time it starts swapping the ram pages back in gentl=
y=20
in the reverse order they went out. The idea is that when you come back to=
=20
your pc after it has been idle for a while, if any applications have been=20
swapped out they should have swapped back in quietly. It does not delete th=
e=20
page entries from the swap so that if there is any stress, these pages can=
=20
effectively be swapped back out for free without further disk access. The=20
patch is still new so has had limited testing only. Please test and report=
=20
back. This depends on the previous 2 vm patches to patch cleanly.


=46ull patchlist:
sched-run_normal_with_rt_on_sibling.diff
2.6.13_to_staircase12.diff
schedrange.diff
schedbatch2.9.diff
sched-iso3.1.patch
smp-nice-support7.diff
1g_lowmem1_i386.diff
defaultcfq.diff
isobatch_ionice2.diff
rt_ionice.diff
pdflush-tweaks.patch
hz-default_values.patch
vm-mapped.diff
vm-lots_watermark.diff
vm-background_scan.diff
2613ck1-version.diff
vm-swap-prefetch.patch
sched-staircase12_tweak.patch


Cheers,
Con Kolivas

--nextPart20464847.XKIZK5kTBu
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.1 (GNU/Linux)

iD8DBQBDErM+ZUg7+tp6mRURApyHAJ9iQ9xqGPVBXfnJn91mW9S4h/RWFgCcDojx
eyrfma86kD3by2wAdEfnmpw=
=heo3
-----END PGP SIGNATURE-----

--nextPart20464847.XKIZK5kTBu--
