Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751289AbVKMDwW@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751289AbVKMDwW (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 12 Nov 2005 22:52:22 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751296AbVKMDwW
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 12 Nov 2005 22:52:22 -0500
Received: from freelists-180.iquest.net ([206.53.239.180]:463 "EHLO
	turing.freelists.org") by vger.kernel.org with ESMTP
	id S1751289AbVKMDwW (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 12 Nov 2005 22:52:22 -0500
From: John Madden <weez@freelists.org>
To: linux-kernel@vger.kernel.org
Subject: ReiserFS: clm-2201: last flush, clm-2200: last commit
Date: Sat, 12 Nov 2005 22:52:21 -0500
User-Agent: KMail/1.8.3
MIME-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200511122252.21366.weez@freelists.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Following a crash last night (suspect buggy Dell BIOS, since upgraded), I'm 
now seeing thousands of: 

ReiserFS: dm-5: warning: clm-2200: last commit 2158066944, current 2158066945
ReiserFS: dm-5: warning: clm-2201: last flush 2158065946, current 2158065947

This is on both 2.6.12.5 (last night) and 2.4.14.1 as of tonight.  fsck 
reports no corruption and I have no reason other than these warnings to 
believe there is any, but this is (obviously) troubling nonetheless.  The 
relevant code is in fs/reiserfs/journal.c.  

For the flush case: 
        if (journal->j_last_flush_id != 0 &&
            (jl->j_trans_id - journal->j_last_flush_id) != 1) {
                reiserfs_warning(s, "clm-2201: last flush %lu, current %lu",
                                 journal->j_last_flush_id, jl->j_trans_id);
        }

And for the commit case:
        if (journal->j_last_commit_id != 0 &&
            (jl->j_trans_id - journal->j_last_commit_id) != 1) {
                reiserfs_warning(s, "clm-2200: last commit %lu, current %lu",
                                 journal->j_last_commit_id, jl->j_trans_id);
        }

The filesystem is mounted notail, no options with the journal.   Any hints as 
to what's up?  Should I expect corruption here?

John




-- 
# John Madden  weez@freelists.org: http://www.nerdarium.com
# FreeLists: Free mailing lists for all: http://www.freelists.org
# Linux, Apache, Perl and C: All the best things in life are free!
