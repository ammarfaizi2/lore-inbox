Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S316875AbSEVGvM>; Wed, 22 May 2002 02:51:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S316876AbSEVGvL>; Wed, 22 May 2002 02:51:11 -0400
Received: from ds217-115-141-141.dedicated.hosteurope.de ([217.115.141.141]:9743
	"EHLO ds217-115-141-141.dedicated.hosteurope.de") by vger.kernel.org
	with ESMTP id <S316875AbSEVGvL>; Wed, 22 May 2002 02:51:11 -0400
Date: Wed, 22 May 2002 08:51:11 +0200
From: Jochen Suckfuell <jo-lkml@suckfuell.net>
To: linux-kernel@vger.kernel.org
Subject: 2.4.19pre*: IO statistics in /proc/partitions corrupt
Message-ID: <20020522085111.C20554@ds217-115-141-141.dedicated.hosteurope.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

The statistics patch included in the kernel since 2.4.19pre still has a
bug leading to negative values for the "running io's" value, called
ios_in_flight internally.
This leads to completely wrong results for many other values computed
from this one and renders the statistics utterly unusable.

The problem appears on IDE and SCSI drives, affecting values for
partitions and also whole disks. It seems to be most significant when
using a RAID (which is often the case on servers with much disk access,
where statistics are important!):

8    16   35842048 sdb 12637435 51727 101513266 103991890 19600590
	 14721219 274592008 988438640 **-100** 250563400 315019978
8    32   35842048 sdc 8438773 75872 68117130 62271950 13147577
	 9950844 184838544 550059270 **-32** 247111750 1119563006

Here sdb and sdc are each a RAID1 pair, on a Dual-CPU running
2.4.19-pre8-ac4.

Does anyone have an idea where a starting disk io might not be counted
correctly?

Bye
Jochen

-- 
Jochen Suckfuell  ---  http://www.suckfuell.net/jochen/  ---
