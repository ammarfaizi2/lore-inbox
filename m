Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262145AbVDRS0N@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262145AbVDRS0N (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 18 Apr 2005 14:26:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262157AbVDRS0M
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 18 Apr 2005 14:26:12 -0400
Received: from ms-smtp-03.texas.rr.com ([24.93.47.42]:50837 "EHLO
	ms-smtp-03-eri0.texas.rr.com") by vger.kernel.org with ESMTP
	id S262145AbVDRS0J (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 18 Apr 2005 14:26:09 -0400
Subject: dbench performance on cifs to Samba
From: Steve French <smfrench@austin.rr.com>
To: linux-kernel@vger.kernel.org, linux-cifs-client@lists.samba.org,
       samba-technical@lists.samba.org
Content-Type: text/plain
Message-Id: <1113846784.9898.10.camel@smfhome.smfdom>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.4 
Date: Mon, 18 Apr 2005 12:53:05 -0500
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

The recent changes in cifs have helped a lot with dbench performance.  
Mounting cifs version 1.33 (current development tree of cifs) to current
Samba 3 (loopback on same host, to eliminate most network adapter
effects) showed about a tenfold improvement over older cifs -

Running dbench version with 20 processes (mainline kernel 2.6.12-pre)
a) local jfs mount (as a sanity check)  gets about 30MB/sec
b) current cifs development tree version (version 1.33) to Samba server
on same box = 2.8MB/sec
(dbench starts faster, but memory presumably gets fragmented, and it
slows down to about 2.8MB steady state)
c) cifs from six months ago (version 1.26) = 0.27MB/sec
(it starts about 15% slower than current cifs then slows
way down presumably as memory gets fragmented)

This is big progress - 10x improvement and since dbench is heavily write
oriented I should have plenty of room to double the cifs performance
again (with the recent async readahead and writebehind patches still to
evaluate, and writev support still to add and a double copy in the read
path), even without having to optimize the Samba server side.  Obviosly
this is going to be slower over the network than local due to
duplication of inodes/caching and network & samba server delays - but I
would like to get within a factor of 3 of local performance under this
stress write case.   I also need to measure the NFSv3
performance over loopback to local nfsd server to see how
that compares with dbench on this test system.

