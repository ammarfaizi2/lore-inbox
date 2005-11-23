Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932542AbVKWVhJ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932542AbVKWVhJ (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 23 Nov 2005 16:37:09 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932543AbVKWVhI
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 23 Nov 2005 16:37:08 -0500
Received: from mail.suse.de ([195.135.220.2]:13207 "EHLO mx1.suse.de")
	by vger.kernel.org with ESMTP id S932542AbVKWVhF (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 23 Nov 2005 16:37:05 -0500
Date: Wed, 23 Nov 2005 22:36:53 +0100
From: Andi Kleen <ak@suse.de>
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: Andi Kleen <ak@suse.de>, Linus Torvalds <torvalds@osdl.org>,
       "H. Peter Anvin" <hpa@zytor.com>, Gerd Knorr <kraxel@suse.de>,
       Dave Jones <davej@redhat.com>, Zachary Amsden <zach@vmware.com>,
       Pavel Machek <pavel@ucw.cz>, Andrew Morton <akpm@osdl.org>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Zwane Mwaikambo <zwane@arm.linux.org.uk>,
       Pratap Subrahmanyam <pratap@vmware.com>,
       Christopher Li <chrisl@vmware.com>,
       "Eric W. Biederman" <ebiederm@xmission.com>,
       Ingo Molnar <mingo@elte.hu>
Subject: Re: [patch] SMP alternatives
Message-ID: <20051123213652.GS20775@brahms.suse.de>
References: <p7364qjjhqx.fsf@verdi.suse.de> <1132764133.7268.51.camel@localhost.localdomain> <20051123163906.GF20775@brahms.suse.de> <1132766489.7268.71.camel@localhost.localdomain> <Pine.LNX.4.64.0511230858180.13959@g5.osdl.org> <4384AECC.1030403@zytor.com> <Pine.LNX.4.64.0511231031350.13959@g5.osdl.org> <1132782245.13095.4.camel@localhost.localdomain> <20051123211353.GR20775@brahms.suse.de> <1132783540.13095.23.camel@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1132783540.13095.23.camel@localhost.localdomain>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Nov 23, 2005 at 10:05:40PM +0000, Alan Cox wrote:
> > Might be a bit costly to rewrite all the page tables for that case
> > just to change the PAT index.  A bit is nicer for that.
> 
> CPU insert/remove is performed how many times a second ? Or for that
> matter why not just reload the PAT register and keep the index the
> same ?

For user space the primary trigger event would be "has any shared
writable mappings or multiple threads". Even on a real MP systems it's 
perfectly ok to run a program with no writable shared mappings with LOCK off.
Depending on the workload this transistion could happen quite often.
Especially there is a worst case of an application allocating a few
GB of memory and then starting a new thread.

-Andi
