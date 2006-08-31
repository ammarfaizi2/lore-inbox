Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751275AbWHaIME@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751275AbWHaIME (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 31 Aug 2006 04:12:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751276AbWHaIME
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 31 Aug 2006 04:12:04 -0400
Received: from 85.8.24.16.se.wasadata.net ([85.8.24.16]:4491 "EHLO
	smtp.drzeus.cx") by vger.kernel.org with ESMTP id S1751275AbWHaIMC
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 31 Aug 2006 04:12:02 -0400
Message-ID: <44F699CE.8050803@drzeus.cx>
Date: Thu, 31 Aug 2006 10:11:58 +0200
From: Pierre Ossman <drzeus-list@drzeus.cx>
User-Agent: Thunderbird 1.5.0.5 (X11/20060803)
MIME-Version: 1.0
To: LKML <linux-kernel@vger.kernel.org>
Subject: When to use mmiowb()?
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I'm been trying to wrap my head around all this memory barrier business,
and I'm slowly grasping the inter-CPU behaviours. Barriers with regard
to devices still has me a bit confused though.

The deviceiobook document and memory-barriers.txt both make it clear
that memory operations to devices are strictly ordered from a single
CPU. When more CPUs are involved, things get a bit fuzzier.
memory-barriers.txt seems to suggest that mmiowb() is only needed before
an unlock under special circumstances, but deviceiobook states that
mmiowb() should be used before all unlocks where the writeX():s aren't
followed by a readX() (which would flush the writes anyway).

Grepping the tree indicates that mmiowb() isn't used that often, but
according to deviceiobook, they should be plentiful. This leads me to
believe that memory-barriers.txt is closer to the truth, but then the
question is what those special cirumstances that require mmiowb() are.

Any clarifications you can provide are very welcome. :)

Rgds
Pierre
