Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263189AbUKUA0m@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263189AbUKUA0m (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 20 Nov 2004 19:26:42 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263196AbUKUAYY
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 20 Nov 2004 19:24:24 -0500
Received: from dp.samba.org ([66.70.73.150]:40605 "EHLO lists.samba.org")
	by vger.kernel.org with ESMTP id S263203AbUKUAW6 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 20 Nov 2004 19:22:58 -0500
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <16799.57253.861765.512175@samba.org>
Date: Sun, 21 Nov 2004 11:21:57 +1100
To: Hans Reiser <reiser@namesys.com>
Cc: linux-kernel@vger.kernel.org,
       Reiserfs developers mail-list <Reiserfs-Dev@namesys.com>
Subject: Re: performance of filesystem xattrs with Samba4
In-Reply-To: <419F6D1F.10001@namesys.com>
References: <16797.41728.984065.479474@samba.org>
	<419E1297.4080400@namesys.com>
	<16798.31565.306237.930372@samba.org>
	<419ECAB5.10203@namesys.com>
	<16798.59519.63931.494579@samba.org>
	<419F6D1F.10001@namesys.com>
X-Mailer: VM 7.19 under Emacs 21.3.1
Reply-To: tridge@samba.org
From: tridge@samba.org
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hans,

A bit more information about the slowdown between runs (and eventual
lockup) with reiser4 that I reported in my last email.

I found that a umount/mount between runs solved the problem, leading
to a fairly consistent result and no lockup. I also found that running
a simple /bin/sync between runs solved the problem.

This implies to me that it is some in-memory structure that is the
culprit. I can't see anything obvious in /proc/slabinfo, but its been
a while since I've done any serious kernel development so maybe I just
don't know what to look for.

I also tried enabling the "strict sync" option in Samba4. This makes
the 1% flush operations in the load file map to fsync() instead of a
noop. This caused reiser4 to lockup almost immediately, with the same
symptoms as the previous lockups I reported (all smbd processes stuck
in D state). No oops messages or anything unusual in dmesg.

Cheers, Tridge
