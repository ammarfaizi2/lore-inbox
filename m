Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751155AbVKAU3T@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751155AbVKAU3T (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 1 Nov 2005 15:29:19 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751135AbVKAU3T
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 1 Nov 2005 15:29:19 -0500
Received: from smtp105.sbc.mail.mud.yahoo.com ([68.142.198.204]:37284 "HELO
	smtp105.sbc.mail.mud.yahoo.com") by vger.kernel.org with SMTP
	id S1751128AbVKAU3R (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 1 Nov 2005 15:29:17 -0500
From: David Brownell <david-b@pacbell.net>
To: Borislav Petkov <bbpetkov@yahoo.de>
Subject: Re: Linux 2.6.14 ehci-hcd hangs machine
Date: Tue, 1 Nov 2005 10:18:04 -0800
User-Agent: KMail/1.7.1
Cc: Aleksey Gorelov <Aleksey_Gorelov@Phoenix.com>,
       Linus Torvalds <torvalds@osdl.org>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       greg@kroah.com
References: <0EF82802ABAA22479BC1CE8E2F60E8C376CE22@scl-exch2k3.phoenix.com> <200510311624.31680.david-b@pacbell.net> <20051101112321.GA8691@gollum.tnic>
In-Reply-To: <20051101112321.GA8691@gollum.tnic>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200511011018.05117.david-b@pacbell.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tuesday 01 November 2005 3:23 am, Borislav Petkov wrote:
> Yeah, the symptoms are really weird. Let me rehash the whole history:
> First, we did some testing with 2.6.14-rc4, _with_ the patch and the
> 'handoff' cmd option and it worked. Then, several boots later, I noticed
> that it started hanging itself again at the same position not while rebooting 
> but at _initial_ boot in the morning. ...

So you're saying your hardware doesn't act consistently.
Is there a BIOS update you can try?  The failure sure seems
to be board-specific.


> ... 2.6.13, in contrast, boots just fine. Hope
> that helps,

Well that's news, and not mentioned in the bug report; in fact, you
said explicitly that it _never_ worked on earlier kernels (see your
comment #2).

This means you could use "git bisect" to point a finger at a patch that,
if it doesn't actually cause the problem, at least surfaces a latent bug
in other code.  Could you please try that?

I'm starting to suspect some IRQ setup problem here; those are classically
issues in ACPI code, even when the breakage shows only with USB.

- Dave
