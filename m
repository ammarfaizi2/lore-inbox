Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261185AbVBCW6i@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261185AbVBCW6i (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 3 Feb 2005 17:58:38 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262757AbVBCWxm
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 3 Feb 2005 17:53:42 -0500
Received: from aun.it.uu.se ([130.238.12.36]:12469 "EHLO aun.it.uu.se")
	by vger.kernel.org with ESMTP id S261738AbVBCWmx (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 3 Feb 2005 17:42:53 -0500
From: Mikael Pettersson <mikpe@user.it.uu.se>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <16898.43219.133783.439910@alkaid.it.uu.se>
Date: Thu, 3 Feb 2005 23:42:27 +0100
To: sct@redhat.com, akpm@osdl.org, adilger@clusterfs.com
CC: linux-kernel@vger.kernel.org
Subject: ext3 extended attributes refcounting wrong?
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I believe there is some accounting error in the ext3 code
for the case when CONFIG_EXT3_FS_XATTR is not selected.

Whenever any one of my development boxes triggers an fsck
at boot because some file system, usually /, has been mounted
sufficiently many times, an inconsistency error occurs:

Extended attribute block N has reference count M, should be M'.

where M' is much less than M. As I drop into single-user and
run fsck, it finds at lot occurrences of this error, followed by:

Block bitmap differences ...

and then:

Free blocks count wrong

(always too low, i.e. I have more free blocks than the fs records).

This occurs on all my boxes, with different CPUs (x86/x86-64/ppc)
and different chipsets (Intel, Promise, VIA, Apple), and basically
the only commonalities are:
- they dual boot the most recent 2.4 and 2.6 kernels, and I switch often
- all file systems are ext3
- all XATTR stuff is disabled

/Mikael
