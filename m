Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751314AbWESJfO@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751314AbWESJfO (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 19 May 2006 05:35:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751323AbWESJfO
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 19 May 2006 05:35:14 -0400
Received: from linux01.gwdg.de ([134.76.13.21]:28860 "EHLO linux01.gwdg.de")
	by vger.kernel.org with ESMTP id S1751314AbWESJfN (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 19 May 2006 05:35:13 -0400
Date: Fri, 19 May 2006 11:34:28 +0200 (MEST)
From: Jan Engelhardt <jengelh@linux01.gwdg.de>
To: linux-xfs@oss.sgi.com
cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: XFS write speed drop
Message-ID: <Pine.LNX.4.61.0605190047430.23455@yvahk01.tjqt.qr>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,


I have noticed that after an upgrade from 2.6.16-rcX -> 2.6.17-rc4, writes 
to one (hdc) xfs filesystem have become significantly slower (factor 6 to 
8), like if -o sync (or funky journal options on ext3) was on. Also, reads 
would stall until writes have completed. I would only expect such behavior 
when /proc/sys/vm/dirty_* are set to high values (like 95%, like I do on a 
notebook). hda remained fast.

It eventually turned out that it are the log barriers; hda does not support 
barriers and XFS gave a nice kernel message hint that pointed me to try out 
a mount flag. -o nobarrier makes it fast again.




Jan Engelhardt
-- 
