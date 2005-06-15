Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261589AbVFOWJU@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261589AbVFOWJU (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 15 Jun 2005 18:09:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261628AbVFOWHr
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 15 Jun 2005 18:07:47 -0400
Received: from pih-relay04.plus.net ([212.159.14.131]:10669 "EHLO
	pih-relay04.plus.net") by vger.kernel.org with ESMTP
	id S261589AbVFOWFz (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 15 Jun 2005 18:05:55 -0400
Date: Wed, 15 Jun 2005 23:05:54 +0100
From: Simon Richard Grint <rgrint@compsoc.man.ac.uk>
To: linux-kernel@vger.kernel.org
Subject: arch/i386/boot/video.S hang
Message-ID: <20050615220554.GA1911@srg.demon.co.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


I'm trying to upgrade an old AMD K6-2 machine (aladdin bios/gigabyte GA-5AX
motherboard, latest version of the bios) to 2.6.11. Unfortunately kernels later 
than 2.6.9 hang very early in the boot process just after the vga= mode selection, 
but before the kernel announces "uncompressing linux".

I have narrowed the problem down to the store_edid function in
arch/i386/boot/video.S where the edid block is obtained and stored before
entering protected mode.  The exact patch which seems to cause me problems
is http://www.ussg.iu.edu/hypermail/linux/kernel/0409.3/1786.html

Storing the edid block at 0x140 causes this machine to hang, whereas backing
this patch out and instead using 0x440 (or even 0x160) seems to work fine.

Is this problem just because of an old and buggy bios or is there another
reason?

Thanks for your help

sr

