Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932098AbVJMTh0@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932098AbVJMTh0 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 13 Oct 2005 15:37:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932162AbVJMTh0
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 13 Oct 2005 15:37:26 -0400
Received: from ams-iport-1.cisco.com ([144.254.224.140]:62565 "EHLO
	ams-iport-1.cisco.com") by vger.kernel.org with ESMTP
	id S932098AbVJMThZ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 13 Oct 2005 15:37:25 -0400
To: Jesper Juhl <jesper.juhl@gmail.com>
Cc: "linux-kernel" <linux-kernel@vger.kernel.org>,
       Andrew Morton <akpm@osdl.org>, Len Brown <len.brown@intel.com>,
       iss_storagedev@hp.com, Jakub Jelinek <jj@ultra.linux.cz>,
       Frodo Looijaard <frodol@dds.nl>, Jean Delvare <khali@linux-fr.org>,
       Bartlomiej Zolnierkiewicz <B.Zolnierkiewicz@elka.pw.edu.pl>,
       Jens Axboe <axboe@suse.de>,
       Sergio Rozanski Filho <aris@cathedrallabs.org>,
       Benjamin Herrenschmidt <benh@kernel.crashing.org>,
       Pierre Ossman <drzeus-wbsd@drzeus.cx>,
       Carsten Gross <carsten@sol.wh-hms.uni-ulm.de>,
       "Greg Kroah-Hartman" <greg@kroah.com>,
       David Hinds <dahinds@users.sourceforge.net>,
       Vinh Truong <vinh.truong@eng.sun.com>,
       Mark Douglas Corner <mcorner@umich.edu>,
       Michael Downey <downey@zymeta.com>, Antonino Daplas <adaplas@pol.net>,
       Ben Gardner <bgardner@wabtec.com>
Subject: Re: [PATCH 09/14] Big kfree NULL check cleanup - misc remaining
 drivers
X-Message-Flag: Warning: May contain useful information
References: <200510132128.45171.jesper.juhl@gmail.com>
From: Roland Dreier <rolandd@cisco.com>
Date: Thu, 13 Oct 2005 12:37:07 -0700
In-Reply-To: <200510132128.45171.jesper.juhl@gmail.com> (Jesper Juhl's
 message of "Thu, 13 Oct 2005 21:28:44 +0200")
Message-ID: <52ek6p2opo.fsf@cisco.com>
User-Agent: Gnus/5.1007 (Gnus v5.10.7) XEmacs/21.4.17 (Jumbo Shrimp, linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
X-OriginalArrivalTime: 13 Oct 2005 19:37:09.0439 (UTC) FILETIME=[804A5CF0:01C5D02D]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

For what it's worth, the InfiniBand chunk below looks good to me.

Acked-by: Roland Dreier <rolandd@cisco.com>

--- linux-2.6.14-rc4-orig/drivers/infiniband/core/mad.c	2005-10-11 22:41:09.000000000 +0200
+++ linux-2.6.14-rc4/drivers/infiniband/core/mad.c	2005-10-12 17:37:50.000000000 +0200
@@ -510,8 +510,7 @@ static void unregister_mad_agent(struct 
 	wait_event(mad_agent_priv->wait,
 		   !atomic_read(&mad_agent_priv->refcount));
 
-	if (mad_agent_priv->reg_req)
-		kfree(mad_agent_priv->reg_req);
+	kfree(mad_agent_priv->reg_req);
 	ib_dereg_mr(mad_agent_priv->agent.mr);
 	kfree(mad_agent_priv);
 }
@@ -2544,8 +2543,7 @@ error:
 static void destroy_mad_qp(struct ib_mad_qp_info *qp_info)
 {
 	ib_destroy_qp(qp_info->qp);
-	if (qp_info->snoop_table)
-		kfree(qp_info->snoop_table);
+	kfree(qp_info->snoop_table);
 }
 
 /*
