Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262890AbVCMFFc@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262890AbVCMFFc (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 13 Mar 2005 00:05:32 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262885AbVCMFFT
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 13 Mar 2005 00:05:19 -0500
Received: from pat.uio.no ([129.240.130.16]:50819 "EHLO pat.uio.no")
	by vger.kernel.org with ESMTP id S263166AbVCMFEq (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 13 Mar 2005 00:04:46 -0500
Subject: Re: [CHECKER] inconsistent NFS stat cache (NFS on ext3, 2.6.11)
From: Trond Myklebust <trond.myklebust@fys.uio.no>
To: Junfeng Yang <yjf@stanford.edu>
Cc: nfs@lists.sourceforge.net,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       ext2-devel@lists.sourceforge.net, mc@cs.Stanford.EDU
In-Reply-To: <Pine.GSO.4.44.0503120335160.12085-100000@elaine24.Stanford.EDU>
References: <Pine.GSO.4.44.0503120335160.12085-100000@elaine24.Stanford.EDU>
Content-Type: text/plain
Date: Sun, 13 Mar 2005 00:04:27 -0500
Message-Id: <1110690267.24123.7.camel@lade.trondhjem.org>
Mime-Version: 1.0
X-Mailer: Evolution 2.0.4 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

lau den 12.03.2005 Klokka 03:56 (-0800) skreiv Junfeng Yang:
> Hi,
> 
> We checked NFS on top of ext3 using FiSC (our file system model checker)
> and found a case where NFS stat cache can contain inconsistent entries.
> 
> Basically, to trigger this inconsistency, just do the following steps:
> 1. create a file A1, write a few bytes to it, so A1 is 4 words
> 2. create a hard link A2, pointing to A1
> 3. stat on A2. A2's size is 4 words
> 4. truncate A1 to a larger size, write a few bytes at the end. now it's
> 1031 words.
> 5. stat on A2. it's size is still 4 words, which should be 1031 words
> 
> We have a test case to re-create this warning.  You can download it at
> http://fisc.stanford.edu/bug16/crash.c.  It includes some sudo commands
> to mount nfs partitions, which you might want to change according to your
> local settings.
> 
> cat /etc/exports shows:
> /mnt/sbd0-export          localhost(rw,sync)
> /mnt/sbd1-export          localhost(rw,sync)
> 
> Let me know if you have any problems reproducing the warning. We'd
> appreciate any confirmations/clarifications.
> 

This is a known problem. Turn off the (default - grrr) subtree checking
export option on the server, and it will all work properly. The subtree
checking option violates the NFS standards for filehandle generation in
so many ways, that it isn't even funny.

Cheers,
  Trond

-- 
Trond Myklebust <trond.myklebust@fys.uio.no>

