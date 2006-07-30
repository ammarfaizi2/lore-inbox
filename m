Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750997AbWG3Ian@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750997AbWG3Ian (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 30 Jul 2006 04:30:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751089AbWG3Ian
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 30 Jul 2006 04:30:43 -0400
Received: from caramon.arm.linux.org.uk ([217.147.92.249]:29194 "EHLO
	caramon.arm.linux.org.uk") by vger.kernel.org with ESMTP
	id S1750997AbWG3Ian (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 30 Jul 2006 04:30:43 -0400
Date: Sun, 30 Jul 2006 09:30:34 +0100
From: Russell King <rmk+lkml@arm.linux.org.uk>
To: Linus Torvalds <torvalds@osdl.org>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: Linux v2.6.18-rc3
Message-ID: <20060730083034.GA11360@flint.arm.linux.org.uk>
Mail-Followup-To: Linus Torvalds <torvalds@osdl.org>,
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
References: <Pine.LNX.4.64.0607292320490.4168@g5.osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.64.0607292320490.4168@g5.osdl.org>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

There's something weird in this release - object
0021aad5db43ccc0d0356f2f5e4e28446c8b983a appears to change size (or it
does for me.)

Searching 'linux-2.6/.git/' and 'linux-2.6-mmc/.git/' for common objects and hardlinking them...
ERROR: File sizes are not the same, cannot relink linux-2.6/.git/objects/00/21aad5db43ccc0d0356f2f5e4e28446c8b983a to linux-2.6-mmc/.git/objects/00/21aad5db43ccc0d0356f2f5e4e28446c8b983a.
rmk@dyn-67:[git]:<1022> vdir linux-*/.git/objects/00/21aad5db43ccc0d0356f2f5e4e28446c8b983a
-r--r--r-- 1 rmk rmk 6891 Jul 25 19:57 linux-2.6/.git/objects/00/21aad5db43ccc0d0356f2f5e4e28446c8b983a
-r--r--r-- 1 rmk rmk 6862 Jul 25 20:29 linux-2.6-mmc/.git/objects/00/21aad5db43ccc0d0356f2f5e4e28446c8b983a
-r--r--r-- 1 rmk rmk 6862 Jul 25 20:30 linux-2.6-rmk/.git/objects/00/21aad5db43ccc0d0356f2f5e4e28446c8b983a
-r--r--r-- 1 rmk rmk 6862 Jul 25 20:30 linux-2.6-serial/.git/objects/00/21aad5db43ccc0d0356f2f5e4e28446c8b983a
rmk@dyn-67:[git]:<1025> md5sum linux-*/.git/objects/00/21aad5db43ccc0d0356f2f5e4e28446c8b983a
5607142215895de1d71abbff28e3d096  linux-2.6/.git/objects/00/21aad5db43ccc0d0356f2f5e4e28446c8b983a
3af2b33663ce5c53a336bd31d4b469e0  linux-2.6-mmc/.git/objects/00/21aad5db43ccc0d0356f2f5e4e28446c8b983a
3af2b33663ce5c53a336bd31d4b469e0  linux-2.6-rmk/.git/objects/00/21aad5db43ccc0d0356f2f5e4e28446c8b983a
3af2b33663ce5c53a336bd31d4b469e0  linux-2.6-serial/.git/objects/00/21aad5db43ccc0d0356f2f5e4e28446c8b983a

The first tree (linux-2.6) was fetched using rsync from a tree which also
had been obtained via rsync:

src@flint:[linux-2.6]:<1015> vdir .git/objects/00/21aad5db43ccc0d0356f2f5e4e28446c8b983a
-r--r--r--  1 src src 6891 Jul 25 19:57 .git/objects/00/21aad5db43ccc0d0356f2f5e4e28446c8b983a
src@flint:[linux-2.6]:<1016> md5sum .git/objects/00/21aad5db43ccc0d0356f2f5e4e28446c8b983a
5607142215895de1d71abbff28e3d096  .git/objects/00/21aad5db43ccc0d0356f2f5e4e28446c8b983a

And on hera:

[rmk@hera torvalds]$ vdir linux-2.6.git/objects/00/21aad5db43ccc0d0356f2f5e4e28446c8b983a
-r--r--r--  1 torvalds torvalds 6891 Jul 22 00:45 linux-2.6.git/objects/00/21aad5db43ccc0d0356f2f5e4e28446c8b983a
[rmk@hera torvalds]$ md5sum linux-2.6.git/objects/00/21aad5db43ccc0d0356f2f5e4e28446c8b983a
5607142215895de1d71abbff28e3d096  linux-2.6.git/objects/00/21aad5db43ccc0d0356f2f5e4e28446c8b983a

So the act of git fetch-ing from dyn-67's linux-2.6 tree to linux-2.6-*
appears to have changed this git object.

git-1.4.0, Fedora Core 5.

The actual contents of the object (git-cat-file blob
0021aad5db43ccc0d0356f2f5e4e28446c8b983a) appears to be identical
however.

-- 
Russell King
 Linux kernel    2.6 ARM Linux   - http://www.arm.linux.org.uk/
 maintainer of:  2.6 Serial core
