Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750756AbWFWCJu@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750756AbWFWCJu (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 22 Jun 2006 22:09:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750763AbWFWCJt
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 22 Jun 2006 22:09:49 -0400
Received: from mx1.redhat.com ([66.187.233.31]:35236 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S1750756AbWFWCJt (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 22 Jun 2006 22:09:49 -0400
Date: Thu, 22 Jun 2006 22:09:42 -0400
From: Dave Jones <davej@redhat.com>
To: sfrench@samba.org
Cc: Linux Kernel <linux-kernel@vger.kernel.org>, Andrew Morton <akpm@osdl.org>
Subject: remove useless checks in cifs connect.c
Message-ID: <20060623020942.GA22889@redhat.com>
Mail-Followup-To: Dave Jones <davej@redhat.com>, sfrench@samba.org,
	Linux Kernel <linux-kernel@vger.kernel.org>,
	Andrew Morton <akpm@osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.4.2.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

The ; at the end of the 2nd if line in this diff caught my eye.
On closer inspection the whole line is unnecessary
anyway as kfree(NULL) is ok.

Also nuked another one a few lines up.

Signed-off-by: Dave Jones <davej@redhat.com>

--- linux-2.6/fs/cifs/connect.c~	2006-06-22 22:07:04.000000000 -0400
+++ linux-2.6/fs/cifs/connect.c	2006-06-22 22:07:42.000000000 -0400
@@ -2822,15 +2822,13 @@ CIFSNTLMSSPNegotiateSessSetup(unsigned i
 							    = 0;
 						} /* else no more room so create dummy domain string */
 						else {
-							if(ses->serverDomain)
-								kfree(ses->serverDomain);
+							kfree(ses->serverDomain);
 							ses->serverDomain =
 							    kzalloc(2,
 								    GFP_KERNEL);
 						}
 					} else {	/* no room so create dummy domain and NOS string */
-						if(ses->serverDomain);
-							kfree(ses->serverDomain);
+						kfree(ses->serverDomain);
 						ses->serverDomain =
 						    kzalloc(2, GFP_KERNEL);
 						if(ses->serverNOS)

-- 
http://www.codemonkey.org.uk
