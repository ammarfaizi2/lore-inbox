Return-Path: <linux-kernel-owner+willy=40w.ods.org-S265684AbUFDJmH@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265684AbUFDJmH (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 4 Jun 2004 05:42:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265691AbUFDJmG
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 4 Jun 2004 05:42:06 -0400
Received: from mx2.elte.hu ([157.181.151.9]:1477 "EHLO mx2.elte.hu")
	by vger.kernel.org with ESMTP id S265684AbUFDJi4 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 4 Jun 2004 05:38:56 -0400
Date: Fri, 4 Jun 2004 11:39:58 +0200
From: Ingo Molnar <mingo@elte.hu>
To: Brian Gerst <bgerst@didntduck.org>
Cc: Linus Torvalds <torvalds@osdl.org>, linux-kernel@vger.kernel.org,
       Andrew Morton <akpm@osdl.org>, Andi Kleen <ak@suse.de>,
       Arjan van de Ven <arjanv@redhat.com>,
       "Siddha, Suresh B" <suresh.b.siddha@intel.com>,
       "Nakajima, Jun" <jun.nakajima@intel.com>
Subject: Re: [announce] [patch] NX (No eXecute) support for x86, 2.6.7-rc2-bk2
Message-ID: <20040604093958.GE11034@elte.hu>
References: <20040602205025.GA21555@elte.hu> <Pine.LNX.4.58.0406021411030.3403@ppc970.osdl.org> <20040603072146.GA14441@elte.hu> <40BF201F.2020701@quark.didntduck.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <40BF201F.2020701@quark.didntduck.org>
User-Agent: Mutt/1.4.1i
X-ELTE-SpamVersion: MailScanner 4.26.8-itk2 (ELTE 1.1) SpamAssassin 2.63 ClamAV 0.65
X-ELTE-VirusStatus: clean
X-ELTE-SpamCheck: no
X-ELTE-SpamCheck-Details: score=-4.9, required 5.9,
	autolearn=not spam, BAYES_00 -4.90
X-ELTE-SpamLevel: 
X-ELTE-SpamScore: -4
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


* Brian Gerst <bgerst@didntduck.org> wrote:

> Wine breaks because of the part of exec-shield that relocates shared
> libs to low addresses, where the (stripped) Windows binaries expect to
> be loaded at.  NX stack doesn't affect it.

I think Wine could get around this by creating a dummy ELF section in
the Wine binary that covers the first 1GB or so. Wine could still use
ordinary dynamic libraries - those would go above that 1GB. Then once
Wine has loaded up it can munmap() that first 1GB.

(this would not work if Wine has to dlopen() new libraries after this
phase - does that happen?)

	Ingo
