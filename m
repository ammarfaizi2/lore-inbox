Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932068AbWAJRoC@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932068AbWAJRoC (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 10 Jan 2006 12:44:02 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932084AbWAJRoC
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 10 Jan 2006 12:44:02 -0500
Received: from gold.veritas.com ([143.127.12.110]:2845 "EHLO gold.veritas.com")
	by vger.kernel.org with ESMTP id S932068AbWAJRoA (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 10 Jan 2006 12:44:00 -0500
Date: Tue, 10 Jan 2006 17:44:32 +0000 (GMT)
From: Hugh Dickins <hugh@veritas.com>
X-X-Sender: hugh@goblin.wat.veritas.com
To: Ingo Molnar <mingo@elte.hu>
cc: linux-kernel@vger.kernel.org
Subject: i386 FRAME_POINTER needs DEBUG_MUTEXES
Message-ID: <Pine.LNX.4.61.0601101718570.2942@goblin.wat.veritas.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
X-OriginalArrivalTime: 10 Jan 2006 17:43:59.0248 (UTC) FILETIME=[6FC93100:01C6160D]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I find the 2.6.15-git6 i386 CONFIG_FRAME_POINTER=y doesn't work unless
CONFIG_DEBUG_MUTEXES=y, because of the __mutex_fastpath jumps to fail_fn
(giving two pushes of %ebp to one pop).  Whereas x86_64 __mutex_fastpaths
use calls and work with FRAME_POINTER=y.  Whether i386 deserves asm mods
rather than Kconfigery to force one from other, I've no strong instinct.

Hugh
