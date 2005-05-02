Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261452AbVEBR5o@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261452AbVEBR5o (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 2 May 2005 13:57:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261350AbVEBRzS
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 2 May 2005 13:55:18 -0400
Received: from clock-tower.bc.nu ([81.2.110.250]:4078 "EHLO
	lxorguk.ukuu.org.uk") by vger.kernel.org with ESMTP id S261484AbVEBRyG
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 2 May 2005 13:54:06 -0400
Subject: Re: How to flush data to disk reliably?
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: Grzegorz Kulewski <kangur@polcom.net>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
In-Reply-To: <Pine.LNX.4.62.0505021503470.11701@alpha.polcom.net>
References: <Pine.LNX.4.62.0505021503470.11701@alpha.polcom.net>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Message-Id: <1115056355.10370.37.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6 (1.4.6-2) 
Date: Mon, 02 May 2005 18:52:38 +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> I am asking how to flush the data from these logs to disk. I know of 
> several methods:
> 1. open with O_SYNC,
> 2. sync(2),
> 3. fsync,
> 4. fdatasync,
> 5. msync (if they are mmaped).
> 
> Which of these are best and most reliable for (a/b) and for (IDE/SCSI)? 

For scsi the combination of O_SYNC and ext3 or fsync and ext3 should be
reliable. fdatasync doesn't write back all the metadata so depending on
the use may not be sufficient. FAT based fs's I believe you need a
current kernel for full O_SYNC behaviour.

> What are differences between them? 

See the manual pages and/or standard.
 
> other precautions that I should be aware of? What about write caches? Are 
> write barriers implemented (on IDE and SATA/SCSI) or should I turn caches 
> off?

SCSI shoule be fine, IDE turn off the write cache.


