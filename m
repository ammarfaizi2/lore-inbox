Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264652AbUFCXIh@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264652AbUFCXIh (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 3 Jun 2004 19:08:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264655AbUFCXIh
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 3 Jun 2004 19:08:37 -0400
Received: from cantor.suse.de ([195.135.220.2]:19639 "EHLO Cantor.suse.de")
	by vger.kernel.org with ESMTP id S264652AbUFCXIf (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 3 Jun 2004 19:08:35 -0400
Date: Fri, 4 Jun 2004 01:08:34 +0200
From: Andi Kleen <ak@suse.de>
To: Andy Lutomirski <luto@myrealbox.com>
Cc: Andi Kleen <ak@suse.de>, mingo@elte.hu, torvalds@osdl.org,
       linux-kernel@vger.kernel.org, akpm@osdl.org, arjanv@redhat.com,
       suresh.b.siddha@intel.com, jun.nakajima@intel.com
Subject: Re: [announce] [patch] NX (No eXecute) support for x86,   2.6.7-rc2-bk2
Message-ID: <20040603230834.GF868@wotan.suse.de>
References: <20040602205025.GA21555@elte.hu> <Pine.LNX.4.58.0406021411030.3403@ppc970.osdl.org> <20040603072146.GA14441@elte.hu> <20040603124448.GA28775@elte.hu> <20040603175422.4378d901.ak@suse.de> <40BFADE5.9040506@myrealbox.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <40BFADE5.9040506@myrealbox.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jun 03, 2004 at 04:01:57PM -0700, Andy Lutomirski wrote:
> Andi Kleen wrote:
> >On Thu, 3 Jun 2004 14:44:48 +0200
> >Ingo Molnar <mingo@elte.hu> wrote:
> >
> >
> >
> >>- in exec.c, since address-space executability is a security-relevant
> >>item, we must clear the personality when we exec a setuid binary. I
> >>believe this is also a (small) security robustness fix for current
> >>64-bit architectures.
> >
> >
> >I'm not sure I like that. This means I cannot earily force an i386 uname 
> >or 3GB address space on suid programs anymore on x86-64.
> >
> >While in theory it could be a small security problem I think the utility
> >is much greater.
> >
> >It's hard to see how setting NX could cause a security hole. The program
> >may crash, but it is unlikely to be exploitable.
> 
> The whole point of NX, though, is that it prevents certain classes of 
> exploits.  If a setuid binary is vulnerable to one of these, then Ingo's 
> patch "fixes" it.  Your approach breaks that.

Good point.

But that only applies to the NX personality bit. For the uname emulation
it is not an issue.

So maybe the dropping on exec should only zero a few selected 
personality bits, but not all.

> 
> I don't like Ingo's fix either, though.  At least it should check 
> CAP_PTRACE or some such.  A better fix would be for LSM to pass down a flag 
> indicating a change of security context.  I'll throw that in to my 
> caps/apply_creds cleanup, in case that ever gets applied.

Don't think we should require an LSM module for that. That's 
far overkill.

-Andi
