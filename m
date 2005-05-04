Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261808AbVEDNbU@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261808AbVEDNbU (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 4 May 2005 09:31:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261818AbVEDNbU
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 4 May 2005 09:31:20 -0400
Received: from ppp-217-133-42-200.cust-adsl.tiscali.it ([217.133.42.200]:25676
	"EHLO opteron.random") by vger.kernel.org with ESMTP
	id S261808AbVEDNbS (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 4 May 2005 09:31:18 -0400
Date: Wed, 4 May 2005 15:31:29 +0200
From: Andrea Arcangeli <andrea@suse.de>
To: "Rafael J. Wysocki" <rjw@sisk.pl>
Cc: Andi Kleen <ak@suse.de>, Andrew Morton <akpm@osdl.org>,
       linux-kernel@vger.kernel.org
Subject: Re: avoid infinite loop in x86_64 interrupt return
Message-ID: <20050504133129.GD3899@opteron.random>
References: <20050504050132.GA3899@opteron.random> <200505041100.33099.rjw@sisk.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200505041100.33099.rjw@sisk.pl>
X-GPG-Key: 1024D/68B9CB43 13D9 8355 295F 4823 7C49  C012 DFA1 686E 68B9 CB43
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, May 04, 2005 at 11:00:32AM +0200, Rafael J. Wysocki wrote:
> You also need to add two missing clis.  Please have a look at the attached
> patch from Andi.

Those two clis seems unrelated, so I don't see why I should mix them in
the same patch. I couldn't trigger the other problems, only the one with
rdi corruption.

Note that those clis seems superflous, cli is only needed before swapgs,
so adding cli before swapgs in retint_swapgs sounds a better idea than
to keep irq off for a longer time for no apparent good reason. But I've
no real idea why those cli are needed so I guess I must be missing
something. there's no commentary attached to your patch that can exlain
why the cli are needed _way_ before calling swapgs.
