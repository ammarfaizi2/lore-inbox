Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932218AbWAZDtK@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932218AbWAZDtK (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 25 Jan 2006 22:49:10 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932224AbWAZDtK
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 25 Jan 2006 22:49:10 -0500
Received: from [202.53.187.9] ([202.53.187.9]:15339 "EHLO
	cust8446.nsw01.dataco.com.au") by vger.kernel.org with ESMTP
	id S932218AbWAZDtJ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 25 Jan 2006 22:49:09 -0500
From: Nigel Cunningham <nigel@suspend2.net>
Subject: [ 00/23] [Suspend2] Freezer Upgrade Patches
To: linux-kernel@vger.kernel.org
Message-Id: <20060126034518.3178.55397.stgit@localhost.localdomain>
Date: Thu, 26 Jan 2006 13:45:26 +1000 (EST)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi everyone.

This set of patches represents the freezer upgrade patches from Suspend2.

The key features of this changeset are:

- Use of Christoph Lameter's todo list notifiers, which help with SMP
  cleanness.
- Splitting the freezing of kernel and userspace processes. Freezing
  currently suffers from a race because userspace processes can be
  submitting work for kernel threads, thereby stopping them from
  responding to freeze messages in a timely manner. The freezer can
  thus give up when it doesn't really need to. (This is not normally
  a problem only because load is not usually high).
- The use of bdev freezing to ensure filesystems are properly frozen,
  thereby increasing the integrity of on-disk data in the case where
  a resume doesn't occur. This is also helpful in the case of Suspend2,
  where we don't atomically copy all memory, instead writing LRU pages
  separately.

Signed-off-by: Nigel Cunningham <nigel@suspend2.net>

--
Nigel Cunningham   nigel at suspend2 dot net   http://suspend2.net
