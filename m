Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261500AbUE0CCF@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261500AbUE0CCF (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 26 May 2004 22:02:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261505AbUE0CCF
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 26 May 2004 22:02:05 -0400
Received: from gateway-1237.mvista.com ([12.44.186.158]:57339 "EHLO
	av.mvista.com") by vger.kernel.org with ESMTP id S261500AbUE0CCD
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 26 May 2004 22:02:03 -0400
Date: Wed, 26 May 2004 19:02:01 -0700
From: Todd Poynor <tpoynor@mvista.com>
To: linux-kernel@vger.kernel.org
Subject: BLKFLSBUF on ramdisks
Message-ID: <20040527020201.GC7176@slurryseal.ddns.mvista.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

The BLKFLSBUF ioctl has a different meaning on ramdisks than on other
block devices: the memory for the ramdisk is freed (whereas cached
blocks are flushed to the device for most other devices, which obviously
would be a NOP for ramdisks).  At least one command, freeramdisk of
BusyBox, expects this behavior.  If certain other commands that issue
BLKFLSBUF are inadvertently run on a ramdisk device (as in a script that
previously tested fine on other devices) then the filesystem is
basically corrupted instead of the normally expected result.  For
example, badblocks or e2fsck -F.

While this can be initially alarming, it is easily figured out and
avoided in the future (no one really needs to check bad blocks or
filesystem integrity on a ramdisk, and I'd assume other uses of the
ioctl would fall into a similar category).  The two incompatible
definitions of the ioctl do seem unfortunate, however, and I figured I'd
ask here in case there's any interest in changing this situation; if so,
I will gladly help, thanks,

-- 
Todd
