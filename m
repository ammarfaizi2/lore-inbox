Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S284364AbRLCIvt>; Mon, 3 Dec 2001 03:51:49 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S284366AbRLCItg>; Mon, 3 Dec 2001 03:49:36 -0500
Received: from vasquez.zip.com.au ([203.12.97.41]:12050 "EHLO
	vasquez.zip.com.au") by vger.kernel.org with ESMTP
	id <S284799AbRLCFve>; Mon, 3 Dec 2001 00:51:34 -0500
Message-ID: <3C0B12C5.F8F05016@zip.com.au>
Date: Sun, 02 Dec 2001 21:51:01 -0800
From: Andrew Morton <akpm@zip.com.au>
X-Mailer: Mozilla 4.77 [en] (X11; U; Linux 2.4.17-pre1 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: "ext3-users@redhat.com" <ext3-users@redhat.com>,
        lkml <linux-kernel@vger.kernel.org>
Subject: ext3-0.9.16 against linux-2.4.17-pre2
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

An ext3 update which also applies to linux-2.4.16 is available at

	http://www.zip.com.au/~akpm/linux/ext3/

Quite a lot of miscellany here.  It would be appreciated if interested
parties could please test it in preparation for sending upstream.  Thanks.

Changelog:


- Merged several ext2 sync-up patches from Christoph Hellwig

- Drop the big kernel lock across the call to block_prepare_write.
  This was causing excessive contention on large SMP machines.  Thanks
  to Anton ("dbench") Blanchard for finding this.

- Fixed a couple of potential kmap leaks on error paths.

  There is some question whether the core kernel should be changed so
  that this is not necessary, but it is right for current kernels.

- Fixed bugs concerning the use of bit operations on 32 bit quantities,
  which could cause problems on 64-bit hardware.  Thanks davem.

- Fix failure to return EFBIG when an attempt is made to lengthen an
  ext3 file to more than the maximum file size via ftruncate().

- Current ext3 can cause an assertion failure and take down the machine
  when an I/O error is encountered while mapping journal blocks in
  preparation for writing to the journal.  Fix from Stephen turns the
  filesystem readonly when this occurs.

- ext3 is presently marking data dirty itself, which defeats the core
  kernel's dirty buffer balancing.  Take that out and let the generic
  layer mark the buffers dirty.

  This change, along with core kernel changes in 2.4.17-pre2 can
  potentially reduce system congestion under heavy write loads.

- Update Documentation/Changes to reflect requirement for e2fsprogs
  version (1.25)

- Update Documentation/Locking to describe the two address_space
  methods which ext3 introduced.
