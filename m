Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267971AbUJDOMN@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267971AbUJDOMN (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 4 Oct 2004 10:12:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267951AbUJDOMN
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 4 Oct 2004 10:12:13 -0400
Received: from open.hands.com ([195.224.53.39]:53162 "EHLO open.hands.com")
	by vger.kernel.org with ESMTP id S268157AbUJDOJo (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 4 Oct 2004 10:09:44 -0400
Date: Mon, 4 Oct 2004 15:20:50 +0100
From: Luke Kenneth Casson Leighton <lkcl@lkcl.net>
To: linux-kernel@vger.kernel.org
Cc: 274867@bugs.debian.org, 274870@bugs.debian.org
Subject: Re: [bug] 2.6.8: CDROM_SEND_PACKET ioctls failing as non-root on ide scsi drives
Message-ID: <20041004142050.GC20930@lkcl.net>
References: <20041004130941.GE19341@lkcl.net> <6u4qlaehlw.fsf@zork.zork.net>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="oC1+HKm2/end4ao3"
Content-Disposition: inline
In-Reply-To: <6u4qlaehlw.fsf@zork.zork.net>
User-Agent: Mutt/1.5.5.1+cvs20040105i
X-hands-com-MailScanner: Found to be clean
X-hands-com-MailScanner-SpamScore: s
X-MailScanner-From: lkcl@lkcl.net
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--oC1+HKm2/end4ao3
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Mon, Oct 04, 2004 at 02:30:03PM +0100, Sean Neakums wrote:

> > ... what gives?
> 
> CDROM_SEND_PACKET calls down to sg_io, which calls verify_command,
> which will not permit anyone but root to use any unrecognised
> commands.  GET CONFIGURATION does not seems to be one of those
> recognised.  

 oh, right, i didn't think of checking that. 

 so if i just add that command, everything works hunky-dory.

 well, i'll try it!

 l.

-- 
--
Truth, honesty and respect are rare commodities that all spring from
the same well: Love.  If you love yourself and everyone and everything
around you, funnily and coincidentally enough, life gets a lot better.
--
<a href="http://lkcl.net">      lkcl.net      </a> <br />
<a href="mailto:lkcl@lkcl.net"> lkcl@lkcl.net </a> <br />


--oC1+HKm2/end4ao3
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename="scsi_ioctl.diff"

Index: drivers/block/scsi_ioctl.c
===================================================================
RCS file: /cvsroot/selinux/nsa/linux-2.6/drivers/block/scsi_ioctl.c,v
retrieving revision 1.1.1.9
diff -u -r1.1.1.9 scsi_ioctl.c
--- drivers/block/scsi_ioctl.c	19 Aug 2004 14:25:16 -0000	1.1.1.9
+++ drivers/block/scsi_ioctl.c	4 Oct 2004 14:07:25 -0000
@@ -146,6 +146,7 @@
 		safe_for_read(GPCMD_READ_TOC_PMA_ATIP),
 		safe_for_read(GPCMD_REPORT_KEY),
 		safe_for_read(GPCMD_SCAN),
+		safe_for_read(GPCMD_GET_CONFIGURATION),
 
 		/* Basic writing commands */
 		safe_for_write(WRITE_6),

--oC1+HKm2/end4ao3--
