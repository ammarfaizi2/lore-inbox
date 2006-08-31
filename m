Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932336AbWHaOyP@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932336AbWHaOyP (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 31 Aug 2006 10:54:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751638AbWHaOyN
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 31 Aug 2006 10:54:13 -0400
Received: from e35.co.us.ibm.com ([32.97.110.153]:25746 "EHLO
	e35.co.us.ibm.com") by vger.kernel.org with ESMTP id S1751616AbWHaOyL
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 31 Aug 2006 10:54:11 -0400
Message-ID: <44F6F80F.1000202@cs.columbia.edu>
Date: Thu, 31 Aug 2006 10:54:07 -0400
From: Shaya Potter <spotter@cs.columbia.edu>
User-Agent: Thunderbird 1.5.0.5 (Windows/20060719)
MIME-Version: 1.0
To: linux-fsdevel@vger.kernel.org
CC: linux-kernel@vger.kernel.org, unionfs@fsl.cs.sunysb.edu
Subject: bug in nfs in 2.6.18-rc5?
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

so I'm trying to use unionfs, cachefs and nfs, as cachefs is 2.6.18-rc5 
right now, thats what I'm testing, but I hit an oops.

basically unionfs's lookup does a "lookup_one_len()" on the underlying fs.

lookup_one_len() calls __lookup_hash()

__lookup_hash() is called as "__lookup_hash(&this, base, NULL)"

now that NULL is important.  that's the nameidata entry of __lookup_hash()

__lookup_hash() ends up calling the underlying fs's lookup op, i.e. 
nfs_lookup()

nfs_lookup() calls nfs_reval_fsid(nd->mnt, dir, &fhandle, &fattr);

see the bug? :)

This doesn't seem like a unionfs bug, as one should be able to call 
lookup_one_len() on an NFS fs.
