Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262345AbVCBQge@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262345AbVCBQge (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 2 Mar 2005 11:36:34 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262350AbVCBQge
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 2 Mar 2005 11:36:34 -0500
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:2010 "EHLO
	parcelfarce.linux.theplanet.co.uk") by vger.kernel.org with ESMTP
	id S262345AbVCBQgV (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 2 Mar 2005 11:36:21 -0500
Date: Wed, 2 Mar 2005 09:03:32 -0300
From: Marcelo Tosatti <marcelo.tosatti@cyclades.com>
To: Mark Yeatman <myeatman@vale-housing.co.uk>
Cc: linux-kernel@vger.kernel.org, akpm@osdl.org
Subject: Re: Problems with SCSI tape rewind / verify on 2.4.29
Message-ID: <20050302120332.GA27882@logos.cnet>
References: <E7F85A1B5FF8D44C8A1AF6885BC9A0E472B886@ratbert.vale-housing.co.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <E7F85A1B5FF8D44C8A1AF6885BC9A0E472B886@ratbert.vale-housing.co.uk>
User-Agent: Mutt/1.5.5.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Mar 02, 2005 at 11:15:42AM -0000, Mark Yeatman wrote:
> Hi
> 
> Never had to log a bug before, hope this is correctly done.
> 
> Thanks
> 
> Mark
> 
> Detail....
> 
> [1.] One line summary of the problem:    
> SCSI tape drive is refusing to rewind after backup to allow verify and
> causing illegal seek error
> 
> [2.] Full description of the problem/report:
> On backup the tape drive is reporting the following error and failing
> it's backups.
> 
> tar: /dev/st0: Warning: Cannot seek: Illegal seek
> 
> I have traced this back to failing at an upgrade of the kernel to 2.4.29
> on Feb 8th. The backups have not worked since. Replacement Drives have
> been tried and cables to no avail. I noticed in the the changelog that a
> patch by Solar Designer to the Scsi tape return code had been made. 

v2.6 also contains the same problem BTW.

Try this:

--- a/drivers/scsi/st.c.orig	2005-03-02 09:02:13.637158144 -0300
+++ b/drivers/scsi/st.c	2005-03-02 09:02:20.208159200 -0300
@@ -3778,7 +3778,6 @@
 	read:		st_read,
 	write:		st_write,
 	ioctl:		st_ioctl,
-	llseek:		no_llseek,
 	open:		st_open,
 	flush:		st_flush,
 	release:	st_release,
