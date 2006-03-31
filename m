Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751301AbWCaJsx@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751301AbWCaJsx (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 31 Mar 2006 04:48:53 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751303AbWCaJsx
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 31 Mar 2006 04:48:53 -0500
Received: from unthought.net ([212.97.129.88]:4876 "EHLO unthought.net")
	by vger.kernel.org with ESMTP id S1751301AbWCaJsx (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 31 Mar 2006 04:48:53 -0500
Date: Fri, 31 Mar 2006 11:48:51 +0200
From: Jakob Oestergaard <jakob@unthought.net>
To: linux-kernel@vger.kernel.org
Subject: NFS client (10x) performance regression 2.6.14.7 -> 2.6.15
Message-ID: <20060331094850.GF9811@unthought.net>
Mail-Followup-To: Jakob Oestergaard <jakob@unthought.net>,
	linux-kernel@vger.kernel.org
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Hi guys,

I just found out... Installed 2.6.16.1 (32-bit) on a spanking new dual
opteron 275 (dual-core) machine, and saw that my link jobs were taking
ages.

I narrowed it down a bit - these are the kernels I have tested:
2.6.13.5:  Good
2.6.14.7:  Good
2.6.15:    Poor
2.6.15.7:  Poor
2.6.16.1:  Poor

Sequential NFS I/O is good on all kernels. Only "ld" shows the problem.

On 2.6.14.7, I can run a large link job creating a 60 MB executable in
15.6 seconds wall-clock time.

On 2.6.15, the same link job takes 2 minutes 28 seconds.

This is almost 10 *times* longer.

Testing with tiobench, I can see no notable difference between the
kernels (!)   It seems that this is very specific to ld.  I am using GNU
ld version 2.15.

The NFS client mounts the working directory using NFS v3 over UDP with
default (32k) rsize/wsize.

Since this machine is not in production yet, I can experiment with
kernel patches on it - I would like to try and narrow this down even
further - any suggestions as to which patches to exclude/include will be
greatly appreciated.

Note; I did double-check all the common problems (ethernet problems,
mount options, ...).

-- 

 / jakob

