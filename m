Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751203AbWBWNFX@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751203AbWBWNFX (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 23 Feb 2006 08:05:23 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751206AbWBWNFW
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 23 Feb 2006 08:05:22 -0500
Received: from mail.bmlv.gv.at ([193.171.152.37]:48346 "EHLO mail.bmlv.gv.at")
	by vger.kernel.org with ESMTP id S1751203AbWBWNFV (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 23 Feb 2006 08:05:21 -0500
From: "Ph. Marek" <philipp.marek@bmlv.gv.at>
To: linux-kernel@vger.kernel.org
Subject: ramfs and directory modification time
Date: Thu, 23 Feb 2006 14:05:03 +0100
User-Agent: KMail/1.9.1
MIME-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200602231405.04091.philipp.marek@bmlv.gv.at>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello everybody,

I believe that I found a problem regarding ramfs and directory modification 
times.



Observe:
	$ /tmp# mkdir newdir
	$ /tmp# mount -t ramfs none newdir
	$ /tmp# cd newdir/
	$ /tmp/newdir# mkdir sub
	$ /tmp/newdir# cd sub
	$ /tmp/newdir/sub# ls -la --full-time
	total 0
	drwxr-xr-x 2 root root 0 2006-02-23 14:01:37.573655160 +0100 .
	drwxr-xr-x 3 root root 0 2006-02-23 14:01:33.221316816 +0100 ..
	$ /tmp/newdir/sub# touch a-new-file
	$ /tmp/newdir/sub# ls -la --full-time
	total 0
	drwxr-xr-x 2 root root 0 2006-02-23 14:01:37.573655160 +0100 .
	drwxr-xr-x 3 root root 0 2006-02-23 14:01:33.221316816 +0100 ..
	-rw-r--r-- 1 root root 0 2006-02-23 14:01:48.019067216 +0100 a-new-file

On a tmpfs or other (disk-based) filesystems (ext3) it works correctly.
Is that a design wish, that ramfs is kept as simple as possible?

Nevertheless I believe that should be fixed, as everything that relies on the 
directory mtime won't work on an ramfs.


This is 2.6.26-rc4, btw, on x86.


Please CC me as I'm not subscribed (although I surely will have a look in the 
archives, too).


Regards,

Phil
