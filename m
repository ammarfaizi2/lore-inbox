Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262553AbUKXIPe@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262553AbUKXIPe (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 24 Nov 2004 03:15:34 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261300AbUKXION
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 24 Nov 2004 03:14:13 -0500
Received: from dp.samba.org ([66.70.73.150]:59832 "EHLO lists.samba.org")
	by vger.kernel.org with ESMTP id S262531AbUKXILt (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 24 Nov 2004 03:11:49 -0500
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <16804.15883.954229.326178@samba.org>
Date: Wed, 24 Nov 2004 18:53:47 +1100
To: Andrew Morton <akpm@osdl.org>
Cc: adilger@clusterfs.com, linux-kernel@vger.kernel.org
Subject: Re: performance of filesystem xattrs with Samba4
In-Reply-To: <20041119162651.2d62a6a8.akpm@osdl.org>
References: <16797.41728.984065.479474@samba.org>
	<419E1297.4080400@namesys.com>
	<16798.31565.306237.930372@samba.org>
	<20041119162651.2d62a6a8.akpm@osdl.org>
X-Mailer: VM 7.19 under Emacs 21.3.1
Reply-To: tridge@samba.org
From: tridge@samba.org
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andrew,

You can call off your bsearch - I found the culprit.

For the 2.6.10-rc2 tests I was running with the patch from Andreas
that added large ext3 inode support (in order to also test the
ext3-256 case). For the -mm2 test I wasn't.

This patch was supposed to have no effect if large inodes were not
setup at mkfs time. Unfortunately it does have an affect as it also
removes the in-place xattr modification logic from
ext3_xattr_set_handle(), so every xattr set becomes the same as a
delete+create pair. In plain -rc2 and in -mm2 an xattr set of the same
size will be done in-place. As every xattr set is of the same size in
dbench3 this made a huge difference.

Sorry for the false alarm.

Cheers, Tridge
