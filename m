Return-Path: <linux-kernel-owner+willy=40w.ods.org-S966190AbWKNQcx@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S966190AbWKNQcx (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 14 Nov 2006 11:32:53 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S966189AbWKNQcx
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 14 Nov 2006 11:32:53 -0500
Received: from rtr.ca ([64.26.128.89]:52485 "EHLO mail.rtr.ca")
	by vger.kernel.org with ESMTP id S966187AbWKNQcw (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 14 Nov 2006 11:32:52 -0500
Message-ID: <4559EFB2.1000809@rtr.ca>
Date: Tue, 14 Nov 2006 11:32:50 -0500
From: Mark Lord <liml@rtr.ca>
User-Agent: Thunderbird 1.5.0.8 (X11/20061025)
MIME-Version: 1.0
To: Jeff Garzik <jeff@garzik.org>
Cc: Andrew Morton <akpm@osdl.org>, Linus Torvalds <torvalds@osdl.org>,
       linux-ide@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>
Subject: Re: [git patches] libata fixes
References: <20061114150454.GA11900@havoc.gtf.org>
In-Reply-To: <20061114150454.GA11900@havoc.gtf.org>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

diff --git a/drivers/ata/libata-scsi.c b/drivers/ata/libata-scsi.c
index 7af2a4b..5c1fc46 100644
--- a/drivers/ata/libata-scsi.c
+++ b/drivers/ata/libata-scsi.c
@@ -1612,9 +1612,9 @@ early_finish:
 
 err_did:
 	ata_qc_free(qc);
-err_mem:
 	cmd->result = (DID_ERROR << 16);
 	done(cmd);
+err_mem:
 	DPRINTK("EXIT - internal\n");
 	return 0;

This doesn't look correct to me, but I did miss out on the original discussion(?).

Any time we return 0 from queuecommand, the SCSI mid-layer expects us
to also take care of invoking the done() function.  Where does this now
happen for this case (err_mem) ???

Cheers
