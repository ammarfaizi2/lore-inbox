Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264571AbUIOJOq@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264571AbUIOJOq (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 15 Sep 2004 05:14:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264531AbUIOJOp
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 15 Sep 2004 05:14:45 -0400
Received: from cantor.suse.de ([195.135.220.2]:54682 "EHLO Cantor.suse.de")
	by vger.kernel.org with ESMTP id S264571AbUIOJMi (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 15 Sep 2004 05:12:38 -0400
Date: Wed, 15 Sep 2004 11:12:32 +0200
From: Andi Kleen <ak@suse.de>
To: George Anzinger <george@mvista.com>
Cc: Christoph Lameter <clameter@sgi.com>, john stultz <johnstul@us.ibm.com>,
       Albert Cahalan <albert@users.sourceforge.net>,
       lkml <linux-kernel@vger.kernel.org>, tim@physik3.uni-rostock.de,
       Ulrich.Windl@rz.uni-regensburg.de, Len Brown <len.brown@intel.com>,
       linux@dominikbrodowski.de, David Mosberger <davidm@hpl.hp.com>,
       Andi Kleen <ak@suse.de>, paulus@samba.org, schwidefsky@de.ibm.com,
       jimix@us.ibm.com, keith maanthey <kmannth@us.ibm.com>,
       greg kh <greg@kroah.com>, Patricia Gaughen <gone@us.ibm.com>,
       Chris McDermott <lcm@us.ibm.com>
Subject: Re: [RFC][PATCH] new timeofday core subsystem (v.A0)
Message-ID: <20040915091232.GA22158@wotan.suse.de>
References: <1094700768.29408.124.camel@cog.beaverton.ibm.com> <413FDC9F.1030409@mvista.com> <1094756870.29408.157.camel@cog.beaverton.ibm.com> <4140C1ED.4040505@mvista.com> <Pine.LNX.4.58.0409131420500.490@schroedinger.engr.sgi.com> <1095114307.29408.285.camel@cog.beaverton.ibm.com> <Pine.LNX.4.58.0409141045370.6963@schroedinger.engr.sgi.com> <41479369.6020506@mvista.com> <Pine.LNX.4.58.0409142024270.10739@schroedinger.engr.sgi.com> <4147F774.6000800@mvista.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <4147F774.6000800@mvista.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> I really think a tickless system, for other than UML systems, is a loosing 
> thing.  The accounting overhead on context switch (which increases as the 

You can run the accounting independently at much lower frequency (10ms is
perfectly fine as 2.4 has proven - i suspect even lower would be ok too) 
IMHO it should be a sysctl so that users can do a trade off between
power consumption and accounting accuracy.

And there is one important special that doesn't need any accounting
for user space at all: the idle loop. 
It still needs some way to account interrupts, but that could be done
in do_IRQ or also do with rather low frequency. 

-Andi
