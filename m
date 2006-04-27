Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964929AbWD0Ed2@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964929AbWD0Ed2 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 27 Apr 2006 00:33:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964932AbWD0Ed1
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 27 Apr 2006 00:33:27 -0400
Received: from mtagate1.de.ibm.com ([195.212.29.150]:2740 "EHLO
	mtagate1.de.ibm.com") by vger.kernel.org with ESMTP id S964929AbWD0Ed1 convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 27 Apr 2006 00:33:27 -0400
In-Reply-To: <1146096330.3012.58.camel@localhost.localdomain>
To: Greg Smith <gsmith@nc.rr.com>
Cc: linux-kernel@vger.kernel.org, mschwid2@de.ibm.com
MIME-Version: 1.0
Subject: Re: s390 lcs incorrect test
X-Mailer: Lotus Notes Release 6.0.2CF1 June 9, 2003
From: Frank Pavlic <PAVLIC@de.ibm.com>
Message-ID: <OFD0B5D01B.AB09BC08-ONC125715D.0018D87C-C125715D.00190DD5@de.ibm.com>
Date: Thu, 27 Apr 2006 06:34:30 +0200
X-MIMETrack: Serialize by Router on D12ML068/12/M/IBM(Release 6.53HF654 | July 22, 2005) at
 27/04/2006 06:34:31,
	Serialize complete at 27/04/2006 06:34:31
Content-Type: text/plain; charset="ISO-8859-1"
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I agree , it's really weird ...

Thank you Greg for the patch ...


Mit  freundlichen Grüssen / Best regards
Frank Pavlic
 
Linux for eServer Development
Schoenaicher Str. 220, 71032 Boeblingen
Phone:  ext. +49-(0)7031/16-2463, int. *120-2463
mailto:   pavlic@de.ibm.com






Greg Smith <gsmith@nc.rr.com> 
27.04.2006 02:05

To
linux-kernel@vger.kernel.org
cc
mschwid2@de.ltcfwd.linux.ibm.com, Frank Pavlic/Germany/IBM@IBMDE
Subject
s390 lcs incorrect test






While debugging why our LCS emulator is having some problems I noticed
the following weirdness in drivers/s390/net/lcs.c routine lcs_irq:

--- lcs.c.orig           2006-04-24 16:20:24.000000000 -0400
+++ lcs.c                2006-04-26 19:56:45.000000000 -0400
@@ -1354,7 +1354,7 @@
                                 index = (struct ccw1 *) __va((addr_t) 
irb->scsw.cpa) 
                                                 - channel->ccws;
                                 if ((irb->scsw.actl & 
SCSW_ACTL_SUSPENDED) ||
-                                    (irb->scsw.cstat | SCHN_STAT_PCI))
+                                    (irb->scsw.cstat & SCHN_STAT_PCI))
                                                 /* Bloody io subsystem 
tells us lies about cpa... */
                                                 index = (index - 1) & 
(LCS_NUM_BUFFS - 1);
                                 while (channel->io_idx != index) {

The `if' statement is always true since SCHN_STAT_PCI is defined as
0x80.  Don't know if this has anything to do with our LCS problems but
thought I would pass it on.

Greg Smith




