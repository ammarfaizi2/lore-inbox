Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1752154AbWCPK3R@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752154AbWCPK3R (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 16 Mar 2006 05:29:17 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752168AbWCPK3R
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 16 Mar 2006 05:29:17 -0500
Received: from ppsw-9.csi.cam.ac.uk ([131.111.8.139]:42668 "EHLO
	ppsw-9.csi.cam.ac.uk") by vger.kernel.org with ESMTP
	id S1752154AbWCPK3Q (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 16 Mar 2006 05:29:16 -0500
X-Cam-SpamDetails: Not scanned
X-Cam-AntiVirus: No virus found
X-Cam-ScannerInfo: http://www.cam.ac.uk/cs/email/scanner/
Date: Thu, 16 Mar 2006 10:28:38 +0000 (GMT)
From: Anton Altaparmakov <aia21@cam.ac.uk>
To: akpm@osdl.org
cc: linux-kernel@vger.kernel.org, len.brown@intel.com
Subject: Re: [patch 1/1] consolidate TRUE and FALSE
In-Reply-To: <200603161004.k2GA46Fc029649@shell0.pdx.osdl.net>
Message-ID: <Pine.LNX.4.64.0603161015130.31173@hermes-2.csi.cam.ac.uk>
References: <200603161004.k2GA46Fc029649@shell0.pdx.osdl.net>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Thu, 16 Mar 2006, akpm@osdl.org wrote:
> From: Andrew Morton <akpm@osdl.org>
> 
> We have no less than 65 implementations of TRUE and FALSE in the tree, so the
> inevitable happened:
[snip
> 
> The patch implements TRUE and FALSE in include/linux/kernel.h and removes all
> the private versions.

Great!  That has really been long overdue.

> Various places are doing things like
> 
> typedef {
> 	FALSE,
> 	TRUE
> } my_fave_name_for_a_bool;
> 
> These are converted to
> 
> typedef int my_fave_name_for_a_bool;

Given that the kernel now requires gcc 3.2 or later, that already includes 
a native boolean type (_Bool)?  Why not use that instead of "int"?

Also <stdbool.h> contains:

#define bool	_Bool
#define true	1
#define false	0

So we could take the bool rather than _Bool, too given _Bool looks 
rather ugly...

We could even go as far as removing all those typedefs and replacing all 
their uses with the native boolean type (or the "bool" define or 
whatever).  Seems like the perfect janitorial task to me.  (-;

Best regards,

	Anton
-- 
Anton Altaparmakov <aia21 at cam.ac.uk> (replace at with @)
Unix Support, Computing Service, University of Cambridge, CB2 3QH, UK
Linux NTFS maintainer / IRC: #ntfs on irc.freenode.net
WWW: http://linux-ntfs.sf.net/ & http://www-stu.christs.cam.ac.uk/~aia21/
