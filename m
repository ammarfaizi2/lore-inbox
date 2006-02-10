Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750881AbWBJAhj@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750881AbWBJAhj (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 9 Feb 2006 19:37:39 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750884AbWBJAhj
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 9 Feb 2006 19:37:39 -0500
Received: from emailhub.stusta.mhn.de ([141.84.69.5]:51461 "HELO
	mailout.stusta.mhn.de") by vger.kernel.org with SMTP
	id S1750881AbWBJAhi (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 9 Feb 2006 19:37:38 -0500
Date: Fri, 10 Feb 2006 01:37:37 +0100
From: Adrian Bunk <bunk@stusta.de>
To: Andrew Morton <akpm@osdl.org>, Christoph Hellwig <hch@lst.de>
Cc: linux-kernel@vger.kernel.org, achim_leubner@adaptec.com,
       linux-scsi@vger.kernel.org
Subject: [-mm patch] drivers/scsi/gdth.c: make __gdth_execute() static
Message-ID: <20060210003737.GH3524@stusta.de>
References: <20060207220627.345107c3.akpm@osdl.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060207220627.345107c3.akpm@osdl.org>
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Feb 07, 2006 at 10:06:27PM -0800, Andrew Morton wrote:
>...
> Changes since 2.6.16-rc1-mm5:
>...
> +gdth-add-execute-firmware-command-abstraction.patch
> 
>  scsi driver API modernisation
>...


I don't see any reason for __gdth_execute() being global.


Signed-off-by: Adrian Bunk <bunk@stusta.de>

---

 drivers/scsi/gdth.c |    8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

--- linux-2.6.16-rc2-mm1-full/drivers/scsi/gdth.c.old	2006-02-10 00:49:53.000000000 +0100
+++ linux-2.6.16-rc2-mm1-full/drivers/scsi/gdth.c	2006-02-10 00:51:05.000000000 +0100
@@ -693,8 +693,8 @@
 		complete(scp->request->waiting);
 }
 
-int __gdth_execute(struct scsi_device *sdev, gdth_cmd_str *gdtcmd, char *cmnd,
-		 int timeout, u32 *info)
+static int __gdth_execute(struct scsi_device *sdev, gdth_cmd_str *gdtcmd,
+			  char *cmnd, int timeout, u32 *info)
 {
 	struct scsi_request *scp = scsi_allocate_request(sdev, GFP_KERNEL);
 	unsigned bufflen = gdtcmd ? sizeof(gdth_cmd_str) : 0;
@@ -727,8 +727,8 @@
 		complete(scp->request.waiting);
 }
 
-int __gdth_execute(struct scsi_device *sdev, gdth_cmd_str *gdtcmd, char *cmnd,
-		 int timeout, u32 *info)
+static int __gdth_execute(struct scsi_device *sdev, gdth_cmd_str *gdtcmd,
+			  char *cmnd, int timeout, u32 *info)
 {
 	Scsi_Cmnd *scp = scsi_allocate_device(sdev, 1, FALSE);
 	unsigned bufflen = gdtcmd ? sizeof(gdth_cmd_str) : 0;

