Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267259AbSLEHmN>; Thu, 5 Dec 2002 02:42:13 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267253AbSLEHlL>; Thu, 5 Dec 2002 02:41:11 -0500
Received: from holomorphy.com ([66.224.33.161]:55688 "EHLO holomorphy")
	by vger.kernel.org with ESMTP id <S267255AbSLEHlE>;
	Thu, 5 Dec 2002 02:41:04 -0500
Date: Wed, 04 Dec 2002 23:48:27 -0800
From: wli@holomorphy.com
To: linux-kernel@vger.kernel.org
Cc: mingo@elte.hu
Subject: [pidhash] [0/4] patch series vs. 2.5.50-mm1
Message-ID: <0212042348.vaibscRdmcpcAbdcfb9d~c3c4bNczcIa15950@holomorphy.com>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: patchbomb 0.0.1
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a series of patches against 2.5.50-mm1. 
They primarily have to do with pidhashing mechanisms, converting
some less-important users to the new API and eliminating some
tasklist iterations not covered by the original pidhash patches.

These should apply to 2.5.50-CURRENT; 2.5.50-mm1 includes bk snapshots.

mm1-2.5.50-2 [1/4] Make __do_SAK() use for_each_task_pid().
	The tty invariant involving ->tty being strictly associated
	with ->session has long been established. This converts
	__do_SAK() to use the pidhashing instead of iteration over
	the global tasklist.
mm1-2.5.50-5 [2/4] cap_set_pg() uses do_each_thread() to search for
	tasks in a given pgrp; convert it to for_each_task_pid()
wli-2.5.50-3 [3/5] eliminate proc_fill_super() tasklist iteration by
	means of introducing a nr_processes() per-cpu counter.
wli-2.5.50-6 [4/4] make get_pid_list() scan the PID bitmap instead of
	the tasklist.

Tested on 16x/16GB NUMA-Q with up to 16384 distinct processes.


Bill
