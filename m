Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932076AbVKWQtT@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932076AbVKWQtT (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 23 Nov 2005 11:49:19 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932078AbVKWQtT
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 23 Nov 2005 11:49:19 -0500
Received: from clock-tower.bc.nu ([81.2.110.250]:25319 "EHLO
	lxorguk.ukuu.org.uk") by vger.kernel.org with ESMTP id S932076AbVKWQtR
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 23 Nov 2005 11:49:17 -0500
Subject: Re: [patch] SMP alternatives
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: Andi Kleen <ak@suse.de>
Cc: Gerd Knorr <kraxel@suse.de>, Linus Torvalds <torvalds@osdl.org>,
       Dave Jones <davej@redhat.com>, Zachary Amsden <zach@vmware.com>,
       Pavel Machek <pavel@ucw.cz>, Andrew Morton <akpm@osdl.org>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       "H. Peter Anvin" <hpa@zytor.com>,
       Zwane Mwaikambo <zwane@arm.linux.org.uk>,
       Pratap Subrahmanyam <pratap@vmware.com>,
       Christopher Li <chrisl@vmware.com>,
       "Eric W. Biederman" <ebiederm@xmission.com>,
       Ingo Molnar <mingo@elte.hu>
In-Reply-To: <20051123163906.GF20775@brahms.suse.de>
References: <Pine.LNX.4.64.0511131118020.3263@g5.osdl.org>
	 <Pine.LNX.4.64.0511131210570.3263@g5.osdl.org> <4378A7F3.9070704@suse.de>
	 <Pine.LNX.4.64.0511141118000.3263@g5.osdl.org> <4379ECC1.20005@suse.de>
	 <437A0649.7010702@suse.de> <437B5A83.8090808@suse.de>
	 <438359D7.7090308@suse.de> <p7364qjjhqx.fsf@verdi.suse.de>
	 <1132764133.7268.51.camel@localhost.localdomain>
	 <20051123163906.GF20775@brahms.suse.de>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Date: Wed, 23 Nov 2005 17:21:29 +0000
Message-Id: <1132766489.7268.71.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.3 (2.2.3-2.fc4) 
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mer, 2005-11-23 at 17:39 +0100, Andi Kleen wrote:
> I much prefer the MSR bit too. Unfortunately it doesn't exist
> (or rather I bet it exists somewhere, just undocumented) on Intel 
> systems.

The MSR bits will break things like ECC scrubbing however. That can be
addressed although the test patch I have just refuses to load EDAC if
the BIOS writers didn't follow the BIOS guidelines.

Certainly it would be cleaner and easier to save the MSR, scrub and put
it back than do the fixup magic. Some drivers would need auditing as
they seem to use locked ops or xchg (implicit lock) to lock with a PCI
DMA master.

