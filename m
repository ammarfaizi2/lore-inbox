Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261612AbVCCIbK@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261612AbVCCIbK (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 3 Mar 2005 03:31:10 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261619AbVCCIbK
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 3 Mar 2005 03:31:10 -0500
Received: from anchor-post-36.mail.demon.net ([194.217.242.86]:14860 "EHLO
	anchor-post-36.mail.demon.net") by vger.kernel.org with ESMTP
	id S261612AbVCCIaB convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 3 Mar 2005 03:30:01 -0500
X-MimeOLE: Produced By Microsoft Exchange V6.5.7226.0
Content-class: urn:content-classes:message
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Subject: RE: Problems with SCSI tape rewind / verify on 2.4.29
Date: Thu, 3 Mar 2005 08:29:59 -0000
Message-ID: <E7F85A1B5FF8D44C8A1AF6885BC9A0E472B8C2@ratbert.vale-housing.co.uk>
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
Thread-Topic: Problems with SCSI tape rewind / verify on 2.4.29
Thread-Index: AcUfRfhHzhHd7W3JTBWhPlfoBlYIqAAhOYjQ
From: "Mark Yeatman" <myeatman@vale-housing.co.uk>
To: <linux-kernel@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This corrected the problem on 2.4.29. Thanks Marcelo and all for your
help.

Mark


-----Original Message-----
From: Marcelo Tosatti [mailto:marcelo.tosatti@cyclades.com] 
Sent: 02 March 2005 12:04
To: Mark Yeatman
Cc: linux-kernel@vger.kernel.org; akpm@osdl.org
Subject: Re: Problems with SCSI tape rewind / verify on 2.4.29

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
> I have traced this back to failing at an upgrade of the kernel to
2.4.29
> on Feb 8th. The backups have not worked since. Replacement Drives have
> been tried and cables to no avail. I noticed in the the changelog that
a
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
