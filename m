Return-Path: <linux-kernel-owner+willy=40w.ods.org-S265951AbUFDTc5@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265951AbUFDTc5 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 4 Jun 2004 15:32:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265953AbUFDTc5
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 4 Jun 2004 15:32:57 -0400
Received: from dirac.phys.uwm.edu ([129.89.57.19]:1665 "EHLO
	dirac.phys.uwm.edu") by vger.kernel.org with ESMTP id S265951AbUFDTcy
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 4 Jun 2004 15:32:54 -0400
Date: Fri, 4 Jun 2004 14:32:48 -0500 (CDT)
From: Bruce Allen <ballen@gravity.phys.uwm.edu>
To: Rick Jansen <rick@rockingstone.nl>
cc: John Bradford <john@grabjohn.com>, Daniel Egger <de@axiros.com>,
       linux-kernel@vger.kernel.org
Subject: Re: DriveReady SeekComplete Error
In-Reply-To: <20040604141804.GF1684@web1.rockingstone.nl>
Message-ID: <Pine.GSO.4.21.0406041427390.12514-100000@dirac.phys.uwm.edu>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Rick,

> smartctl version 5.30 Copyright (C) 2002-4 Bruce Allen
> Home page is http://smartmontools.sourceforge.net/

Some comments below.

> Device Model:     Maxtor 6Y120P0
> Serial Number:    Y43XXY5E
> Firmware Version: YAR41BW0
> Device is:        In smartctl database [for details use: -P show]
> ATA Version is:   7

You can use selective self-tests on this drive.  You'll need smartmontools
version 5.31 or greater.  This will help you pin down the bad LBAs
quickly.

> Self-test execution status:      ( 118)	The previous self-test completed having
> 					the read element of the test failed.

You have some unreadable disk sectors.

> 					Selective Self-test supported.

This is a very useful disk feature!

>   5 Reallocated_Sector_Ct   0x0033   252   252   063    Pre-fail  Always       -       15

Your disk has already reallocated 15 bad sectors.

> 197 Current_Pending_Sector  0x0008   252   252   000    Old_age   Offline      -       13
> 198 Offline_Uncorrectable   0x0008   252   252   000    Old_age   Offline      -       1

There are 13 unreadable disk sectors that the OS has tried to access, and
one additional unreadable disk sector found in an off-line scan.

> Error 440 occurred at disk power-on lifetime: 843 hours
>   When the command that caused the error occurred, the device was in an unknown state.
> 
>   After command completion occurred, registers were:
>   ER ST SC SN CL CH DH
>   -- -- -- -- -- -- --
>   40 51 03 77 dd 8b ed  Error: UNC 3 sectors at LBA = 0x0d8bdd77 = 227270007

This is a typical read that failed at LBA 227270007.

> SMART Self-test log structure revision number 1
> Num  Test_Description    Status                  Remaining  LifeTime(hours)  LBA_of_first_error
> # 1  Short offline       Completed: read failure       60%       839         0x0d8bdd7c
> # 2  Short offline       Completed: read failure       60%       816         0x0d8bdd7c
> # 3  Short offline       Completed: read failure       60%       805         0x0d8bdd7c

See http://smartmontools.sourceforge.net/BadBlockHowTo.txt for info on how
to locate and force reallocation of the bad sectors.  When you are done
you should be able to run a long self-test (-t long) with no errors found.
You can use selective self-tests (-t select,M-N) to help locate the bad
sectors.

Bruce

