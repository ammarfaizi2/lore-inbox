Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S315929AbSFYVl7>; Tue, 25 Jun 2002 17:41:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S315941AbSFYVl6>; Tue, 25 Jun 2002 17:41:58 -0400
Received: from c16410.randw1.nsw.optusnet.com.au ([210.49.25.29]:13559 "EHLO
	mail.chubb.wattle.id.au") by vger.kernel.org with ESMTP
	id <S315929AbSFYVl6>; Tue, 25 Jun 2002 17:41:58 -0400
From: Peter Chubb <peter@chubb.wattle.id.au>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <15640.58277.974804.976284@wombat.chubb.wattle.id.au>
Date: Wed, 26 Jun 2002 07:41:57 +1000
To: linux-kernel@vger.kernel.org
Subject: Real large block device patch now available
X-Mailer: VM 7.04 under 21.4 (patch 8) "Honest Recruiter" XEmacs Lucid
X-Face: .slVUC18R`%{j(W3ztQe~*ATzet;h`*Wv33MZ]*M,}9AP<`+C=U)c#NzI5vK!0^d#6:<_`a
 {#.<}~(T^aJ~]-.C'p~saJ7qZXP-$AY==]7,9?WVSH5sQ}g3,8j>u%@f$/Z6,WR7*E~BFY.Yjw,H6<
 F.cEDj2$S:kO2+-5<]afj@kC!:uw\(<>lVpk)lPZs+2(=?=D/TZPG+P9LDN#1RRUPxdX
Comments: Hyperbole mail buttons accepted, v04.18.
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Hi,
	There's a new patch against 2.5.24 available at
http://www.gelato.unsw.edu.au/patches/2.5.24-lbd-patch

or can be pulled from bk://gelato.unsw.edu.au:2023/

With this patch large scsi discs are detected and sized correctly; and
it's possible create block devices using raid up to 16TB on 32-bit
platforms, and as large as you like on 64-bit platforms.

Tested at present on i386 and ia64.

The patch:
    -- uses sector_t instead of int where blocks or sectors are
counted
	(sector_t is either unsigned long  or u64 depending on
CONFIG_LBD)
   -- fixes bogus sign extensions when calculating scsi capacity
   -- modifies the partitioning code so that EFI GPT at least can
      specify partitions using 64-bit numbers.
   -- Fixes the loop device to allow large backing files or devices,
      and to fail gracefully if the backing file is too large.

--
Dr Peter Chubb				    peterc@gelato.unsw.edu.au
You are lost in a maze of BitKeeper repositories, all almost the same.

