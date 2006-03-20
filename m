Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751079AbWCTKpn@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751079AbWCTKpn (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 20 Mar 2006 05:45:43 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751093AbWCTKpn
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 20 Mar 2006 05:45:43 -0500
Received: from mail25.syd.optusnet.com.au ([211.29.133.166]:35287 "EHLO
	mail25.syd.optusnet.com.au") by vger.kernel.org with ESMTP
	id S1751079AbWCTKpm (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 20 Mar 2006 05:45:42 -0500
From: Con Kolivas <kernel@kolivas.org>
To: linux list <linux-kernel@vger.kernel.org>
Subject: 2.6.16-ck1
Date: Mon, 20 Mar 2006 21:45:28 +1100
User-Agent: KMail/1.9.1
Cc: ck list <ck@vds.kolivas.org>
MIME-Version: 1.0
Content-Type: multipart/signed;
  boundary="nextPart1172027.hb6lSQLCQx";
  protocol="application/pgp-signature";
  micalg=pgp-sha1
Content-Transfer-Encoding: 7bit
Message-Id: <200603202145.31464.kernel@kolivas.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

--nextPart1172027.hb6lSQLCQx
Content-Type: text/plain;
  charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

These are patches designed to improve system responsiveness and interactivi=
ty.=20
It is configurable to any workload but the default ck patch is aimed at the=
=20
desktop and cks is available with more emphasis on serverspace.

Apply to 2.6.16
http://ck.kolivas.org/patches/2.6/2.6.16/2.6.16-ck1/patch-2.6.16-ck1.bz2

or server version
http://ck.kolivas.org/patches/cks/patch-2.6.16-cks1.bz2

web:
http://kernel.kolivas.org

all patches:
http://ck.kolivas.org/patches/

Split patches available.

* Take note, userspace features have changed in this version *

There are 3 special unprivileged (normal user) scheduling policies availabl=
e=20
as of 2.6.16-ck1. These can be set using the schedtools utility=20
(http://freshmeat.net/projects/schedtool/?topic_id=3D136) which has support=
 for=20
all of them. Additionally my toolsched scripts work as transparent wrappers=
=20
for them (http://ck.kolivas.org/apps/toolsched/). Note the policies are=20
different to earlier -ck versions:

SCHED_BATCH:
	This is for tasks you explicitly want the cpu scheduler to know are never=
=20
interactive and thus should never receive low latency treatment. Their cpu=
=20
usage is dependant on their nice value. This policy is also supported by=20
mainline now which is why there is a change of the naming/numbering scheme.

SCHED_ISO:
	This is for tasks you explicitly want the cpu scheduler to know are low=20
latency real-time like tasks but you don't have root privileges for and don=
't=20
wish them to ever starve the machine. They can use up to 80% of the availab=
le=20
cpu time (on one cpu at any time). This percentage is configurable=20
via /proc/sys/kernel/iso_cpu

SCHED_IDLEPRIO:
	This is for tasks you never want to use cpu if *anything* else wants cpu=20
time. That is they only ever use spare cpu cycles that would have otherwise=
=20
been idle time on the machine.


Changes since 2.6.15-ck7

Added:
 +sched-implement-smpnice.patch
 +sched-smpnice-apply-review-suggestions.patch
 +sched-smpnice-fix-average-load-per-run-queue-calculations.patch
New improved smpnice implementation

 +sched-store-weighted-load-on-up.patch
 +sched-add-discrete-weighted-cpu-load-function.patch
 +sched-add-above-background-load-function.patch
Updates to smpnice above to be used by swap prefetch

 +sched-generic_optims2.patch
Small naming cleanups / microoptimisations

 +sched-idleprio-1.2.patch
The old SCHED_BATCH policy from 2.6.15-ck7 has been renamed to SCHED_IDLEPR=
IO=20
and small updates to the policy were committed.

 +adaptive-readahead-11.patch
Wu Fengguang's adaptive readahead for improved read throughput without=20
thrashing. This version is configurable at build time. As some users have=20
reported latency issues with running this code, the config option is most=20
welcome, however those latency issues should have been mostly addressed. Se=
e=20
Documentation/sysctl/vm.txt for more info.


Removed:
 -vmsplit-config_options.patch
This is part of mainline 2.6.16 now

 -2.6.15-dynticks-060227.patch
 -dynticks-disable_smp_config.patch
Dynticks is dead! Long live dynticks! Something killed it off in 2.6.16-rc6=
=20
and I haven't figured out what it is. I don't know if/when I'll be able to=
=20
debug this so for the moment it is dropped.

=2Dpatch-2.6.15.6.bz2
Mainline


Modified:
 -sched-staircase13.2.patch
 -sched-staircase13.2_13.3.patch
 -sched-staircase13.3_13.4.patch
 -sched-staircase13.4_13.5.patch
 +sched-staircase14.2.patch
Rolled up and updated to latest version of staircase cpu scheduler. Mostly=
=20
microoptimisations, and intrinsic support for new style of SCHED_BATCH=20
policy.

 -schedrange-1.diff
 +schedrange-2.diff
Resync with change in scheduler policies available

 -schedbatch-2.11.diff
Replaced with new SCHED_IDLEPRIO policy

 -sched-iso3.3.patch
 +sched-iso-4.1.patch
Updated SCHED_ISO unprivileged soft real time policy. This now is higher=20
priority than any SCHED_NORMAL tasks but lower priority than any true real=
=20
time tasks. The default cpu limit for iso tasks was changed to 80% (Note th=
is=20
is set to 0 by default on the cks patchset so server admins would explicitl=
y=20
set this only if desired).

 -isobatch_ionice2.diff
 +iso_idleprio_ionice.patch
 -vm-mapped.diff
 +vm-mapped-1.diff
 -vm-background_scan-1.diff
 -mm-highmem_fix_background_scan.patch
 +mm-background_scan.patch
 -mm-prio_dependant_scan.patch
 -mm-batch_prio.patch
 +mm-prio_dependant_scan-1.patch
 +mm-idleprio_prio.patch
Rename/resync/rollups

 -mm-swap_prefetch-28.patch
 -mm-swap_prefetch-tweaks.patch
 +mm-swap_prefetch-30.patch
 +sp-resume1.patch
 +mm-aggresive_swap_prefetch.patch
 +swsusp-post_resume_aggressive_swap_prefetch.patch
Updated to the latest swap prefetch code which will perform swap prefetchin=
g=20
if low priority tasks are running. This also adds the optional "use once"=20
feature of aggressive swap prefetching, and makes swsusp use that setting o=
n=20
resume from disk which improves dramatically the immediate interactivity of=
 a=20
machine just after resume. See Documentation/sysctl/vm.txt for more info on=
=20
the tunable

 -2615ck7-version.patch
 +2.6.16-ck1-version.patch
Version update


=46ull patchlist:

sched-implement-smpnice.patch
sched-smpnice-apply-review-suggestions.patch
sched-smpnice-fix-average-load-per-run-queue-calculations.patch
sched-store-weighted-load-on-up.patch
sched-add-discrete-weighted-cpu-load-function.patch
sched-add-above-background-load-function.patch
sched-staircase14.2.patch
sched-generic_optims2.patch
schedrange-2.diff
sched-iso-4.1.patch
sched-idleprio-1.2.patch
defaultcfq.diff
iso_idleprio_ionice.patch
rt_ionice.diff
pdflush-tweaks.patch
hz-default_values.patch
hz-no_default_250.patch
mm-swap_prefetch-30.patch
vm-mapped-1.diff
vm-lots_watermark.diff
mm-background_scan.patch
mm-kswapd_inherit_prio-1.patch
mm-prio_dependant_scan-1.patch
mm-idleprio_prio.patch
sp-resume1.patch
mm-aggresive_swap_prefetch.patch
swsusp-post_resume_aggressive_swap_prefetch.patch
adaptive-readahead-11.patch
2.6.16-ck1-version.patch


Cheers,
Con

--nextPart1172027.hb6lSQLCQx
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.1 (GNU/Linux)

iD8DBQBEHofLZUg7+tp6mRURAkm3AKCCGtl//6Zj1D7i4d2sNKcwy/0x8ACfSC78
J77o+ohuJoQJQYkjdoMMx/s=
=aD+6
-----END PGP SIGNATURE-----

--nextPart1172027.hb6lSQLCQx--
