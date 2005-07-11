Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262137AbVGKQaV@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262137AbVGKQaV (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 11 Jul 2005 12:30:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262092AbVGKQ2c
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 11 Jul 2005 12:28:32 -0400
Received: from spc2-brig1-3-0-cust232.asfd.broadband.ntl.com ([82.1.142.232]:37311
	"EHLO ppgpenguin.kenmoffat.uklinux.net") by vger.kernel.org with ESMTP
	id S262100AbVGKQZv convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 11 Jul 2005 12:25:51 -0400
Date: Mon, 11 Jul 2005 17:25:48 +0100 (BST)
From: Ken Moffat <ken@kenmoffat.uklinux.net>
To: linux-kernel@vger.kernel.org
Subject: ondemand cpufreq ineffective in 2.6.12 ?
Message-ID: <Pine.LNX.4.58.0507111702410.2222@ppg_penguin.kenmoffat.uklinux.net>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=ISO-8859-15
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

 I've been using the ondemand governor on athlon64 winchesters for a few
weeks.  I've just noticed that in 2.6.12 the frequency is not
increasing under load, it remains at the lowest frequency.  This seems
to be down to something in 2.6.12-rc6, but I've seen at least one report
since then that ondemand works fine.  Anybody else seeing this problem ?

 Testcase: boot (my bootscripts set the governor to ondemand), set the
governor to ondemand, performance, powersave and untar a nice big
bzip2'd tarball (gcc-3.4.1) from an nfs mount. All using the config from
2.6.11.9 and defaults for new options.

kernel		2.6.11.9	2.6.12-rc5	2.6.12-rc6	2.6.12

ondemand	20.8 sec	21.3 sec	33.9 sec	34.1 sec
performance	21.3 sec	22.0 sec	22.6 sec	20.1 sec
powersave	32.4 sec	33.1 sec	33.6 sec	33.9 sec

I don't have confidence that the numbers are more repeatable than +/- 2
seconds on this, they just illustrate that ondemand used to give a
similar time to performance, but now doesn't.  Other intermediate and
later tests have been omitted for clarity, but 2.6.12.2 does show the
same problem.

Since 2.6.12-rc6, 'ondemand' appears to be still accepted (the echo to
scaling_governor returns 0, and the displayed frequency drops back if
I try going from performance to ondemand).

When ondemand appears to work properly, /proc/cpuinfo shows the speed
jumping to 2 GHz, then falling back to 1.8 after the untar ends, then
back to 1.0 GHz.  In the problem cases, the speed remains at 1GHz.

As far as I can see, nothing untoward shows in the logs.  Any
suggestions, please ?

Ken
-- 
 das eine Mal als Tragödie, das andere Mal als Farce

