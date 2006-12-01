Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1162022AbWLAWBj@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1162022AbWLAWBj (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 1 Dec 2006 17:01:39 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1162053AbWLAWBj
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 1 Dec 2006 17:01:39 -0500
Received: from mtaout01-winn.ispmail.ntl.com ([81.103.221.47]:52028 "EHLO
	mtaout01-winn.ispmail.ntl.com") by vger.kernel.org with ESMTP
	id S1162022AbWLAWBi convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 1 Dec 2006 17:01:38 -0500
Date: Fri, 1 Dec 2006 22:01:34 +0000
From: Ken Moffat <zarniwhoop@ntlworld.com>
To: linux-kernel@vger.kernel.org
Subject: CD oddities with VIA PATA
Message-ID: <20061201220134.GA22909@deepthought.linux.bogus>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
User-Agent: Mutt/1.5.11
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

 I'm testing 2.6.19 on this box, and I thought I might as well try
out the Parallel ATA driver for the CD/DVD writer (VIA) since the
disk is already handled by libata.

 So far, I've found two oddities - 

(i.) cdparanoia (9.8) works for root, but for a user it complains
that the ioctl isn't cooked and refuses to run.  For test purposes,
it runs ok for a user as suid root, but I imagine that increases
the likelihood of unspeakable things happening.  (Fortunately, I
don't have a dachshund)

(ii.) As a user, I burned a small (28MB) CD using dvdrecord from
dvdrtools-0.3.1, and on a different box I can mount it (using
ide-cd) and it seems fine.  On this box I can't mount it -

ken@ac30 ~ $mount /media/cdrom/
mount: wrong fs type, bad option, bad superblock on /dev/cdrom,
       missing codepage or other error
       In some cases useful info is found in syslog - try
       dmesg | tail  or so

 The syslog shows

Dec  1 21:17:41 ac30 kernel: attempt to access beyond end of device
Dec  1 21:17:41 ac30 kernel: sr0: rw=0, want=68, limit=4
Dec  1 21:17:41 ac30 kernel: isofs_fill_super: bread failed, dev=sr0, iso_blknum=16, block=16

 The iso is the gparted-livecd-0.3.1-1.iso.

 The problem might be specific to small CDs, I can mount others (41M
of data and more) without difficulty and all of the likely NLS options
are selected as =y in my config.

Ken
-- 
das eine Mal als Tragödie, das andere Mal als Farce
