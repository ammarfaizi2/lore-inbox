Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S270484AbTHCVWZ (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 3 Aug 2003 17:22:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S271184AbTHCVWZ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 3 Aug 2003 17:22:25 -0400
Received: from mail.gondor.com ([212.117.64.182]:9481 "EHLO moria.gondor.com")
	by vger.kernel.org with ESMTP id S270484AbTHCVWY convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 3 Aug 2003 17:22:24 -0400
Date: Sun, 3 Aug 2003 23:22:22 +0200
From: Jan Niehusmann <jan@gondor.com>
To: linux-kernel@vger.kernel.org
Subject: Block bitmap differences
Message-ID: <20030803212222.GA2528@gondor.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: 8BIT
X-Request-PGP: http://gondor.com/key.asc
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

After cleaning up some other file system errors, I got the following
problem: e2fsck finished (apparently) successfully. But to be sure, I
ran another e2fsck, which still complained about block bitmap
differences:

Block bitmap differences:  +(107151362--107151397) +(107151603--107184127) [...]
Fix<y>? yes

/dev/vg1/pool1: ***** FILE SYSTEM WAS MODIFIED *****
/dev/vg1/pool1: 195275/28581920 files (3.9% non-contiguous), 122154001/142753792 blocks

To be honest, the file system was mounted read-only at that moment. Now
I umounted the filesystem, and mounted it again read-only (I do not want
to leave users without read access to the files, if possible).

But then, another e2fsck gave the same errors again:

bigspace2:~# ./e2fsck.static -f /dev/vg1/pool1 
e2fsck 1.34 (25-Jul-2003)
/dev/vg1/pool1 is mounted.  

WARNING!!!  Running e2fsck on a mounted filesystem may cause
SEVERE filesystem damage.

Do you really want to continue (y/n)? yes

Pass 1: Checking inodes, blocks, and sizes
Pass 2: Checking directory structure
Pass 3: Checking directory connectivity
Pass 4: Checking reference counts
Pass 5: Checking group summary information
Block bitmap differences:  +(107151362--107151397) +(107151603--107184127) [...]
Fix<y>? yes

How can that be? Bug in e2fsck? Or does the kernel write to the
filesystem even though it's mounted read-only? (this is stock linux
2.4.21)

Jan
