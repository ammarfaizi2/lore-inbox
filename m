Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261572AbULISBT@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261572AbULISBT (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 9 Dec 2004 13:01:19 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261567AbULISBT
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 9 Dec 2004 13:01:19 -0500
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:19861 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id S261575AbULISA3
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 9 Dec 2004 13:00:29 -0500
Date: Wed, 8 Dec 2004 19:32:20 -0200
From: Marcelo Tosatti <marcelo.tosatti@cyclades.com>
To: tvrtko.ursulin@sophos.com
Cc: Linus Torvalds <torvalds@osdl.org>, Andrew Morton <akpm@osdl.org>,
       Kernel Mailing List <linux-kernel@vger.kernel.org>,
       urban@teststation.com
Subject: Re: [BUG ?] smbfs open always succeeds
Message-ID: <20041208213220.GE2348@dmt.cyclades>
References: <OF3F6FA812.9B17E2B3-ON80256F64.005AD229-80256F64.005AFF55@sophos.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <OF3F6FA812.9B17E2B3-ON80256F64.005AD229-80256F64.005AFF55@sophos.com>
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Dec 08, 2004 at 04:33:56PM +0000, tvrtko.ursulin@sophos.com wrote:
> >Not saying that smbfs is right, just explaining that it _might_ be right.
> >
> >Urban, did you see the thread?
> 
> Urban seems to be MIA. Or on a long holiday. :) What shall we do?

It seems Andrew applied this to the -mm tree. 

smb_file_open-retval-fix.patch

From: <tvrtko.ursulin@sophos.com>

Correctly propagate the return value from smb_open().

Signed-off-by: Andrew Morton <akpm@osdl.org>
---

 25-akpm/fs/smbfs/file.c |    2 +-
 1 files changed, 1 insertion(+), 1 deletion(-)

diff -puN fs/smbfs/file.c~smb_file_open-retval-fix fs/smbfs/file.c
--- 25/fs/smbfs/file.c~smb_file_open-retval-fix Mon Nov 29 13:08:30 2004
+++ 25-akpm/fs/smbfs/file.c     Mon Nov 29 13:08:38 2004
@@ -363,7 +363,7 @@ smb_file_open(struct inode *inode, struc
        SMB_I(inode)->openers++;
 out:
        unlock_kernel();
-       return 0;
+       return result;
 }


