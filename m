Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264692AbUD1IkM@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264692AbUD1IkM (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 28 Apr 2004 04:40:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264693AbUD1IkM
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 28 Apr 2004 04:40:12 -0400
Received: from orange.csi.cam.ac.uk ([131.111.8.77]:2754 "EHLO
	orange.csi.cam.ac.uk") by vger.kernel.org with ESMTP
	id S264692AbUD1IkG (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 28 Apr 2004 04:40:06 -0400
Subject: Re: New warnings on NTFS code
From: Anton Altaparmakov <aia21@cam.ac.uk>
To: Meelis Roos <mroos@linux.ee>
Cc: Linux Kernel list <linux-kernel@vger.kernel.org>
In-Reply-To: <Pine.GSO.4.44.0404281106040.24906-100000@math.ut.ee>
References: <Pine.GSO.4.44.0404281106040.24906-100000@math.ut.ee>
Content-Type: text/plain
Organization: University of Cambridge Computing Service
Message-Id: <1083141501.2035.25.camel@imp.csi.cam.ac.uk>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6 
Date: Wed, 28 Apr 2004 09:38:21 +0100
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2004-04-28 at 09:13, Meelis Roos wrote:
> This is 2.6.6-rc3 on sparc64. It has recently got some new warnings in
> NTFS (there was a warning before but now there are more):
> 
> fs/ntfs/super.c: In function `parse_ntfs_boot_sector':
> fs/ntfs/super.c:638: warning: long long unsigned int format, s64 arg (arg 4)

Oops.  A missing cast in a printf().  Now fixed in my tree.

> fs/ntfs/super.c: In function `ntfs_fill_super':
> fs/ntfs/super.c:1523: warning: cast to pointer from integer of different size
> fs/ntfs/super.c:1529: warning: cast to pointer from integer of different size
> fs/ntfs/super.c:1634: warning: cast to pointer from integer of different size
> 
> The 3 new warnings are because of this definition:
> 
> #define OGIN    ((struct inode*)le32_to_cpu(0x4e49474f))        /* OGIN */
> 
> This seems suspicious - hardcoded pointer?

It is a pointer poison.  Now fixed in my tree.

I will submit the fixes with the next NTFS release which should be in a
few weeks.  None of the above indicate anything is broken, so there is
no hurry...

Thanks for the report!

Best regards,

	Anton
-- 
Anton Altaparmakov <aia21 at cam.ac.uk> (replace at with @)
Unix Support, Computing Service, University of Cambridge, CB2 3QH, UK
Linux NTFS maintainer / IRC: #ntfs on irc.freenode.net
WWW: http://linux-ntfs.sf.net/ &
http://www-stu.christs.cam.ac.uk/~aia21/


