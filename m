Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263952AbTGYCPP (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 24 Jul 2003 22:15:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265531AbTGYCPP
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 24 Jul 2003 22:15:15 -0400
Received: from bristol.phunnypharm.org ([65.207.35.130]:53403 "EHLO
	bristol.phunnypharm.org") by vger.kernel.org with ESMTP
	id S263952AbTGYCPL (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 24 Jul 2003 22:15:11 -0400
Date: Thu, 24 Jul 2003 22:19:55 -0400
From: Ben Collins <bcollins@debian.org>
To: Torrey Hoffman <thoffman@arnor.net>, gaxt <gaxt@rogers.com>,
       Linux Kernel <linux-kernel@vger.kernel.org>,
       linux firewire devel <linux1394-devel@lists.sourceforge.net>
Subject: Re: Firewire
Message-ID: <20030725021955.GV1512@phunnypharm.org>
References: <3F1FE06A.5030305@rogers.com> <20030724223522.GA23196@ruvolo.net> <20030724223615.GN1512@phunnypharm.org> <20030724230928.GB23196@ruvolo.net> <1059095616.1897.34.camel@torrey.et.myrio.com> <20030725012723.GF23196@ruvolo.net> <20030725012908.GT1512@phunnypharm.org> <20030725020027.GG23196@ruvolo.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20030725020027.GG23196@ruvolo.net>
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jul 24, 2003 at 07:00:27PM -0700, Chris Ruvolo wrote:
> On Thu, Jul 24, 2003 at 09:29:08PM -0400, Ben Collins wrote:
> > Could both you guys try this workaround? Should prove or disprove my
> > theory.
> 
> Similar output (debug).  Diff of output and then full output follows.

Just noticed that this doesn't even have anything to do with ohci1394.
It's all local requests for config rom reads. Can you send me the debug
with the below patch applied?

Index: linux-2.6/drivers/ieee1394/ieee1394_core.c
===================================================================
--- linux-2.6/drivers/ieee1394/ieee1394_core.c	(revision 1013)
+++ linux-2.6/drivers/ieee1394/ieee1394_core.c	(working copy)
@@ -611,6 +611,7 @@
 
         list_for_each(lh, &host->pending_packets) {
                 packet = list_entry(lh, struct hpsb_packet, list);
+		HPSB_DEBUG("Checking tlabel %d\n", tlabel);
                 if ((packet->tlabel == tlabel)
                     && (packet->node_id == (data[1] >> 16))){
                         break;


-- 
Debian     - http://www.debian.org/
Linux 1394 - http://www.linux1394.org/
Subversion - http://subversion.tigris.org/
