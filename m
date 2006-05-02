Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964867AbWEBPF3@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964867AbWEBPF3 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 2 May 2006 11:05:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964866AbWEBPF3
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 2 May 2006 11:05:29 -0400
Received: from smtp.osdl.org ([65.172.181.4]:54179 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S964868AbWEBPFK (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 2 May 2006 11:05:10 -0400
Date: Tue, 2 May 2006 08:05:01 -0700 (PDT)
From: Linus Torvalds <torvalds@osdl.org>
To: Neil Brown <neilb@suse.de>
cc: Alan Cox <alan@lxorguk.ukuu.org.uk>,
       Stephen Hemminger <shemminger@osdl.org>, Andrew Morton <akpm@osdl.org>,
       linux-kernel@vger.kernel.org
Subject: Re: better leve triggered IRQ management needed
In-Reply-To: <17494.59866.493671.504666@cse.unsw.edu.au>
Message-ID: <Pine.LNX.4.64.0605020804450.4086@g5.osdl.org>
References: <20060424114105.113eecac@localhost.localdomain>
 <1146345911.3302.36.camel@localhost.localdomain> <Pine.LNX.4.64.0604291453220.3701@g5.osdl.org>
 <17492.16811.469245.331326@cse.unsw.edu.au> <Pine.LNX.4.64.0604292204270.4616@g5.osdl.org>
 <17492.21870.649828.686244@cse.unsw.edu.au> <Pine.LNX.4.64.0604292343020.3690@g5.osdl.org>
 <17494.59866.493671.504666@cse.unsw.edu.au>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Tue, 2 May 2006, Neil Brown wrote:
> 
> Maybe the eisa_set_level_irq should be passed 'irq' rather than 'newirq' 
> ??

Yeah, stupid cut-and-paste error (the eisa_set_level_irq() call _is_ 
already there in the PCI irq setting, for the case where we actually have 
to set up routing that didn't exist before).

That's also why I'm a bit nervous even about my stupid one-liner patch: if 
the irq routing is already set up, and we just use the irq we're told to 
use, I'm not sure we should touch ELCR even if it "looks wrong". It 
obviously works on your machine, but I wonder what could break on others..

		Linus
