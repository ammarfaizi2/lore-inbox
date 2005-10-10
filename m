Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751253AbVJJVUU@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751253AbVJJVUU (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 10 Oct 2005 17:20:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751252AbVJJVUU
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 10 Oct 2005 17:20:20 -0400
Received: from ppsw-0.csi.cam.ac.uk ([131.111.8.130]:24216 "EHLO
	ppsw-0.csi.cam.ac.uk") by vger.kernel.org with ESMTP
	id S1751250AbVJJVUS (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 10 Oct 2005 17:20:18 -0400
X-Cam-SpamDetails: Not scanned
X-Cam-AntiVirus: No virus found
X-Cam-ScannerInfo: http://www.cam.ac.uk/cs/email/scanner/
Date: Mon, 10 Oct 2005 22:20:07 +0100 (BST)
From: Anton Altaparmakov <aia21@cam.ac.uk>
To: Glauber de Oliveira Costa <glommer@br.ibm.com>
cc: linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org,
       ext2-devel@lists.sourceforge.net, hirofumi@mail.parknet.co.jp,
       linux-ntfs-dev@lists.sourceforge.net, aia21@cantab.net,
       hch@infradead.org, viro@zeniv.linux.org.uk,
       mikulas@artax.karlin.mff.cuni.cz, akpm@osdl.org
Subject: Re: [PATCH] Use of getblk differs between locations
In-Reply-To: <20051010204517.GA30867@br.ibm.com>
Message-ID: <Pine.LNX.4.64.0510102217200.6247@hermes-1.csi.cam.ac.uk>
References: <20051010204517.GA30867@br.ibm.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Mon, 10 Oct 2005, Glauber de Oliveira Costa wrote:
> I've just noticed that the use of sb_getblk differs between locations
> inside the kernel. To be precise, in some locations there are tests
> against its return value, and in some places there are not.
> 
> According to the comments in __getblk definition, the tests are not
> necessary, as the function always return a buffer_head (maybe a wrong
> one),

If you had read the source code rather than just the comments you would 
have seen that this is not true.  It can return NULL (see 
fs/buffer.c::__getblk_slow()).  Certainly I would prefer to keep the 
checks in NTFS, please.  They may only be good for catching bugs but I 
like catching bugs rather than segfaulting due to a NULL dereference.

Best regards,

	Anton
-- 
Anton Altaparmakov <aia21 at cam.ac.uk> (replace at with @)
Unix Support, Computing Service, University of Cambridge, CB2 3QH, UK
Linux NTFS maintainer / IRC: #ntfs on irc.freenode.net
WWW: http://linux-ntfs.sf.net/ & http://www-stu.christs.cam.ac.uk/~aia21/
