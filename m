Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262197AbVATQdr@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262197AbVATQdr (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 20 Jan 2005 11:33:47 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262249AbVATQTx
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 20 Jan 2005 11:19:53 -0500
Received: from bluebox.CS.Princeton.EDU ([128.112.136.38]:34949 "EHLO
	bluebox.CS.Princeton.EDU") by vger.kernel.org with ESMTP
	id S262217AbVATQPM (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 20 Jan 2005 11:15:12 -0500
From: "Marc E. Fiuczynski" <mef@CS.Princeton.EDU>
To: "Peter Williams" <pwil3058@bigpond.net.au>,
       "Linux Kernel Mailing List" <linux-kernel@vger.kernel.org>
Cc: "Con Kolivas" <kernel@kolivas.org>, "Chris Han" <xiphux@gmail.com>
Subject: RE: [ANNOUNCE][RFC] plugsched-2.0 patches ...
Date: Thu, 20 Jan 2005 11:14:48 -0500
Message-ID: <NIBBJLJFDHPDIBEEKKLPGELGDHAA.mef@cs.princeton.edu>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
X-Priority: 3 (Normal)
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook IMO, Build 9.0.2416 (9.0.2910.0)
X-MimeOLE: Produced By Microsoft MimeOLE V5.00.2314.1300
Importance: Normal
In-Reply-To: <41EF080D.7020101@bigpond.net.au>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Peter, thank you for maintaining Con's plugsched code in light of Linus' and
Ingo's prior objections to this idea.  On the one hand, I partially agree
with Linus&Ingo's prior views that when there is only one scheduler that the
rest of the world + dog will focus on making it better. On the other hand,
having a clean framework that lets developers in a clean way plug in new
schedulers is quite useful.

Linus & Ingo, it would be good to have an indepth discussion on this topic.
I'd argue that the Linux kernel NEEDS a clean pluggable scheduling
framework.

Let me make a case for this NEED by example.  Ingo's scheduler belongs to
the egalitarian regime of schedulers that do a poor job of isolating
workloads from each other in multiprogrammed environments such as those
found on Enterprise servers and in my case on PlanetLab (www.planet-lab.org)
nodes.  This has been rectified by HP-UX, Solaris, and AIX through the use
of fair share schedulers that use O(1) schedulers within a share.  Currently
PlanetLab uses a CKRM modified version of Ingo's scheduler.  Similarly, the
linux-vserver project also modifies Ingo's scheduler to construct an
entitlement based scheduling regime. These are not just variants of O(1)
schedulers in the sense of Con's staircase O(1). Nor is it clear what the
best type of scheduler is for these environments (i.e., HP-UX, Solaris and
AIX don't have it fully solved yet either). The ability to dynamically swap
out schedulers on a production system like PlanetLab would help in
determining what type of scheduler is the most appropriate.  This is because
it is non-trivial, if not impossible, to recreate the multiprogrammed
workloads that we see in a lab.

For these reasons, it would be useful for plugsched (or something like it)
to make its way into the mainline kernel as a framework to plug in different
schedulers.  Alternatively, it would be useful to consider in what way
Ingo's scheduler needs to support plugins such as the CKRM and Vserver types
of changes.

Best regards,
Marc

