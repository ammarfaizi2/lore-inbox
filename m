Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261895AbUKJGEm@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261895AbUKJGEm (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 10 Nov 2004 01:04:42 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261902AbUKJGEl
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 10 Nov 2004 01:04:41 -0500
Received: from main.gmane.org ([80.91.229.2]:58773 "EHLO main.gmane.org")
	by vger.kernel.org with ESMTP id S261898AbUKJGE1 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 10 Nov 2004 01:04:27 -0500
X-Injected-Via-Gmane: http://gmane.org/
To: linux-kernel@vger.kernel.org
From: "Alexander E. Patrakov" <patrakov@ums.usu.ru>
Subject: Re: [PATCH] Partitioned loop devices, support for 127 Partitions on SATA, IDE and SCSI
Date: Wed, 10 Nov 2004 11:05:46 +0500
Message-ID: <cmsb12$pr1$1@sea.gmane.org>
References: <419199A3.3050806@gmx.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7Bit
X-Complaints-To: usenet@sea.gmane.org
X-Gmane-NNTP-Posting-Host: inet.ycc.ru
User-Agent: KNode/0.8.1
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Carl-Daniel Hailfinger wrote:

> Hi,
> 
> having seen the problems people have when switching from traditional IDE
> drivers to libata if they have more than 15 partitions, I decided to do
> something against it. With this patch (and recreating /dev/loop* nodes)
> it is possible to support up to 127 partitions per loop device
> regardless what the underlying device supports. It works for me
> and has the added bonus that it will be in compatibility mode as long
> as you don't specify the max_part parameter.
> 
> To make migration to the new loop version easy, the new default loop
> behaviour is exactly the same as the old one, so you should not notice
> any breakage. However, if you decide to enable partitioned loop support
> by specifying the max_part parameter, loop devices will have major
> number 240, currently reserved for local/experimental use, and loopN
> will have the minor range [N*max_part, (N+1)*max_part-1].
> 
> For even easier migration, the partition table will NOT be read by
> default on losetup so you even can use unpartitioned loop devices when
> being no longer in compat mode. If you want to activate partitions for
> /dev/loopN, just issue "blockdev --rereadpt /dev/loopN" and the
> partitions will magically appear in /sys/block/loopN/.

Why not just use EVMS? Partition code is supposed to be moved to userspace
anyway.

-- 
Alexander E. Patrakov

