Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264904AbUEYPGI@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264904AbUEYPGI (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 25 May 2004 11:06:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264898AbUEYPGI
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 25 May 2004 11:06:08 -0400
Received: from webbox24.server-home.net ([195.137.212.20]:28096 "EHLO
	webbox24.server-home.net") by vger.kernel.org with ESMTP
	id S264904AbUEYPFV (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 25 May 2004 11:05:21 -0400
Date: Tue, 25 May 2004 17:05:12 +0200
From: Walter Hofmann <walter.hofmann@mi.uni-erlangen.de>
To: linux-kernel@vger.kernel.org
Subject: Filesystem space accounting bug
Message-ID: <20040525150512.GE7195@secretlab.mine.nu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-GPG-Fingerprint: 91D7 2B68 786F 7A3D 18FF E168 EAF4 8754
X-GPG-Key: http://search.keyserver.net:11371/pks/lookup?search=0xDE547385&op=index
User-Agent: Mutt/1.5.6i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

I have a backup script which creates a filesystem image which is later 
written to DVD. It is created & loop-mounted with

 dd if=/dev/zero of=${DARIMAGE} bs=1024k count=4460 || exit 1
 mke2fs -F -b 4096 -m 0 -N 32 -O sparse_super -L BACKUP ${DARIMAGE} || exit 1
 sync
 mount /mnt/dar
 touch /mnt/dar/backup-stamp

Then I use the "dar" utility to create a single large file on this. I
believe, but have not checked, that dar writes the file linearly. dar is
instructed to stop writing to the filesystem before it reaches 4GB. 

However, recently, dar failed after approx. 3GB with ENOSPC. The 
filesystem was still mounted, so I could check that there really were 
only 3GB written to it. Still, I could not even create a 1 byte file on 
it, although there should be around 1GB free space left.

There were no error messages logged. I unmounted the image and ran 
e2fsck on it and it reported that the free block count in a number of 
groups on the filesystem was wrong. 

I'm using Linux 2.6.6. I tried to reproduce this, but now it works
again.

Walter
