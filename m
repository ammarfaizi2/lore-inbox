Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266881AbUBGMK4 (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 7 Feb 2004 07:10:56 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266886AbUBGMK4
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 7 Feb 2004 07:10:56 -0500
Received: from disk.smurf.noris.de ([192.109.102.53]:41355 "EHLO
	server.smurf.noris.de") by vger.kernel.org with ESMTP
	id S266881AbUBGMKz (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 7 Feb 2004 07:10:55 -0500
To: linux-kernel@vger.kernel.org
Path: not-for-mail
From: Matthias Urlichs <smurf@smurf.noris.de>
Newsgroups: smurf.list.linux.kernel
Subject: BUG: 2.6.2-mm1: destroy_workqueue
Date: Sat, 07 Feb 2004 12:49:05 +0100
Organization: {M:U} IT Consulting
Message-ID: <pan.2004.02.07.11.49.04.872088@smurf.noris.de>
NNTP-Posting-Host: kiste.smurf.noris.de
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Trace: server.smurf.noris.de 1076154545 12689 192.109.102.35 (7 Feb 2004 11:49:05 GMT)
X-Complaints-To: smurf@noris.de
NNTP-Posting-Date: Sat, 7 Feb 2004 11:49:05 +0000 (UTC)
User-Agent: Pan/0.14.2.91 (As She Crawled Across the Table)
X-Face: '&-&kxR\8+Pqalw@VzN\p?]]eIYwRDxvrwEM<aSTmd'\`f#k`zKY&P_QuRa4EG?;#/TJ](:XL6B!-=9nyC9o<xEx;trRsW8nSda=-b|;BKZ=W4:TO$~j8RmGVMm-}8w.1cEY$X<B2+(x\yW1]Cn}b:1b<$;_?1%QKcvOFonK.7l[cos~O]<Abu4f8nbL15$"1W}y"5\)tQ1{HRR?t015QK&v4j`WaOue^'I)0d,{v*N1O
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I had a crash when unmounting a reiserfs at shutdown time.

Apparently, destroy_workqueue() inlines list_del(), which checks for

148             BUG_ON(entry->prev->next != entry);

This is a problem when entry->prev is NULL.  :-/

Call trace, copied off the screen by hand:
destroy_workqueue+0x30
do_journal_release+0x4e
journal_mark_dirty+0x18c
journal_release+0x10
reiserfs_put_super+0x24

Built using gcc version 3.3.2 (Debian), no other patches.

