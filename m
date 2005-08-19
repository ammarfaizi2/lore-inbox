Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932548AbVHSSZc@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932548AbVHSSZc (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 19 Aug 2005 14:25:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932665AbVHSSZc
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 19 Aug 2005 14:25:32 -0400
Received: from e2.ny.us.ibm.com ([32.97.182.142]:65248 "EHLO e2.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id S932548AbVHSSZb (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 19 Aug 2005 14:25:31 -0400
Date: Fri, 19 Aug 2005 14:22:22 -0500
From: hallyn@serge.ibm.com
To: Andrew Morton <akpm@osdl.org>
Cc: linux-kernel@vger.kernel.org
Subject: Re: 2.6.13-rc6-mm1
Message-ID: <20050819192222.GA9179@serge.ibm.com>
References: <20050819043331.7bc1f9a9.akpm@osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20050819043331.7bc1f9a9.akpm@osdl.org>
User-Agent: Mutt/1.5.8i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I get a compile error due to the removal of scsi_cmd->timeout.

I have no idea whether the following is correct (I doubt it is), but
it does fix a compile error, and the resulting kernel at least
survives repeated dbench'es.

thanks,
-serge

Signed-off-by: Serge Hallyn <serue@us.ibm.com
--
 ibmvscsi.c |    2 +-
 1 files changed, 1 insertion(+), 1 deletion(-)

Index: linux-2.6.13-rc6-mm1/drivers/scsi/ibmvscsi/ibmvscsi.c
===================================================================
--- linux-2.6.13-rc6-mm1.orig/drivers/scsi/ibmvscsi/ibmvscsi.c	2005-08-19 17:39:38.000000000 -0500
+++ linux-2.6.13-rc6-mm1/drivers/scsi/ibmvscsi/ibmvscsi.c	2005-08-19 18:11:02.000000000 -0500
@@ -594,7 +594,7 @@ static int ibmvscsi_queuecommand(struct 
 	init_event_struct(evt_struct,
 			  handle_cmd_rsp,
 			  VIOSRP_SRP_FORMAT,
-			  cmnd->timeout);
+			  jiffies - cmnd->jiffies_at_alloc);
 
 	evt_struct->cmnd = cmnd;
 	evt_struct->cmnd_done = done;
