Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751122AbVIFXd0@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751122AbVIFXd0 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 6 Sep 2005 19:33:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751065AbVIFXd0
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 6 Sep 2005 19:33:26 -0400
Received: from serv01.siteground.net ([70.85.91.68]:25066 "EHLO
	serv01.siteground.net") by vger.kernel.org with ESMTP
	id S1751033AbVIFXdZ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 6 Sep 2005 19:33:25 -0400
Date: Tue, 6 Sep 2005 16:33:22 -0700
From: Ravikiran G Thirumalai <kiran@scalex86.org>
To: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
Cc: linux-ide@vger.kernel.org, linux-kernel@vger.kernel.org,
       "Shai Fultheim (Shai@scalex86.org)" <shai@scalex86.org>,
       Alok Kataria <alokk@calsoftinc.com>
Subject: [patch 0/4] ide: Break ide_lock to per-hwgroup lock
Message-ID: <20050906233322.GA3642@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.4.2.1i
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - serv01.siteground.net
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [0 0] / [47 12]
X-AntiAbuse: Sender Address Domain - scalex86.org
X-Source: 
X-Source-Args: 
X-Source-Dir: 
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

The following patchset breaks down the global ide_lock to per-hwgroup lock.
We have taken the following approach.

1. Move the hwif tuning code from probe_hwif to ideprobe_init, after
hwif_init so that hwgroups are present for all the hwifs when the tune
routines for the hwifs are invoked (patch 1)

2. Change the core ide code to use hwgroup->lock instead of ide_lock.
Deprecate ide_lock (patch 2)

3. Change the host controllers to use hwgroup->lock (patch 3)

4. Change host controller drivers to use per driver lock instead of ide_lock
where needed or hwgroup->lock on case by case basis. This can be done 
incrementally for various controllers and we will have working code between 
patches -- this is done now for piix controller only.  Eventually, 
we can change all controllers to remove ide_lock

Thanks to Bartlomiej for comments and suggestions.

Patchset follows.  Patchset tested on a smp box with a piix controller.

Thanks,
Kiran
