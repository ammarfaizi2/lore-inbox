Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262501AbVAUUvu@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262501AbVAUUvu (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 21 Jan 2005 15:51:50 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262468AbVAUUtd
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 21 Jan 2005 15:49:33 -0500
Received: from [83.146.86.58] ([83.146.86.58]:59660 "EHLO mail.ward.six")
	by vger.kernel.org with ESMTP id S262501AbVAUUqv (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 21 Jan 2005 15:46:51 -0500
Date: Sat, 22 Jan 2005 01:46:46 +0500
From: Denis Zaitsev <zzz@anda.ru>
To: linux-kernel@vger.kernel.org
Cc: linux-net@vger.kernel.org, nfs@lists.sourceforge.net
Subject: [BUG] Onboard Ethernet Pro 100 on a SMP box: a very strange errors
Message-ID: <20050122014646.A1038@natasha.ward.six>
Mail-Followup-To: linux-kernel@vger.kernel.org, linux-net@vger.kernel.org,
	nfs@lists.sourceforge.net
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

The long story is:

There is a Dual-processor Intel Server Board STL2 with two P-III/800
and an onboard Intel 82557-based ethernet card.  The box has all the
/usr and nearly all of the /var filesystems mounted over NFS.  And the
box works for months without any problems around the NFS.  So, I think
that the ethernet card just works fine.

But I have some enigmatic problems when I copying _some_ files from an
NFS to the local fs: the process is freezes on the middle.

1) Only _some_ files can't be copied.  There are:

   gcc-testsuite-3.4-20041217.tar.bz2

   krb5-1.3.6-signed.tar

   X430src-1.tgz

   They are the well-known sources from the well-known ftp and web
   places.  And I don't think that it's the full list, just the files
   for which I have met the problem.

2) Only _these_ files can't be copied.  Any other is copied plainly.

3) These files _never_ can be copied.

4) The copy process always freezes at the same place (per file - the
   each file has its own place).

In short: it's a list of files, on which the copying is always freezes
and always freezes exactly the same way.  And there are no any
exception - I have freezeng each time.

The freezing is forever.  The freezed process is in D state, its
/proc/PID/wchan contains page_sync.  Each such process eats 1.0 from
/proc/loadavg.  And the process can't be killed by any signal.

Then, copying by dd bs=1024 ... just succeeds.  After that cp succeeds
too - I think it's because of caching.

Then, there is no visual correlation with the size of the file.  So,
it seems that the content of the file is involved...  But it is
enigmatic.

The NIC works fine all the other time, so there no suspicions about
hardware problems.

The other NIC - 3C905 PCI external card doesn't show the problem - all
the files are just copied.

An either driver for Ethernet Pro 100 - e100 or eepro100 - show the
same result, but eepro100 logs periodicaly:

        eth0: wait_for_cmd_done timeout!

e100 logs nothing.

So, it doesn't ever look like a driver bug...

The kernels tested: 2.6.8.1, 2.6.9, 2.6.10.

GLIBC used: 2.3.2.
