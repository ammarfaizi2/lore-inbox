Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262056AbTKRCsg (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 17 Nov 2003 21:48:36 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262288AbTKRCsg
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 17 Nov 2003 21:48:36 -0500
Received: from web13006.mail.yahoo.com ([216.136.174.16]:35848 "HELO
	web13006.mail.yahoo.com") by vger.kernel.org with SMTP
	id S262056AbTKRCse (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 17 Nov 2003 21:48:34 -0500
Message-ID: <20031118024833.7619.qmail@web13006.mail.yahoo.com>
Date: Mon, 17 Nov 2003 18:48:33 -0800 (PST)
From: Amit Patel <patelamitv@yahoo.com>
Subject: scsi_report_lun_scan bug?
To: linux-scsi@vger.kernel.org
Cc: linux-kernel@vger.kernel.org
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

I am using 2.6-test9-mm3. I noticed while doing
scsi_report_lun_scan(scsi_scan.c:891) the data
returned is assigned(scsi_scan.c:993) to signed char
array which causes the reported number of luns to be
huge while calculating num_luns to scan. Is there any
particular reason to be data is signed or just a bug?

I changed it to unsigned char and it seems to work
fine. I have attached a diff of scsi_scan.c. Let me
know if I am missing something.

Thanks
Amit

[root@Host200-w2k root]# diff
/cdrive/mm1/linux-2.6.0-test9/drivers/scsi/scsi_scan.c
/cdrive/mm3/linux-2.6.0-test9/drivers/scsi/scsi_scan.c
902c902
<       char *data;
---
>       unsigned char *data;
993c993
<       data = (char *) lun_data->scsi_lun;
---
>       data = (unsigned char *) lun_data->scsi_lun;
[root@Host200-w2k root]# 
 

__________________________________
Do you Yahoo!?
Protect your identity with Yahoo! Mail AddressGuard
http://antispam.yahoo.com/whatsnewfree
