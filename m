Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262791AbVAFJ04@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262791AbVAFJ04 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 6 Jan 2005 04:26:56 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262793AbVAFJ04
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 6 Jan 2005 04:26:56 -0500
Received: from ppsw-4.csi.cam.ac.uk ([131.111.8.134]:24459 "EHLO
	ppsw-4.csi.cam.ac.uk") by vger.kernel.org with ESMTP
	id S262791AbVAFJ0t (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 6 Jan 2005 04:26:49 -0500
Subject: Re: a little improvement  for vmalloc
From: Anton Altaparmakov <aia21@cam.ac.uk>
To: Andrew Morton <akpm@osdl.org>
Cc: Zhonglin Zhang <zhonglinzh@mobilesoft.com.cn>,
       lkml <linux-kernel@vger.kernel.org>
In-Reply-To: <20050105193827.12d83341.akpm@osdl.org>
References: <1104981532.628.10.camel@milo>
	 <20050105193827.12d83341.akpm@osdl.org>
Content-Type: text/plain
Organization: University of Cambridge Computing Service, UK
Date: Thu, 06 Jan 2005 09:26:41 +0000
Message-Id: <1105003601.19888.2.camel@imp.csi.cam.ac.uk>
Mime-Version: 1.0
X-Mailer: Evolution 2.0.1 
Content-Transfer-Encoding: 7bit
X-Cam-ScannerInfo: http://www.cam.ac.uk/cs/email/scanner/
X-Cam-AntiVirus: No virus found
X-Cam-SpamDetails: Not scanned
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2005-01-05 at 19:38 -0800, Andrew Morton wrote:
> Zhonglin Zhang <zhonglinzh@mobilesoft.com.cn> wrote:
> >
> > In FUNCTION __vmalloc ,
> > 
> >  There is a statement;
> > 
> >  if (!size || (size >> PAGE_SHIFT) > num_physpages)
> >          return NULL;
> 
> Probably the second part of the test should be removed.  If the requested
> area size is
> 
> a) less than the size of the vmalloc arena and
> 
> b) more than the number of allocatable pages
> 
> then yes, the machine will have a ton of trouble allocating the memory and
> will actually lock up.
> 
> But the only way that will happen is if some code is made to do a large
> number of smaller vmallocs.  Nobody does a huge single vmalloc like that.

I thought that second test was to avoid stupid bugs that may exist in
some random (perhaps ex-tree) modules that would otherwise cause the
machine to lockup...

Best regards,

        Anton
-- 
Anton Altaparmakov <aia21 at cam.ac.uk> (replace at with @)
Unix Support, Computing Service, University of Cambridge, CB2 3QH, UK
Linux NTFS maintainer / IRC: #ntfs on irc.freenode.net
WWW: http://linux-ntfs.sf.net/ & http://www-stu.christs.cam.ac.uk/~aia21/

