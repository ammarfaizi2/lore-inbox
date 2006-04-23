Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751316AbWDWFwh@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751316AbWDWFwh (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 23 Apr 2006 01:52:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751326AbWDWFwh
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 23 Apr 2006 01:52:37 -0400
Received: from dsl027-180-168.sfo1.dsl.speakeasy.net ([216.27.180.168]:22747
	"EHLO sunset.davemloft.net") by vger.kernel.org with ESMTP
	id S1751316AbWDWFwg convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 23 Apr 2006 01:52:36 -0400
Date: Sat, 22 Apr 2006 22:52:34 -0700 (PDT)
Message-Id: <20060422.225234.36558278.davem@davemloft.net>
To: ioe-lkml@rameria.de
Cc: joern@wohnheim.fh-wedel.de, netdev@axxeo.de, simlo@phys.au.dk,
       linux-kernel@vger.kernel.org, mingo@elte.hu, netdev@vger.kernel.org
Subject: Re: Van Jacobson's net channels and real-time
From: "David S. Miller" <davem@davemloft.net>
In-Reply-To: <200604221529.59899.ioe-lkml@rameria.de>
References: <200604211852.47335.netdev@axxeo.de>
	<20060422114846.GA6629@wohnheim.fh-wedel.de>
	<200604221529.59899.ioe-lkml@rameria.de>
X-Mailer: Mew version 4.2.53 on Emacs 21.4 / Mule 5.0 (SAKAKI)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=iso-8859-1
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

From: Ingo Oeser <ioe-lkml@rameria.de>
Date: Sat, 22 Apr 2006 15:29:58 +0200

> On Saturday, 22. April 2006 13:48, Jörn Engel wrote:
> > Unless I completely misunderstand something, one of the main points of
> > the netchannels if to have *zero* fields written to by both producer
> > and consumer. 
> 
> Hmm, for me the main point was to keep the complete processing
> of a single packet within one CPU/Core where this is a non-issue.

Both are the important issues.

You move the bulk of the packet processing work to the end
cores of the system, yes.  But you do so with an enormously
SMP friendly queue data structure so that it does not matter
at all that the packet is received on one cpu, yet processed
in socket context on another.

If you elide either part of the implementation, you miss the
entire point of net channels.
