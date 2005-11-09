Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750825AbVKIONt@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750825AbVKIONt (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 9 Nov 2005 09:13:49 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750823AbVKIONt
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 9 Nov 2005 09:13:49 -0500
Received: from ns.ustc.edu.cn ([202.38.64.1]:47595 "EHLO mx1.ustc.edu.cn")
	by vger.kernel.org with ESMTP id S1750825AbVKIONs (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 9 Nov 2005 09:13:48 -0500
Message-Id: <20051109134938.757187000@localhost.localdomain>
Date: Wed, 09 Nov 2005 21:49:38 +0800
From: Wu Fengguang <wfg@mail.ustc.edu.cn>
To: linux-kernel@vger.kernel.org
Cc: Andrew Morton <akpm@osdl.org>
Subject: [PATCH 00/16] Adaptive read-ahead V7
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is the 7th version of adaptive read-ahead patch.

There are various code cleanups and polish ups:
- new tunable parameters: readahead_hit_rate/readahead_live_chunk
- support sparse sequential accesses
- delay look-ahead in laptop mode
- disable look-ahead for loopback file
- make mandatory thrashing protection more simple and robust
- attempt to improve responsiveness on large I/O request size

Support for sparse reads is disabled by default. One must increase
/proc/sys/vm/readahead_hit_rate to explicitly enable it. Please
refer to Documentation/sysctl/vm.txt for details.

Currently the linux kernel does not support inter-file read-ahead.
Tero Grundstr?m takes an intresting approach that achieves it: pack
a dir of small files into a loopback file with reiserfs filesystem, and
turn on sparse read support. But be prepared to waste some memory by
this way :(

For crazy laptop users who prefer aggressive read-ahead, here is the way:

# echo 10000 > /proc/sys/vm/readahead_ratio
# blockdev --setra 524280 /dev/hda      # this is the max possible value

Notes:
- It is still an untested feature.
- It is safer to use blockdev+fadvise to increase ra-max for a single file,
  which needs patching your movie player.
- Be sure to restore them to sane values in normal operations!

Regards,
Wu
