Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S275074AbTHQIJG (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 17 Aug 2003 04:09:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S275076AbTHQIJG
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 17 Aug 2003 04:09:06 -0400
Received: from mail.suse.de ([213.95.15.193]:43021 "EHLO Cantor.suse.de")
	by vger.kernel.org with ESMTP id S275074AbTHQIJD (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 17 Aug 2003 04:09:03 -0400
Date: Sun, 17 Aug 2003 10:09:01 +0200
From: Olaf Hering <olh@suse.de>
To: Alan Cox <alan@lxorguk.ukuu.org.uk>, Paul Mackeras <paulus@samba.org>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: scsi proc_info called unconditionally
Message-ID: <20030817080901.GA3754@suse.de>
References: <20030816084409.GA8038@suse.de> <1061053254.10688.6.camel@dhcp23.swansea.linux.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <1061053254.10688.6.camel@dhcp23.swansea.linux.org.uk>
X-DOS: I got your 640K Real Mode Right Here Buddy!
X-Homeland-Security: You are not supposed to read this line! You are a terrorist!
User-Agent: Mutt und vi sind doch schneller als Notes
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

 On Sat, Aug 16, Alan Cox wrote:

> On Sad, 2003-08-16 at 09:44, Olaf Hering wrote:
> > Why is ->proc_info() called when the function pointer is NULL?
> > 
> > (none):/# mount proc
> 
> Because proc_info is mandatory ?

Paul, do you want to fill in some content in that proc file?


--- linuxppc-2.5/drivers/scsi/mac53c94.c	2003-08-04 01:59:22.000000000 +0200
+++ linux-2.6.0-test3-lxppc25/drivers/scsi/mac53c94.c	2003-08-17 10:00:06.000000000 +0200
@@ -614,8 +614,15 @@ data_goes_out(Scsi_Cmnd *cmd)
 	}
 }
 
+int mac53c94_proc_info(struct Scsi_Host *host, char *buffer, char **start, off_t offset,
+		  int length, int inout)
+{
+	return 0;
+}
+
 static Scsi_Host_Template driver_template = {
 	.proc_name	= "53c94",
+	.proc_info	= mac53c94_proc_info,
 	.name		= "53C94",
 	.detect		= mac53c94_detect,
 	.release	= mac53c94_release,

-- 
USB is for mice, FireWire is for men!

sUse lINUX ag, nÜRNBERG
