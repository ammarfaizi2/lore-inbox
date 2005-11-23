Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932538AbVKWVdT@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932538AbVKWVdT (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 23 Nov 2005 16:33:19 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932539AbVKWVdS
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 23 Nov 2005 16:33:18 -0500
Received: from clock-tower.bc.nu ([81.2.110.250]:49793 "EHLO
	lxorguk.ukuu.org.uk") by vger.kernel.org with ESMTP id S932538AbVKWVdR
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 23 Nov 2005 16:33:17 -0500
Subject: Re: [patch] SMP alternatives
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: Andi Kleen <ak@suse.de>
Cc: Linus Torvalds <torvalds@osdl.org>, "H. Peter Anvin" <hpa@zytor.com>,
       Gerd Knorr <kraxel@suse.de>, Dave Jones <davej@redhat.com>,
       Zachary Amsden <zach@vmware.com>, Pavel Machek <pavel@ucw.cz>,
       Andrew Morton <akpm@osdl.org>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Zwane Mwaikambo <zwane@arm.linux.org.uk>,
       Pratap Subrahmanyam <pratap@vmware.com>,
       Christopher Li <chrisl@vmware.com>,
       "Eric W. Biederman" <ebiederm@xmission.com>,
       Ingo Molnar <mingo@elte.hu>
In-Reply-To: <20051123211353.GR20775@brahms.suse.de>
References: <437B5A83.8090808@suse.de> <438359D7.7090308@suse.de>
	 <p7364qjjhqx.fsf@verdi.suse.de>
	 <1132764133.7268.51.camel@localhost.localdomain>
	 <20051123163906.GF20775@brahms.suse.de>
	 <1132766489.7268.71.camel@localhost.localdomain>
	 <Pine.LNX.4.64.0511230858180.13959@g5.osdl.org>
	 <4384AECC.1030403@zytor.com>
	 <Pine.LNX.4.64.0511231031350.13959@g5.osdl.org>
	 <1132782245.13095.4.camel@localhost.localdomain>
	 <20051123211353.GR20775@brahms.suse.de>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Date: Wed, 23 Nov 2005 22:05:40 +0000
Message-Id: <1132783540.13095.23.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.3 (2.2.3-2.fc4) 
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mer, 2005-11-23 at 22:13 +0100, Andi Kleen wrote:
> The idea was to turn LOCK on only if the process has any
> shared writable mapping and num_online_cpus() > 0.

That makes a lot of sense, and if we hit hardware that does funky stuff
then the driver can set a 'vma needs lock' bit for the same effect.

> Might be a bit costly to rewrite all the page tables for that case
> just to change the PAT index.  A bit is nicer for that.

CPU insert/remove is performed how many times a second ? Or for that
matter why not just reload the PAT register and keep the index the
same ?

