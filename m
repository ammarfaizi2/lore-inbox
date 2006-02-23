Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932139AbWBWXti@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932139AbWBWXti (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 23 Feb 2006 18:49:38 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932141AbWBWXti
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 23 Feb 2006 18:49:38 -0500
Received: from ns2.suse.de ([195.135.220.15]:3461 "EHLO mx2.suse.de")
	by vger.kernel.org with ESMTP id S932139AbWBWXti (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 23 Feb 2006 18:49:38 -0500
To: Alan Stern <stern@rowland.harvard.edu>
Cc: sekharan@us.ibm.com, <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] The idle notifier chain should be atomic
References: <20060223110350.49c8b869.akpm@osdl.org>
	<Pine.LNX.4.44L0.0602231631560.7782-100000@iolanthe.rowland.org>
From: Andi Kleen <ak@suse.de>
Date: 24 Feb 2006 00:49:32 +0100
In-Reply-To: <Pine.LNX.4.44L0.0602231631560.7782-100000@iolanthe.rowland.org>
Message-ID: <p737j7l3ab7.fsf@verdi.suse.de>
User-Agent: Gnus/5.09 (Gnus v5.9.0) Emacs/21.3
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Alan Stern <stern@rowland.harvard.edu> writes:

> This patch (as658) makes the idle_notifier in x86_64 and idle_chain in
> s390 into atomic notifier chains rather than blocking chains.  This is
> necessary because they are called during IRQ handling as CPUs leave and
> enter the idle state.

Actually they aren't. While the code is called from the interrupt
handler logically it belong to the idle thread, not the interrupt handler.
They are only called when the interrupt directly interrupts the idle 
thread, so no atomicity needed.

-Andi

P.S.: Please cc maintainers in the future.

