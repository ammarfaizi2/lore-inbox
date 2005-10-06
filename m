Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751149AbVJFQzp@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751149AbVJFQzp (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 6 Oct 2005 12:55:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751152AbVJFQzp
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 6 Oct 2005 12:55:45 -0400
Received: from web32512.mail.mud.yahoo.com ([68.142.207.222]:44625 "HELO
	web32512.mail.mud.yahoo.com") by vger.kernel.org with SMTP
	id S1751149AbVJFQzp (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 6 Oct 2005 12:55:45 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
  s=s1024; d=yahoo.com;
  h=Message-ID:Received:Date:From:Subject:To:MIME-Version:Content-Type:Content-Transfer-Encoding;
  b=34xcdGxyQdegtSUNaZXZhmFgf6q3Aa2WgRA0Qjv385JoTD+ajQguK6FNhLm4oRcCwHbP1W8qgiPhS86h1fO5bfEh9ZcoGeCWfE0g4zQR2VnDedY6eTbPZspQygBlpVGjcdTBI/Use6knq1lP2UdULSJty/Cba+o7Zya72rLJgHI=  ;
Message-ID: <20051006165544.71775.qmail@web32512.mail.mud.yahoo.com>
Date: Thu, 6 Oct 2005 09:55:44 -0700 (PDT)
From: Ravi Wijayaratne <ravi_wija@yahoo.com>
Subject: Reading SATA command/status register (lib-ata)
To: linux-kernel@vger.kernel.org, linux-ide@vger.kernel.org
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi all

I am calling libata-core.c:sata_phy_reset(port) from a kernel thread
to reset the hot plugged SATA drive. My machine locks up at the place
where it reads the status from the device in ata_busy_sleep(..).

1494         while ((status & ATA_BUSY) && (time_before(jiffies, timeout))) {
1495                 msleep(50);
1496                 status = ata_chk_status(ap);
1497         }

ata_chk_status simply does a readl(status_register). It is not clear to me 
where the hang is. My machine locks up before I call msleep or ata_chk_status.
(determined by printks) after iterating the above routine a few times. When it 
locks up nothing responds. I cant even get to kdb to debug.

But what I noted is that every time it seem to lock up the when the ATA_BUSY status is
removed. (State changes from 0xd0 to 0x50 in ATA Status register). The ATA spec says
that each time this register is read any interrupts are cleared. I wander whether this
would cause the machine to hang ? 

Some insight will be much appreciated.

Thanks
Ravi
 



		
__________________________________ 
Yahoo! Mail - PC Magazine Editors' Choice 2005 
http://mail.yahoo.com
