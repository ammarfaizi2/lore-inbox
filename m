Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751374AbWIITMg@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751374AbWIITMg (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 9 Sep 2006 15:12:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751376AbWIITMg
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 9 Sep 2006 15:12:36 -0400
Received: from outmx022.isp.belgacom.be ([195.238.4.203]:61341 "EHLO
	outmx022.isp.belgacom.be") by vger.kernel.org with ESMTP
	id S1751374AbWIITMe (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 9 Sep 2006 15:12:34 -0400
Subject: Re: [PATCH] alim15x3.c: M5229 (rev c8) support for DMA cd-writer
From: Michael De Backer <micdb@skynet.be>
To: linux-kernel@vger.kernel.org
In-Reply-To: <1157818525.6877.57.camel@localhost.localdomain>
References: <1157816221.5998.51.camel@mws.local.net>
	 <1157818525.6877.57.camel@localhost.localdomain>
Content-Type: text/plain; charset=UTF-8
Date: Sat, 09 Sep 2006 21:12:25 +0200
Message-Id: <1157829145.6648.11.camel@mws.local.net>
Mime-Version: 1.0
X-Mailer: Evolution 2.6.3 
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Le samedi 09 septembre 2006 à 17:15 +0100, Alan Cox a écrit :
> Ar Sad, 2006-09-09 am 17:37 +0200, ysgrifennodd Michael De Backer:
> > -       else if (m5229_revision == 0xc7)
> > +       else if (m5229_revision == 0xc7 || 0xc8)
> 
> I don't think that is what you mean..
> 
> NAK
Indeed, let's try again (please forgive my dumbness). 

Configuration bits are not set properly for DMA on some chipset
revisions. It has already been corrected for M5229 (rev c7) but not for
M5229 (rev c8). This leads to the bug described at
http://bugzilla.kernel.org/show_bug.cgi?id=5786 (lost interrupt + ide
bus hangs).

Signed-off-by: Michael De Backer <micdb@skynet.be>
---
The following patch is against the 2.6.18-rc6 or 2.6.18-rc6-mm1 kernel:

--- linux/drivers/ide/pci/alim15x3.c.orig       2006-09-09
16:07:07.000000000 +0200
+++ linux/drivers/ide/pci/alim15x3.c    2006-09-09 16:08:25.000000000
+0200
@@ -730,7 +730,7 @@ static unsigned int __devinit ata66_ali1

	if(m5229_revision <= 0x20)
		tmpbyte = (tmpbyte & (~0x02)) | 0x01;
-       else if (m5229_revision == 0xc7)
+       else if (m5229_revision == 0xc7 || m5229_revision == 0xc8)
		tmpbyte |= 0x03;
	else
		tmpbyte |= 0x01;

