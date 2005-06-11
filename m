Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261829AbVFKUwI@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261829AbVFKUwI (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 11 Jun 2005 16:52:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261831AbVFKUwI
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 11 Jun 2005 16:52:08 -0400
Received: from gateway-1237.mvista.com ([12.44.186.158]:48635 "EHLO
	dhcp153.mvista.com") by vger.kernel.org with ESMTP id S261829AbVFKUv7
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 11 Jun 2005 16:51:59 -0400
Date: Sat, 11 Jun 2005 13:51:47 -0700 (PDT)
From: Daniel Walker <dwalker@mvista.com>
To: Ingo Molnar <mingo@elte.hu>
cc: Esben Nielsen <simlo@phys.au.dk>, <linux-kernel@vger.kernel.org>,
       <sdietrich@mvista.com>
Subject: Re: [PATCH] local_irq_disable removal
In-Reply-To: <20050611200352.GA1477@elte.hu>
Message-ID: <Pine.LNX.4.44.0506111345400.12084-100000@dhcp153.mvista.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 11 Jun 2005, Ingo Molnar wrote:

> 
> * Esben Nielsen <simlo@phys.au.dk> wrote:
> 
> > > the jury is still out on the accuracy of those numbers. The test had 
> > > RT_DEADLOCK_DETECT (and other -RT debugging features) turned on, which 
> > > mostly work with interrupts disabled. The other question is how were 
> > > interrupt response times measured.
> > > 
> > You would accept a patch where I made this stuff optional?
> 
> I'm not sure why. The soft-flag based local_irq_disable() should in fact 
> be a tiny bit faster than the cli based approach, on a fair number of 
> CPUs. But it should definitely not be slower in any measurable way.


Interesting .. So "cli" takes 7 cycles , "sti" takes 7 cycles. The current 
method does "lea" which takes 1 cycle, and "or" which takes 1 cycle. I'm 
not sure if there is any function call overhead .. So the soft replacment 
of cli/sti is 70% faster on a per instruction level .. So it's at least 
not any slower .. Does everyone agree on that?

Daniel

