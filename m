Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262001AbVFGV3a@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262001AbVFGV3a (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 7 Jun 2005 17:29:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261991AbVFGV3W
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 7 Jun 2005 17:29:22 -0400
Received: from nproxy.gmail.com ([64.233.182.192]:28202 "EHLO nproxy.gmail.com")
	by vger.kernel.org with ESMTP id S261990AbVFGV2I convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 7 Jun 2005 17:28:08 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:reply-to:to:subject:mime-version:content-type:content-transfer-encoding:content-disposition;
        b=hKlOjNRzcCHrm3TVdT/J2d5XwOwW0YXTdXwQEgZHTdgkQDNfHSt5PvV2qevBRkSsaTpwtnsco5O4V/QYzIjgJchDrPmAEDRtebhv+L2+OTrcX2knY6KQesXs8cne6O3qDcQNyHLF1/62kMYPBJdEzE/TihDpOGgGZg44rCS80YI=
Message-ID: <4ad99e050506071428278c3018@mail.gmail.com>
Date: Tue, 7 Jun 2005 23:28:07 +0200
From: Lars Roland <lroland@gmail.com>
Reply-To: Lars Roland <lroland@gmail.com>
To: Linux-Kernel <linux-kernel@vger.kernel.org>
Subject: Fusion MPT driver version 3.01.20 VS. version 2.03.00
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi 

We have a bunch of IBM 335/336 used as email (anti-virus/spam)
gateways. Recently our admin changed the kernel version from version
2.4.24 to 2.6.8.1 - this resulted in a massive performance
degradation. The old system could handle 60.000 emails pr. hour the
new one could only handle about 30.000 emails (this was tested by
sampling 60.000 emails and sending them to the server).

After poking a bit around (changing hardware and upgrading bios's) I
realized that the time spend for writing the files to the disk have
gone up (multiple small writes seams to kill it): A hdparm test gives:

----------------------------
kernel 2.6.8.1 (MPT version : 3.01.09)
hdparm -t /dev/sda

/dev/sda:
 Timing buffered disk reads:  64 MB in  3.03 seconds = 21.12 MB/sec


kernel 2.4.24 (MPT version: 2.03.00)
hdparm -t /dev/sda

/dev/sda:
 Timing buffered disk reads:  64 MB in  1.19 seconds = 53.78 MB/sec
----------------------------

Next I tried upgrading the kernel to 2.6.12-rc5 to see if there was
any improvements but there was none.

----------------------------
kernel 2.6.12-rc5 (MPT version : 3.01.20)
hdparm -t /dev/sda

/dev/sda:
 Timing buffered disk reads:  64 MB in  3.03 seconds = 21.12 MB/sec
----------------------------

I have also tried building the driver from kernel 2.6.12-rc5 in the
kernel instead of a module, this also changed nothing. The driver in
the old kernel is 2.03.00 the new one is 3.01.20. On both kernel 2.6
and 2.4 /proc/scsi/scsi gives me

----------------------------
Attached devices:
Host: scsi0 Channel: 00 Id: 00 Lun: 00
  Vendor: IBM-ESXS Model: CBR036C31210ESFN Rev: DFQ8
  Type:   Direct-Access                    ANSI SCSI revision: 04
Host: scsi0 Channel: 00 Id: 08 Lun: 00
  Vendor: IBM      Model: 25P3495a S320  1 Rev: 1
  Type:   Processor                        ANSI SCSI revision: 02
----------------------------


Regards.

Lars Roland
