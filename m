Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261798AbVASReX@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261798AbVASReX (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 19 Jan 2005 12:34:23 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261802AbVASRcU
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 19 Jan 2005 12:32:20 -0500
Received: from canuck.infradead.org ([205.233.218.70]:46854 "EHLO
	canuck.infradead.org") by vger.kernel.org with ESMTP
	id S261796AbVASRbs (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 19 Jan 2005 12:31:48 -0500
Subject: Re: [PATCH] dynamic tick patch
From: Arjan van de Ven <arjan@infradead.org>
To: Tony Lindgren <tony@atomide.com>
Cc: Pavel Machek <pavel@suse.cz>, George Anzinger <george@mvista.com>,
       john stultz <johnstul@us.ibm.com>, Andrea Arcangeli <andrea@suse.de>,
       Zwane Mwaikambo <zwane@arm.linux.org.uk>,
       Con Kolivas <kernel@kolivas.org>,
       Martin Schwidefsky <schwidefsky@de.ibm.com>,
       linux-kernel@vger.kernel.org
In-Reply-To: <20050119171106.GA14545@atomide.com>
References: <20050119000556.GB14749@atomide.com>
	 <20050119113642.GA1358@elf.ucw.cz>  <20050119171106.GA14545@atomide.com>
Content-Type: text/plain
Date: Wed, 19 Jan 2005 18:30:49 +0100
Message-Id: <1106155850.6310.161.camel@laptopd505.fenrus.org>
Mime-Version: 1.0
X-Mailer: Evolution 2.0.2 (2.0.2-3) 
Content-Transfer-Encoding: 7bit
X-Spam-Score: 4.1 (++++)
X-Spam-Report: SpamAssassin version 2.63 on canuck.infradead.org summary:
	Content analysis details:   (4.1 points, 5.0 required)
	pts rule name              description
	---- ---------------------- --------------------------------------------------
	0.3 RCVD_NUMERIC_HELO      Received: contains a numeric HELO
	1.1 RCVD_IN_DSBL           RBL: Received via a relay in list.dsbl.org
	[<http://dsbl.org/listing?80.57.133.107>]
	2.5 RCVD_IN_DYNABLOCK      RBL: Sent directly from dynamic IP address
	[80.57.133.107 listed in dnsbl.sorbs.net]
	0.1 RCVD_IN_SORBS          RBL: SORBS: sender is listed in SORBS
	[80.57.133.107 listed in dnsbl.sorbs.net]
X-SRS-Rewrite: SMTP reverse-path rewritten from <arjan@infradead.org> by canuck.infradead.org
	See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2005-01-19 at 09:11 -0800, Tony Lindgren wrote:
> * Pavel Machek <pavel@suse.cz> [050119 03:32]:
> > Hi!
> > 
> > > As this patch is related to the VST/High-Res timers, there
> > > are probably various things that can be merged. I have not
> > > yet looked at what all could be merged.
> > > 
> > > I'd appreciate some comments and testing!
> > 
> > Good news is that it does seem to reduce number of interrupts. Bad
> > news is that time now runs faster (like "sleep 10" finishes in ~5
> > seconds) and that I could not measure any difference in power
> > consumption.
> 
> Thanks for trying it out. I have quite accurate time here on my
> systems, and sleep works as it should. I wonder what's happening on
> your system? If you have a chance, could you please post the results
> from following simple tests?

tsc is dangerous for this btw; several cpus go either slower or stop tsc
entirely during hlt... eg when idle.
I would suggest to not include a tsc driver for this (otherwise really
cool) feature.


