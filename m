Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262407AbTKRDK3 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 17 Nov 2003 22:10:29 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262422AbTKRDK2
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 17 Nov 2003 22:10:28 -0500
Received: from web13001.mail.yahoo.com ([216.136.174.11]:23140 "HELO
	web13001.mail.yahoo.com") by vger.kernel.org with SMTP
	id S262407AbTKRDKY (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 17 Nov 2003 22:10:24 -0500
Message-ID: <20031118031024.2308.qmail@web13001.mail.yahoo.com>
Date: Mon, 17 Nov 2003 19:10:23 -0800 (PST)
From: Amit Patel <patelamitv@yahoo.com>
Subject: Re: scsi_report_lun_scan bug?
To: Matthew Wilcox <willy@debian.org>
Cc: linux-scsi@vger.kernel.org, linux-kernel@vger.kernel.org
In-Reply-To: <20031118025440.GH30485@parcelfarce.linux.theplanet.co.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Oops sorry did not know about that...

Here it is.

[root@Host200-w2k root]# diff -u
/cdrive/mm1/linux-2.6.0-test9/drivers/scsi/scsi_scan.c
/cdrive/mm3/linux-2.6.0-test9/drivers/scsi/scsi_scan.c
---
/cdrive/mm1/linux-2.6.0-test9/drivers/scsi/scsi_scan.c
     2003-11-04 11:52:30.000000000 -0800
+++
/cdrive/mm3/linux-2.6.0-test9/drivers/scsi/scsi_scan.c
     2003-11-17 18:25:30.534512992 -0800
@@ -899,7 +899,7 @@
        unsigned int retries;
        struct scsi_lun *lunp, *lun_data;
        struct scsi_request *sreq;
-       char *data;
+       unsigned char *data;
 
        /*
         * Only support SCSI-3 and up devices.
@@ -990,7 +990,7 @@
        /*
         * Get the length from the first four bytes of
lun_data.
         */
-       data = (char *) lun_data->scsi_lun;
+       data = (unsigned char *) lun_data->scsi_lun;
        length = ((data[0] << 24) | (data[1] << 16) |
                  (data[2] << 8) | (data[3] << 0));
 
[root@Host200-w2k root]# 
[root@Host200-w2k root]# 

--- Matthew Wilcox <willy@debian.org> wrote:
> On Mon, Nov 17, 2003 at 06:48:33PM -0800, Amit Patel
> wrote:
> > [root@Host200-w2k root]# diff
> >
>
/cdrive/mm1/linux-2.6.0-test9/drivers/scsi/scsi_scan.c
> >
>
/cdrive/mm3/linux-2.6.0-test9/drivers/scsi/scsi_scan.c
> > 902c902
> > <       char *data;
> > ---
> > >       unsigned char *data;
> 
> Hi Amit.  Can you send diffs in unified format in
> the future, ie diff -u
> Thanks.
> 
> -- 
> "It's not Hollywood.  War is real, war is primarily
> not about defeat or
> victory, it is about death.  I've seen thousands and
> thousands of dead bodies.
> Do you think I want to have an academic debate on
> this subject?" -- Robert Fisk


__________________________________
Do you Yahoo!?
Protect your identity with Yahoo! Mail AddressGuard
http://antispam.yahoo.com/whatsnewfree
