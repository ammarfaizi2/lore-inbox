Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965149AbVLODON@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965149AbVLODON (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 14 Dec 2005 22:14:13 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965152AbVLODON
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 14 Dec 2005 22:14:13 -0500
Received: from mail.suse.de ([195.135.220.2]:52174 "EHLO mx1.suse.de")
	by vger.kernel.org with ESMTP id S965149AbVLODON (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 14 Dec 2005 22:14:13 -0500
From: Neil Brown <neilb@suse.de>
To: Greg KH <greg@kroah.com>, linux-kernel@vger.kernel.org
Date: Thu, 15 Dec 2005 14:14:06 +1100
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <17312.57214.612405.261796@cse.unsw.edu.au>
Subject: sysfs question:  how to map major:minor to name under /sys
X-Mailer: VM 7.19 under Emacs 21.4.1
X-face: v[Gw_3E*Gng}4rRrKRYotwlE?.2|**#s9D<ml'fY1Vw+@XfR[fRCsUoP?K6bt3YD\ui5Fh?f
	LONpR';(ql)VM_TQ/<l_^D3~B:z$\YC7gUCuC=sYm/80G=$tt"98mr8(l))QzVKCk$6~gldn~*FK9x
	8`;pM{3S8679sP+MbP,72<3_PIH-$I&iaiIb|hV1d%cYg))BmI)AZ
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Hi,
 I have a question about sysfs related usage.

 Suppose I have a major:minor number for a block device - maybe from
 fstat of a filedescriptor I was given, or stat of a name in /dev.
 How do I find the directory in /sys/block that contains relevant
 information? 

 It seems to me that there is no direct way, and maybe there should
 be. (I can do a find of 'dev' file and compare, which is fine in a
 one-off shell script, but sub-optimal in general).

 The most obvious solution would be to have a directory somewhere full
 of symlinks:
        /sys/block_dev/8:0 -> ../block/sda
 or whatever.
 Is this reasonable?  Should I try it?

 The particular case that I am interested in involves md.
 In this case I can find the right /sys/block/mdX entry easily enough
 because I *know* how the names are generated.  However when a block
 device is added to an array, it gets an entry like
    /sys/block/md4/md/dev-sda
 I would like to be able to easily find that given just the
 information that 8:0 was added.
 If the above directory of symlinks existed, I could readlink the
 relevant entry, take the basename, and add "md/dev-" to front of
 that. 

 Comments?

NeilBrown
