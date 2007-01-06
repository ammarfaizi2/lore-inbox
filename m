Return-Path: <linux-kernel-owner+w=401wt.eu-S1751210AbXAFH2P@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751210AbXAFH2P (ORCPT <rfc822;w@1wt.eu>);
	Sat, 6 Jan 2007 02:28:15 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751203AbXAFH2C
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 6 Jan 2007 02:28:02 -0500
Received: from smtp.ustc.edu.cn ([202.38.64.16]:59140 "HELO ustc.edu.cn"
	rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with SMTP
	id S1751204AbXAFH1k (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 6 Jan 2007 02:27:40 -0500
Message-ID: <368068420.16860@ustc.edu.cn>
X-EYOUMAIL-SMTPAUTH: wfg@mail.ustc.edu.cn
Message-Id: <20070106072626.911640026@mail.ustc.edu.cn>
User-Agent: quilt/0.45-1
Date: Sat, 06 Jan 2007 15:26:26 +0800
From: Fengguang Wu <wfg@mail.ustc.edu.cn>
To: Andrew Morton <akpm@osdl.org>
Cc: linux-kernel@vger.kernel.org
Subject: [PATCH 0/6] adaptive readahead update
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andrew,

Here're more readahead updates. They go like:

--- broken-out/series	2007-01-05 13:13:19.000000000 +0800
+++ patches/series	2007-01-05 22:11:37.000000000 +0800
@@ -985,13 +985,17 @@
 readahead-sysctl-parameters.patch
 readahead-sysctl-parameters-use-ctl_unnumbered.patch
 readahead-sysctl-parameters-fix.patch
+readahead-sysctl-parameters-set-readahead_hit_rate-1.patch
 readahead-min-max-sizes.patch
+readahead-min-max-sizes-remove-get_readahead_bounds.patch
 readahead-state-based-method-aging-accounting.patch
 readahead-state-based-method-routines.patch
 readahead-state-based-method.patch
 readahead-context-based-method.patch
 readahead-context-based-method-locking-fix.patch
 readahead-context-based-method-locking-fix-2.patch
+readahead-context-based-method-update-ra_min.patch
+readahead-context-based-method-remove-readahead_ratio.patch
 readahead-initial-method-guiding-sizes.patch
 readahead-initial-method-thrashing-guard-size.patch
 readahead-initial-method-user-recommended-size.patch
@@ -1001,9 +1005,10 @@
 readahead-call-scheme.patch
 readahead-call-scheme-ifdef-fix.patch
 readahead-call-scheme-build-fix.patch
+readahead-call-scheme-remove-get_readahead_bounds.patch
-readahead-laptop-mode.patch
 readahead-loop-case.patch
 readahead-nfsd-case.patch
+readahead-nfsd-case-remove-ra_min.patch
 readahead-nfsd-case-fix.patch
 readahead-nfsd-case-fix-uninitialized-ra_min-ra_max.patch
 readahead-turn-on-by-default.patch


Summary of changes
==================

- change default value of readahead_hit_rate to 1
- remove defered readahead for laptop mode
- remove get_readahead_bounds() and update ra_min of the context method
- remove use of readahead_ratio in the context method


readahead-laptop-mode.patch
===========================

Please remove it for now.

It defers readahead when the laptop is spinned down, which may cause unpleasant
delays if the user is watching movie and the media player do not cache enough
data in userland.


readahead-nfsd-case-remove-ra_min.patch
=======================================

Please fold it immediately to avoid a compile error when bisecting.


readahead-insert-cond_resched-calls.patch
readahead-remove-size-limit-on-read_ahead_kb.patch                                                                      
readahead-remove-size-limit-of-max_sectors_kb-on-read_ahead_kb.patch                                                    
====================================================================

It may be better to push them to mainline _before_ the other patches.

They solve some issues on large readahead size.
The main users are currently some laptop mode users.

Regards,
Fengguang Wu
--
