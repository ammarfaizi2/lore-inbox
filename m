Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262614AbVA0TLh@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262614AbVA0TLh (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 27 Jan 2005 14:11:37 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262624AbVA0TLg
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 27 Jan 2005 14:11:36 -0500
Received: from mx1.elte.hu ([157.181.1.137]:53385 "EHLO mx1.elte.hu")
	by vger.kernel.org with ESMTP id S262614AbVA0TLe (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 27 Jan 2005 14:11:34 -0500
Date: Thu, 27 Jan 2005 20:11:20 +0100
From: Ingo Molnar <mingo@elte.hu>
To: Pavel Machek <pavel@ucw.cz>
Cc: Arjan van de Ven <arjan@infradead.org>, linux-kernel@vger.kernel.org,
       akpm@osdl.org, torvalds@osdl.org
Subject: Re: Patch 1/6  introduce sysctl
Message-ID: <20050127191120.GA10460@elte.hu>
References: <20050127101117.GA9760@infradead.org> <20050127101201.GB9760@infradead.org> <20050127181525.GA4784@elf.ucw.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20050127181525.GA4784@elf.ucw.cz>
User-Agent: Mutt/1.4.1i
X-ELTE-SpamVersion: MailScanner 4.31.6-itk1 (ELTE 1.2) SpamAssassin 2.63 ClamAV 0.73
X-ELTE-VirusStatus: clean
X-ELTE-SpamCheck: no
X-ELTE-SpamCheck-Details: score=-4.9, required 5.9,
	autolearn=not spam, BAYES_00 -4.90
X-ELTE-SpamLevel: 
X-ELTE-SpamScore: -4
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


* Pavel Machek <pavel@ucw.cz> wrote:

> Hi!
> 
> > This first patch of the series introduces a sysctl (default off) that
> > enables/disables the randomisation feature globally. Since randomisation may
> > make it harder to debug really tricky situations (reproducability goes
> > down), the sysadmin needs a way to disable it globally.
> 
> Well, for distribution vendors, seeing "these reports from users are
> same error" will becoe harder, too, and sysctl can not help there :-(.

this is true to a limited degree, but it's only part of the picture. 
When we first introduced address-space randomisation in Fedora 1 (almost
2 years ago) we were worried about this effect too, very much in fact. 

What happened is that the _debugging infrastructure_ improved. Fedora
introduced debug-info packages, so that we dont get any raw dumps of
bugs anymore - what we get are nice symbolic backtraces which are easy
to match up against each other.

also, we already have this effect in the mainline kernel - on P4's the
stack is already randomized. Also, prelink (even the non-randomized
variant) already creates a per-machine VM layout of libraries.

so, i'm glad to report, it's a non-issue. Sometimes developers want to
disable randomisation during development (quick'n'easy hacks get quicker
and easier - e.g. if you watch an address within gdb), so having the
capability for unprivileged users to disable randomisation on the fly is
useful and Fedora certainly offers that, but from a support and
bug-reporting POV it's not a problem.

	Ingo
