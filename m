Return-Path: <linux-kernel-owner+willy=40w.ods.org-S271655AbUKBDLE@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S271655AbUKBDLE (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 1 Nov 2004 22:11:04 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S288796AbUKAW7i
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 1 Nov 2004 17:59:38 -0500
Received: from e3.ny.us.ibm.com ([32.97.182.103]:33983 "EHLO e3.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id S277500AbUKAVn2 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 1 Nov 2004 16:43:28 -0500
Date: Mon, 1 Nov 2004 15:40:07 -0600
From: Maneesh Soni <maneesh@in.ibm.com>
To: mpeschke@de.ibm.com
Cc: LKML <linux-kernel@vger.kernel.org>
Subject: [s390] [2.6.10-rc1-bk11] zfcp compilation fix
Message-ID: <20041101214007.GB2613@in.ibm.com>
Reply-To: maneesh@in.ibm.com
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On 2.6.10-rc1-bk11

drivers/s390/scsi/zfcp_scsi.c: In function `zfcp_port_lookup':
drivers/s390/scsi/zfcp_scsi.c:423: error: `zfcp_port' undeclared (first use in this function)
drivers/s390/scsi/zfcp_scsi.c:423: error: (Each undeclared identifier is reported only once
drivers/s390/scsi/zfcp_scsi.c:423: error: for each function it appears in.)
drivers/s390/scsi/zfcp_scsi.c:423: error: parse error before ')' token
make[2]: *** [drivers/s390/scsi/zfcp_scsi.o] Error 1
make[1]: *** [drivers/s390/scsi] Error 2
make: *** [drivers/s390] Error 2


Add the missing "struct" keyword.


Signed-off-by: <maneesh@in.ibm.com>
---

 linux-2.6.10-rc1-bk11-maneesh/drivers/s390/scsi/zfcp_scsi.c |    2 +-
 1 files changed, 1 insertion(+), 1 deletion(-)

diff -puN drivers/s390/scsi/zfcp_scsi.c~fix-zfcp-compilation drivers/s390/scsi/zfcp_scsi.c
--- linux-2.6.10-rc1-bk11/drivers/s390/scsi/zfcp_scsi.c~fix-zfcp-compilation	2004-11-01 15:32:38.000000000 -0600
+++ linux-2.6.10-rc1-bk11-maneesh/drivers/s390/scsi/zfcp_scsi.c	2004-11-01 15:33:08.000000000 -0600
@@ -420,7 +420,7 @@ zfcp_port_lookup(struct zfcp_adapter *ad
 		if (id == port->scsi_id)
 			return port;
 	}
-	return (zfcp_port *)NULL;
+	return (struct zfcp_port *)NULL;
 }
 
 /*
_

-- 
Maneesh Soni
Linux Technology Center, 
IBM Austin
email: maneesh@in.ibm.com
Phone: 1-512-838-1896 Fax: 
T/L : 6781896
