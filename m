Return-Path: <linux-kernel-owner+willy=40w.ods.org-S265226AbUGVSub@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265226AbUGVSub (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 22 Jul 2004 14:50:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266894AbUGVSub
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 22 Jul 2004 14:50:31 -0400
Received: from pengo.systems.pipex.net ([62.241.160.193]:51688 "EHLO
	pengo.systems.pipex.net") by vger.kernel.org with ESMTP
	id S265226AbUGVSu3 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 22 Jul 2004 14:50:29 -0400
Date: Thu, 22 Jul 2004 19:49:11 +0100 (BST)
From: Tigran Aivazian <tigran@aivazian.fsnet.co.uk>
X-X-Sender: tigran@einstein.homenet
To: linux-kernel@vger.kernel.org
Subject: ext3 and SPEC SFS Run rules.
Message-ID: <Pine.LNX.4.44.0407221933520.2152-100000@einstein.homenet>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

I have a simple question --- does ext3 conform to the SPEC SFS Run rules 
with default mount options or does one need to force the correct 
behaviour by mounting in some "special" way?. Here is the URL for the 
rules:

  http://www.spec.org/sfs97r1/docs/runrules.html

In particular, the bit that is worrying me is:

  For NFS Version 3, the server adheres to the protocol specification. In 
  particular the requirement that for STABLE write requests and COMMIT 
  operations the NFS server must not reply to the NFS client before any 
  modified file system data or metadata, with the exception of access times, 
  are written to stable storage for that specific or related operation. 
  See RFC 1813, NFSv3 protocol specification for a definition of STABLE 
  and COMMIT for NFS write requests.

As far as I can see from nfsd source this means:

a) write with 'stable' flag set does a f_op->write() with O_SYNC.

b) COMMIT3 just means f_op->fsync().

So, the question is really --- do ext3 O_SYNC write and fsync require some 
special mount options to work _properly_ or are they fine by default?

Looking at ext3_sync_file() it seems OK by default.

However, looking at ext3 ->write() operation it seems to forcibly commit 
only if it is mounted with EXT3_MOUNT_JOURNAL_DATA option (or if it is not 
a regular file or if EXT3_JOURNAL_DATA_FL inode flag is set).

Therefore, it would seem that for ext3 to be valid for SPEC SFS 3.0 (or 
2.0) run one has to mount it with "data=journal". Please correct me if I 
am wrong in coming to this conclusion.

Kind regards
Tigran

