Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264395AbTK0APT (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 26 Nov 2003 19:15:19 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264400AbTK0APS
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 26 Nov 2003 19:15:18 -0500
Received: from note.orchestra.cse.unsw.EDU.AU ([129.94.242.24]:48588 "HELO
	note.orchestra.cse.unsw.EDU.AU") by vger.kernel.org with SMTP
	id S264395AbTK0APP (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 26 Nov 2003 19:15:15 -0500
From: Neil Brown <neilb@cse.unsw.edu.au>
To: Linus Torvalds <torvalds@osdl.org>
Date: Thu, 27 Nov 2003 11:15:10 +1100
Message-ID: <16325.16910.697589.124844@notabene.cse.unsw.edu.au>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
cc: linux-kernel@vger.kernel.org
Subject: md/raid devices don't show up in /proc/partitions in 2.6 :-(
X-Mailer: VM 7.18 under Emacs 21.3.1
X-face: [Gw_3E*Gng}4rRrKRYotwlE?.2|**#s9D<ml'fY1Vw+@XfR[fRCsUoP?K6bt3YD\ui5Fh?f
	LONpR';(ql)VM_TQ/<l_^D3~B:z$\YC7gUCuC=sYm/80G=$tt"98mr8(l))QzVKCk$6~gldn~*FK9x
	8`;pM{3S8679sP+MbP,72<3_PIH-$I&iaiIb|hV1d%cYg))BmI)AZ
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


I just noticed that md devices do not show up in /proc/partitions in
2.6.

I realise that they don't actually have partitions and are just 'whole
devices', but other whole devices do appear in /proc/partitions (Along
with their partitions if any).

This seems to be a regression from 2.4 where md devices do appear in
/proc/partitions.

The cause appears to be a patch from 'torvalds' some 15 months ago
(in version 1.36 for drivers/block/genhd.c) which has the comment:

      Avoid confusion "mount" and "fsck" - don't show things like
      floppies and CD's in /proc/partitions.

It excluded devices that cannot be partitioned, and devices with zero
size from /proc/partitions.

The 'zero size' possibly makes sense (2.4 excludes those), but I would
like to register a vote against excluding devices without partitions,
as this excluded 'md' devices and I would really like them to be
included.


Is there really a good reason for this?  How badly does mount get
confused? and is that not the fault of mount?

NeilBrown
