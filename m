Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266029AbUA1U0P (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 28 Jan 2004 15:26:15 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266164AbUA1U0O
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 28 Jan 2004 15:26:14 -0500
Received: from ns.suse.de ([195.135.220.2]:5777 "EHLO Cantor.suse.de")
	by vger.kernel.org with ESMTP id S266029AbUA1U0H (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 28 Jan 2004 15:26:07 -0500
Date: Wed, 28 Jan 2004 21:19:59 +0100
From: Andi Kleen <ak@suse.de>
To: Andi Kleen <ak@suse.de>
Cc: torvalds@osdl.org, willy@debian.org, ishii.hironobu@jp.fujitsu.com,
       linux-kernel@vger.kernel.org, linux-ia64@vger.kernel.org
Subject: Re: [RFC/PATCH, 2/4] readX_check() performance evaluation II
Message-Id: <20040128211959.0d367c30.ak@suse.de>
In-Reply-To: <20040128211554.0cc890fb.ak@suse.de>
References: <00a301c3e541$c13a6350$2987110a@lsd.css.fujitsu.com>
	<Pine.LNX.4.58.0401271847440.10794@home.osdl.org>
	<20040128182003.GL11844@parcelfarce.linux.theplanet.co.uk>
	<Pine.LNX.4.58.0401281129570.28145@home.osdl.org>
	<20040128204049.627e6312.ak@suse.de>
	<Pine.LNX.4.58.0401281205250.28145@home.osdl.org>
	<20040128211554.0cc890fb.ak@suse.de>
X-Mailer: Sylpheed version 0.9.7 (GTK+ 1.2.10; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 28 Jan 2004 21:15:54 +0100
Andi Kleen <ak@suse.de> wrote:

>
> > 
> > Just set a flag aka "may need checking", and let the check be done by the 
> > actual "read_pcix_error()" code.
> 
> Where would you put the flag? 
> 
> Doing it global may give false errors for the wrong device with async MCEs
> and on SMP.
> 
> For putting it into the pci_dev you need to take logs to walk the list.
> If you delay it to a softirq for safely getting the lock it would be set too late.
> 
> Putting it into a different table indexed by pci index would be also racy 
> with hotplug.

... to follow up myself ...

I suppose moving the pci_dev lists to RCU could make the flag in pci-dev work. But it would be still
a bit tricky with preemptive kernels.

-Andi
