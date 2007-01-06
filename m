Return-Path: <linux-kernel-owner+w=401wt.eu-S1751396AbXAFNp1@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751396AbXAFNp1 (ORCPT <rfc822;w@1wt.eu>);
	Sat, 6 Jan 2007 08:45:27 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751397AbXAFNp1
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 6 Jan 2007 08:45:27 -0500
Received: from turing-police.cc.vt.edu ([128.173.14.107]:48798 "EHLO
	turing-police.cc.vt.edu" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751396AbXAFNp0 (ORCPT
	<RFC822;linux-kernel@vger.kernel.org>);
	Sat, 6 Jan 2007 08:45:26 -0500
Message-Id: <200701061344.l06DipYC003610@turing-police.cc.vt.edu>
X-Mailer: exmh version 2.7.2 01/07/2005 with nmh-1.2
To: Andrew Morton <akpm@osdl.org>,
       Venkatesh Pallipadi <venkatesh.pallipadi@intel.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: 2.6.20-rc3-mm1 - rewrite-lock-in-cpufreq-to-eliminate-cpufreq-hotplug-related-issues.patch
In-Reply-To: Your message of "Thu, 04 Jan 2007 22:02:00 PST."
             <20070104220200.ae4e9a46.akpm@osdl.org>
From: Valdis.Kletnieks@vt.edu
References: <20070104220200.ae4e9a46.akpm@osdl.org>
Mime-Version: 1.0
Content-Type: multipart/signed; boundary="==_Exmh_1168091091_3205P";
	 micalg=pgp-sha1; protocol="application/pgp-signature"
Content-Transfer-Encoding: 7bit
Date: Sat, 06 Jan 2007 08:44:51 -0500
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

--==_Exmh_1168091091_3205P
Content-Type: text/plain; charset=us-ascii

On Thu, 04 Jan 2007 22:02:00 PST, Andrew Morton said:
> 	ftp://ftp.kernel.org/pub/linux/kernel/people/akpm/patches/2.6/2.6.20-rc3/2.6.20-rc3-mm1/

One of these 3 patches:

rewrite-lock-in-cpufreq-to-eliminate-cpufreq-hotplug-related-issues.patch
rewrite-lock-in-cpufreq-to-eliminate-cpufreq-hotplug-related-issues-fix.patch
ondemand-governor-restructure-the-work-callback.patch

causes an oops in kref_put during early boot ("unable to handle paging
request at 00078"). 

Dell Latitude D820 laptop, Core2 T7200 with a 64-bit kernel.

Hand-copied trace of the oops:

kobject_put+0x19/0x1b
cpufreq_cpu_put+0xd/0x1e
cpufreq_get+0x45/0x51
handle_cpufreq_delayed_get+0x1e/0x41
run_workqueue+0x9c/0x14e
worker_thread+0x0/0x145
worker_thread+0x10e/0x145
default_wake_function+0x0/0xf
worker_thread+0x0/0x145
kthread+0x8/0x10b
schedule_tail+0x38/0xa1
child_rip+0xa/0x12
kthread+0x0/0x10b
child_rip+0x0/0x12

With the 3 listed patches plus:
ondemand-governor-use-new-cpufreq-rwsem-locking-in-work-callback.patch
reverted, the system boots OK.
This ring any bells?

--==_Exmh_1168091091_3205P
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.6 (GNU/Linux)
Comment: Exmh version 2.5 07/13/2001

iD8DBQFFn6fTcC3lWbTT17ARAuRAAKDvF1DsEhoD3EiAwB6srxfKRsB0RwCgojFt
6nljOf4UqZwx1zy/xqIzZQI=
=Vly7
-----END PGP SIGNATURE-----

--==_Exmh_1168091091_3205P--
