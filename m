Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751273AbWCSCgy@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751273AbWCSCgy (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 18 Mar 2006 21:36:54 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751329AbWCSCfG
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 18 Mar 2006 21:35:06 -0500
Received: from ns.ustc.edu.cn ([202.38.64.1]:3011 "EHLO mx1.ustc.edu.cn")
	by vger.kernel.org with ESMTP id S1751345AbWCSCev (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 18 Mar 2006 21:34:51 -0500
Message-Id: <20060319023413.305977000@localhost.localdomain>
Date: Sun, 19 Mar 2006 10:34:13 +0800
From: Wu Fengguang <wfg@mail.ustc.edu.cn>
To: Andrew Morton <akpm@osdl.org>
Cc: linux-kernel@vger.kernel.org
Subject: [PATCH 00/23] Adaptive read-ahead V11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Mornings,

A fresh patch for a fresh new day, and wish you a good appetite ;)

Highlights in this release:
	- The patch series are heavily reworked.
	- The code is re-audited and made cleaner.
	- The old stock read-ahead logic is untouched and will always be
	  available; the new adaptive read-ahead logic will be presented as a
	  compile time selectable feature.

Why do we need this?
In short, the stock read-ahead logic does not cover many important I/O
applications. This patch series present linux users a new option. Please
refer to the first patch in this series for the new features.

Patches in the series:

[PATCH 01/23] readahead: kconfig options
[PATCH 02/23] radixtree: look-aside cache
[PATCH 03/23] radixtree: hole scanning functions
[PATCH 04/23] readahead: page flag PG_readahead
[PATCH 05/23] readahead: refactor do_generic_mapping_read()
[PATCH 06/23] readahead: refactor __do_page_cache_readahead()
[PATCH 07/23] readahead: insert cond_resched() calls
[PATCH 08/23] readahead: common macros
[PATCH 09/23] readahead: events accounting
[PATCH 10/23] readahead: support functions
[PATCH 11/23] readahead: sysctl parameters
[PATCH 12/23] readahead: min/max sizes
[PATCH 13/23] readahead: page cache aging accounting
[PATCH 14/23] readahead: state based method
[PATCH 15/23] readahead: context based method
[PATCH 16/23] readahead: other methods
[PATCH 17/23] readahead: call scheme
[PATCH 18/23] readahead: laptop mode
[PATCH 19/23] readahead: loop case
[PATCH 20/23] readahead: nfsd case
[PATCH 21/23] readahead: debug radix tree new functions
[PATCH 22/23] readahead: debug traces showing accessed file names
[PATCH 23/23] readahead: debug traces showing read patterns

Note that the last three patches are optional and only to help
early stage development.

Patches for stable kernels will soon be available at:
	http://www.vanheusden.com/ara/
Thanks to Folkert van Heusden for providing the free hosting!

Changelog
=========

V11  2006-03-19
- patchset rework
- add kconfig option to make the feature compile-time selectable
- improve radix tree scan functions
- fix bug of using smp_processor_id() in preemptible code
- avoid overflow in compute_thrashing_threshold()
- disable sparse read prefetching if (readahead_hit_rate == 1)
- make thrashing recovery a standalone function
- random cleanups

V10  2005-12-16
- remove delayed page activation
- remove live page protection
- revert mmap readaround to old behavior
- default to original readahead logic
- default to original readahead size
- merge comment fixes from Andreas Mohr
- merge radixtree cleanups from Christoph Lameter
- reduce sizeof(struct file_ra_state) by unnamed union
- stateful method cleanups
- account other read-ahead paths

V9  2005-12-3
- standalone mmap read-around code, a little more smart and tunable
- make stateful method sensible of request size
- decouple readahead_ratio from live pages protection
- let readahead_ratio contribute to ra_size grow speed in stateful method
- account variance of ra_size

V8  2005-11-25

- balance zone aging only in page relaim paths and do it right
- do the aging of slabs in the same way as zones
- add debug code to dump the detailed page reclaim steps
- undo exposing of struct radix_tree_node and uninline related functions
- work better with nfsd
- generalize accelerated context based read-ahead
- account smooth read-ahead aging based on page referenced/activate bits
- avoid divide error in compute_thrashing_threshold()
- more low lantency efforts
- update some comments
- rebase debug actions on debugfs entries instead of magic readahead_ratio values

V7  2005-11-09

- new tunable parameters: readahead_hit_rate/readahead_live_chunk
- support sparse sequential accesses
- delay look-ahead if drive is spinned down in laptop mode
- disable look-ahead for loopback file
- make mandatory thrashing protection more simple and robust
- attempt to improve responsiveness on large read-ahead size

V6  2005-11-01

- cancel look-ahead in laptop mode
- increase read-ahead limit to 0xFFFF pages

V5  2005-10-28

- rewrite context based method to make it clean and robust
- improved accuracy of stateful thrashing threshold estimation
- make page aging equal to the number of code pages scanned
- sort out the thrashing protection logic
- enhanced debug/accounting facilities

V4  2005-10-15

- detect and save live chunks on page reclaim
- support database workload
- support reading backward
- radix tree lookup look-aside cache

V3  2005-10-06

- major code reorganization and documention
- stateful estimation of thrashing-threshold
- context method with accelerated grow up phase
- adaptive look-ahead
- early detection and rescue of pages in danger
- statitics data collection
- synchronized page aging between zones

V2  2005-09-15

- delayed page activation
- look-ahead: towards pipelined read-ahead

V1  2005-09-13

Initial release which features:
        o stateless (for now)
        o adapts to available memory / read speed
        o free of thrashing (in theory)

And handles:
        o large number of slow streams (FTP server)
	o open/read/close access patterns (NFS server)
        o multiple interleaved, sequential streams in one file
	  (multithread / multimedia / database)

Cheers,
Wu Fengguang
--
Dept. Automation                University of Science and Technology of China
