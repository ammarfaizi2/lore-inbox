Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262630AbVG2PxO@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262630AbVG2PxO (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 29 Jul 2005 11:53:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262636AbVG2PxC
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 29 Jul 2005 11:53:02 -0400
Received: from ebiederm.dsl.xmission.com ([166.70.28.69]:42375 "EHLO
	ebiederm.dsl.xmission.com") by vger.kernel.org with ESMTP
	id S262630AbVG2Pwt (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 29 Jul 2005 11:52:49 -0400
To: Andi Kleen <ak@suse.de>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [PATCH] x86_64: sync_tsc fix the race (so we can boot)
References: <m1slxz1ssn.fsf@ebiederm.dsl.xmission.com>
	<20050729074419.GB3726@bragg.suse.de>
From: ebiederm@xmission.com (Eric W. Biederman)
Date: Fri, 29 Jul 2005 09:52:40 -0600
In-Reply-To: <20050729074419.GB3726@bragg.suse.de> (Andi Kleen's message of
 "Fri, 29 Jul 2005 09:44:19 +0200")
Message-ID: <m1wtn94njr.fsf@ebiederm.dsl.xmission.com>
User-Agent: Gnus/5.1007 (Gnus v5.10.7) Emacs/21.4 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andi Kleen <ak@suse.de> writes:

> There are some style problems, but that can be fixed later.
>
> How did you track that nasty it down? 

I had a consistent reproducer.  

I ruled out hangs in the tsc sync code itself,
  by implementing timeouts in all of the loops.

I looked for differences with the ia64 code.

I noticed that sometimes the machine would reboot
and not just hang.

I implemented smp_call_function_single since that was what the ia64
code did.  It worked and all of my pieces of evidence just fell
together.

Eric
