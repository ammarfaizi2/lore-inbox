Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S272068AbTGYNa6 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 25 Jul 2003 09:30:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S272070AbTGYNal
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 25 Jul 2003 09:30:41 -0400
Received: from bristol.phunnypharm.org ([65.207.35.130]:60062 "EHLO
	bristol.phunnypharm.org") by vger.kernel.org with ESMTP
	id S272068AbTGYNac (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 25 Jul 2003 09:30:32 -0400
Date: Fri, 25 Jul 2003 09:34:51 -0400
From: Ben Collins <bcollins@debian.org>
To: Sam Bromley <sbromley@cogeco.ca>, Torrey Hoffman <thoffman@arnor.net>,
       gaxt <gaxt@rogers.com>, Linux Kernel <linux-kernel@vger.kernel.org>,
       linux firewire devel <linux1394-devel@lists.sourceforge.net>
Subject: Re: Firewire
Message-ID: <20030725133450.GA1512@phunnypharm.org>
References: <3F1FE06A.5030305@rogers.com> <20030724223522.GA23196@ruvolo.net> <20030724223615.GN1512@phunnypharm.org> <20030724230928.GB23196@ruvolo.net> <1059095616.1897.34.camel@torrey.et.myrio.com> <20030725012723.GF23196@ruvolo.net> <20030725012908.GT1512@phunnypharm.org> <1059103424.24427.108.camel@daedalus.samhome.net> <20030725041234.GX1512@phunnypharm.org> <20030725053920.GH23196@ruvolo.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20030725053920.GH23196@ruvolo.net>
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Index: ieee1394_core.c
===================================================================
--- ieee1394_core.c	(revision 1013)
+++ ieee1394_core.c	(working copy)
@@ -421,11 +421,13 @@
 
         if (packet->no_waiter) {
                 /* must not have a tlabel allocated */
+		HPSB_DEBUG("TLABEL: no_waiter, returning");
                 free_hpsb_packet(packet);
                 return;
         }
 
         if (ackcode != ACK_PENDING || !packet->expect_response) {
+		HPSB_DEBUG("TLABEL: not pending or no response expected, returning");
                 packet->state = hpsb_complete;
                 up(&packet->state_change);
                 up(&packet->state_change);
@@ -437,6 +439,7 @@
         packet->sendtime = jiffies;
 
         spin_lock_irqsave(&host->pending_pkt_lock, flags);
+	HPSB_DEBUG("TLABEL: appending packet to pending list");
         list_add_tail(&packet->list, &host->pending_packets);
         spin_unlock_irqrestore(&host->pending_pkt_lock, flags);
 

-- 
Debian     - http://www.debian.org/
Linux 1394 - http://www.linux1394.org/
Subversion - http://subversion.tigris.org/
