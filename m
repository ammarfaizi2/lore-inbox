Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932649AbWF3Nla@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932649AbWF3Nla (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 30 Jun 2006 09:41:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932677AbWF3Nla
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 30 Jun 2006 09:41:30 -0400
Received: from cantor2.suse.de ([195.135.220.15]:21986 "EHLO mx2.suse.de")
	by vger.kernel.org with ESMTP id S932649AbWF3Nl3 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 30 Jun 2006 09:41:29 -0400
From: Andi Kleen <ak@suse.de>
To: eranian@hpl.hp.com
Subject: Re: [PATCH 10/17] 2.6.17.1 perfmon2 patch for review: PMU context switch
Date: Fri, 30 Jun 2006 15:41:22 +0200
User-Agent: KMail/1.9.3
Cc: linux-kernel@vger.kernel.org
References: <200606230913.k5N9D73v032387@frankl.hpl.hp.com> <p73bqsax0iu.fsf@verdi.suse.de> <20060630132901.GB22381@frankl.hpl.hp.com>
In-Reply-To: <20060630132901.GB22381@frankl.hpl.hp.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200606301541.22928.ak@suse.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


> So why do we need care about context switch in cpu-wide mode?
> It is because we support a mode where the idle thread is excluded
> from cpu-wide monitoring. This is very useful to distinguish 
> 'useful kernel work' from 'idle'. 

I don't quite see the point because on x86 the PMU doesn't run
during C states anyways. So you get idle excluded automatically.

And on the other hand a lot of people especially want idle
accounting too and boot with idle=poll. Your explicit 
code would likely defeat that.

> As you realize, that means 
> that we need to turn off when the idle thread is context switched
> in and turn it back on when it is switched off.

Also x86-64 has idle notifiers for this if you really wanted
to do it properly.

-Andi
