Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030572AbVKXBCi@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030572AbVKXBCi (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 23 Nov 2005 20:02:38 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030574AbVKXBCh
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 23 Nov 2005 20:02:37 -0500
Received: from mail.dvmed.net ([216.237.124.58]:23943 "EHLO mail.dvmed.net")
	by vger.kernel.org with ESMTP id S1030572AbVKXBCg (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 23 Nov 2005 20:02:36 -0500
Message-ID: <43851116.9060103@pobox.com>
Date: Wed, 23 Nov 2005 20:02:14 -0500
From: Jeff Garzik <jgarzik@pobox.com>
User-Agent: Mozilla Thunderbird 1.0.7-1.1.fc4 (X11/20050929)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Linus Torvalds <torvalds@osdl.org>
CC: Daniel Jacobowitz <dan@debian.org>, Alan Cox <alan@lxorguk.ukuu.org.uk>,
       "H. Peter Anvin" <hpa@zytor.com>, Andi Kleen <ak@suse.de>,
       Gerd Knorr <kraxel@suse.de>, Dave Jones <davej@redhat.com>,
       Zachary Amsden <zach@vmware.com>, Pavel Machek <pavel@ucw.cz>,
       Andrew Morton <akpm@osdl.org>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Zwane Mwaikambo <zwane@arm.linux.org.uk>,
       Pratap Subrahmanyam <pratap@vmware.com>,
       Christopher Li <chrisl@vmware.com>,
       "Eric W. Biederman" <ebiederm@xmission.com>,
       Ingo Molnar <mingo@elte.hu>
Subject: Re: [patch] SMP alternatives
References: <1132764133.7268.51.camel@localhost.localdomain> <20051123163906.GF20775@brahms.suse.de> <1132766489.7268.71.camel@localhost.localdomain> <Pine.LNX.4.64.0511230858180.13959@g5.osdl.org> <4384AECC.1030403@zytor.com> <Pine.LNX.4.64.0511231031350.13959@g5.osdl.org> <1132782245.13095.4.camel@localhost.localdomain> <Pine.LNX.4.64.0511231331040.13959@g5.osdl.org> <20051123214835.GA24044@nevyn.them.org> <Pine.LNX.4.64.0511231416490.13959@g5.osdl.org> <20051123222056.GA25078@nevyn.them.org> <Pine.LNX.4.64.0511231502250.13959@g5.osdl.org>
In-Reply-To: <Pine.LNX.4.64.0511231502250.13959@g5.osdl.org>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Score: 0.1 (/)
X-Spam-Report: Spam detection software, running on the system "srv2.dvmed.net", has
	identified this incoming email as possible spam.  The original message
	has been attached to this so you can view it (if it isn't spam) or label
	similar future email.  If you have any questions, see
	the administrator of that system for details.
	Content preview:  Linus Torvalds wrote: > The third alternative is to
	know at link-time that the process never does > anything threaded, but
	that needs more developer attention and > non-standard setups, and you
	_will_ get it wrong (some library will create > some thread without the
	developer even realizing). It also has the > duplicated library
	overhead (but at least now the duplication is just > twice, not "each
	process duplicates its own private pointer") [...] 
	Content analysis details:   (0.1 points, 5.0 required)
	pts rule name              description
	---- ---------------------- --------------------------------------------------
	0.1 RCVD_IN_SORBS_DUL      RBL: SORBS: sent directly from dynamic IP address
	[69.134.188.146 listed in dnsbl.sorbs.net]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Linus Torvalds wrote:
> The third alternative is to know at link-time that the process never does 
> anything threaded, but that needs more developer attention and 
> non-standard setups, and you _will_ get it wrong (some library will create 
> some thread without the developer even realizing). It also has the 
> duplicated library overhead (but at least now the duplication is just 
> twice, not "each process duplicates its own private pointer")

Small data point:  In a lot of gcc-related build processes, the 
configure/makefile junk passes '-pthread' to the compiler/linker.

So a lot of programs in Linux distros are already built this way.  The 
bigger problem is with libraries, which cannot know ahead of time 
whether the app is threaded or not, and therefore must assume threaded.

A few libs do things like glibc, others (like GLib) have an explicit 
mylib_thread_init() called at program startup.

	Jeff


