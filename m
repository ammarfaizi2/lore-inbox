Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S291370AbSBHB7E>; Thu, 7 Feb 2002 20:59:04 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S291353AbSBHB6q>; Thu, 7 Feb 2002 20:58:46 -0500
Received: from out009pub.verizon.net ([206.46.170.131]:5533 "EHLO
	out009.verizon.net") by vger.kernel.org with ESMTP
	id <S291339AbSBHB61>; Thu, 7 Feb 2002 20:58:27 -0500
Date: Thu, 7 Feb 2002 20:56:02 -0500
From: Skip Ford <skip.ford@verizon.net>
To: linux-kernel@vger.kernel.org
Cc: garzik@havoc.gtf.org
Subject: Re: Alpha update for 2.5.3
Mail-Followup-To: linux-kernel@vger.kernel.org, garzik@havoc.gtf.org
In-Reply-To: <20020207211329.A861@jurassic.park.msu.ru> <20020207165949.A3759@are.twiddle.net> <3C6327F5.56C5F809@mandrakesoft.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="TB36FDmn/VVEgNH/"
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <3C6327F5.56C5F809@mandrakesoft.com>; from jgarzik@mandrakesoft.com on Thu, Feb 07, 2002 at 08:20:53PM -0500
Message-Id: <20020208015826.JIFG11848.out009.verizon.net@pool-141-150-235-204.delv.east.verizon.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--TB36FDmn/VVEgNH/
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Jeff Garzik wrote:
> 
> Second comment, some of the bits in your patch are in 2.5.3-pre3.  [but
> drivers/ide/ide-dma.c does not compile for me, unrelated to alpha...]

This patch Jens posted seems to fix it.

-- 
Skip

--TB36FDmn/VVEgNH/
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename="ide-dma.patch"

diff -Nru a/drivers/ide/ide-dma.c b/drivers/ide/ide-dma.c
--- a/drivers/ide/ide-dma.c	Thu Feb  7 09:44:56 2002
+++ b/drivers/ide/ide-dma.c	Thu Feb  7 09:44:56 2002
@@ -266,14 +266,16 @@
 #if 1	
 	if (sector_count > 128) {
 		memset(&sg[nents], 0, sizeof(*sg));
-		sg[nents].address = virt_addr;
+		sg[nents].page = virt_to_page(virt_addr);
+		sg[nents].offset = (unsigned long) virt_addr & ~PAGE_MASK;
 		sg[nents].length = 128  * SECTOR_SIZE;
 		nents++;
 		virt_addr = virt_addr + (128 * SECTOR_SIZE);
 		sector_count -= 128;
 	}
 	memset(&sg[nents], 0, sizeof(*sg));
-	sg[nents].address = virt_addr;
+	sg[nents].page = virt_to_page(virt_addr);
+	sg[nents].offset = (unsigned long) virt_addr & ~PAGE_MASK;
 	sg[nents].length =  sector_count  * SECTOR_SIZE;
 	nents++;
  #endif

--TB36FDmn/VVEgNH/--
