Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265002AbSKANcm>; Fri, 1 Nov 2002 08:32:42 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265003AbSKANcj>; Fri, 1 Nov 2002 08:32:39 -0500
Received: from c17928.thoms1.vic.optusnet.com.au ([210.49.249.29]:51587 "EHLO
	localhost.localdomain") by vger.kernel.org with ESMTP
	id <S265002AbSKANci> convert rfc822-to-8bit; Fri, 1 Nov 2002 08:32:38 -0500
Content-Type: text/plain;
  charset="us-ascii"
From: Con Kolivas <conman@kolivas.net>
To: linux kernel mailing list <linux-kernel@vger.kernel.org>
Subject: autoregulated timeslice added to 2.4.19-ck performance patchset
Date: Sat, 2 Nov 2002 00:37:15 +1100
User-Agent: KMail/1.4.3
MIME-Version: 1.0
Content-Transfer-Encoding: 8BIT
Message-Id: <200211020037.37457.conman@kolivas.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

I've added a small patch to the -ck patchset to make it up to ck11

The Hz is set to 1000 (from RML's patch)
I've added my own patch which varies the timeslice duration. It is 
autoregulated by decreasing the duration according to the number of running 
processes or in the presence of uninterruptible processes. The range of 
timeslices is now huge depending on demand.

The diff against ck10 (a small patch) is available here:
http://kernel.kolivas.net

Cheers,
Con

P.S. A brief summary of my patch is here :

(from sched.c)
MIN_TIMESLICE 		( 1 * timeslice_multiplier )
MAX_TIMESLICE		( 30 * timeslice_multiplier )

(from timer.c)
timeslice_multiplier autoregulated according to number of running tasks.  
Starts at 32 and is divided by nr_running()^2. Will drop to 1 if there are 
any nr_uninterruptible(). SMP is decreased proportionately less 
(1/smp_num_cpus).
-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.0 (GNU/Linux)

iD8DBQE9woOPF6dfvkL3i1gRAr61AJ9qW85GQmljDAPKAT4zN9GeeJB3CwCfVxIf
Vek+JTftg8FW+hTjkdjR9H0=
=DvQf
-----END PGP SIGNATURE-----

