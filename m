Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S271922AbTGYEIF (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 25 Jul 2003 00:08:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S271923AbTGYEIF
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 25 Jul 2003 00:08:05 -0400
Received: from bristol.phunnypharm.org ([65.207.35.130]:16284 "EHLO
	bristol.phunnypharm.org") by vger.kernel.org with ESMTP
	id S271922AbTGYEIB (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 25 Jul 2003 00:08:01 -0400
Date: Fri, 25 Jul 2003 00:12:34 -0400
From: Ben Collins <bcollins@debian.org>
To: Sam Bromley <sbromley@cogeco.ca>
Cc: Torrey Hoffman <thoffman@arnor.net>, gaxt <gaxt@rogers.com>,
       Linux Kernel <linux-kernel@vger.kernel.org>,
       linux firewire devel <linux1394-devel@lists.sourceforge.net>
Subject: Re: Firewire
Message-ID: <20030725041234.GX1512@phunnypharm.org>
References: <3F1FE06A.5030305@rogers.com> <20030724223522.GA23196@ruvolo.net> <20030724223615.GN1512@phunnypharm.org> <20030724230928.GB23196@ruvolo.net> <1059095616.1897.34.camel@torrey.et.myrio.com> <20030725012723.GF23196@ruvolo.net> <20030725012908.GT1512@phunnypharm.org> <1059103424.24427.108.camel@daedalus.samhome.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1059103424.24427.108.camel@daedalus.samhome.net>
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> For what it's worth, I'm experiencing this as well.
> In the hopes of helping, I provide the dmesg
> output results after applying the above patch to Rev 1013.
> (Running 2.6.0-test1-ac1).

Please compile with debug enabled so I can get all the output. Also,
update using this patch instead of my last one.

Index: linux-2.6/drivers/ieee1394/ieee1394_core.c
===================================================================
--- linux-2.6/drivers/ieee1394/ieee1394_core.c	(revision 1013)
+++ linux-2.6/drivers/ieee1394/ieee1394_core.c	(working copy)
@@ -609,8 +609,11 @@
 
         spin_lock_irqsave(&host->pending_pkt_lock, flags);
 
+	HPSB_DEBUG("TLABEL: Checking for tlabel %d", tlabel);
+
         list_for_each(lh, &host->pending_packets) {
                 packet = list_entry(lh, struct hpsb_packet, list);
+		HPSB_DEBUG("TLABEL: tlabel %d in list", packet->tlabel, tlabel);
                 if ((packet->tlabel == tlabel)
                     && (packet->node_id == (data[1] >> 16))){
                         break;
@@ -622,7 +625,8 @@
                 dump_packet("contents:", data, 16);
                 spin_unlock_irqrestore(&host->pending_pkt_lock, flags);
                 return;
-        }
+        } else
+		HPSB_DEBUG("TLABEL: Found tlabel");
 
         switch (packet->tcode) {
         case TCODE_WRITEQ:

-- 
Debian     - http://www.debian.org/
Linux 1394 - http://www.linux1394.org/
Subversion - http://subversion.tigris.org/
