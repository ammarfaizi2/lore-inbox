Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262372AbSJ0MHG>; Sun, 27 Oct 2002 07:07:06 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262373AbSJ0MHG>; Sun, 27 Oct 2002 07:07:06 -0500
Received: from zero.aec.at ([193.170.194.10]:52484 "EHLO zero.aec.at")
	by vger.kernel.org with ESMTP id <S262372AbSJ0MHF>;
	Sun, 27 Oct 2002 07:07:05 -0500
Date: Sun, 27 Oct 2002 13:13:18 +0100
From: Andi Kleen <ak@muc.de>
To: linux-kernel@vger.kernel.org
Subject: New nanosecond stat patch for 2.5.44
Message-ID: <20021027121318.GA2249@averell>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Move time_t members in struct stat to struct timespec and allow subsecond
timestamps for files.  Too big to post on the list, because it edits
a lot of file systems and drivers in a straight forward way.

This is required for reliable "make" on fast computers.

File systems that support nsec storage are currently: XFS, JFS, NFSv3
(if the filesystem on the server supports it), VFAT (not quite nanosecond),
CIFS (unit in 100ns which is above what linux supports), SMBFS (for 
newer servers)

This is proposed for 2.6. 

Changes against the last version:
- Now always take xtime_lock when accessing the whole of xtime
- Port to 2.5.44
- New filesystems supported: CIFS, AFS

ftp://ftp.firstfloor.org/pub/ak/v2.5/nsec-2.5.44-1.bz2


-Andi
