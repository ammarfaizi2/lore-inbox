Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932590AbVKWWWV@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932590AbVKWWWV (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 23 Nov 2005 17:22:21 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932589AbVKWWWU
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 23 Nov 2005 17:22:20 -0500
Received: from smtp.osdl.org ([65.172.181.4]:35231 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S932586AbVKWWWS (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 23 Nov 2005 17:22:18 -0500
Date: Wed, 23 Nov 2005 14:21:53 -0800 (PST)
From: Linus Torvalds <torvalds@osdl.org>
To: "H. Peter Anvin" <hpa@zytor.com>
cc: Daniel Jacobowitz <dan@debian.org>, Alan Cox <alan@lxorguk.ukuu.org.uk>,
       Andi Kleen <ak@suse.de>, Gerd Knorr <kraxel@suse.de>,
       Dave Jones <davej@redhat.com>, Zachary Amsden <zach@vmware.com>,
       Pavel Machek <pavel@ucw.cz>, Andrew Morton <akpm@osdl.org>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Zwane Mwaikambo <zwane@arm.linux.org.uk>,
       Pratap Subrahmanyam <pratap@vmware.com>,
       Christopher Li <chrisl@vmware.com>,
       "Eric W. Biederman" <ebiederm@xmission.com>,
       Ingo Molnar <mingo@elte.hu>
Subject: Re: [patch] SMP alternatives
In-Reply-To: <4384E880.4060305@zytor.com>
Message-ID: <Pine.LNX.4.64.0511231419310.13959@g5.osdl.org>
References: <1132764133.7268.51.camel@localhost.localdomain>
 <20051123163906.GF20775@brahms.suse.de> <1132766489.7268.71.camel@localhost.localdomain>
 <Pine.LNX.4.64.0511230858180.13959@g5.osdl.org> <4384AECC.1030403@zytor.com>
 <Pine.LNX.4.64.0511231031350.13959@g5.osdl.org> <1132782245.13095.4.camel@localhost.localdomain>
 <Pine.LNX.4.64.0511231331040.13959@g5.osdl.org> <20051123214835.GA24044@nevyn.them.org>
 <4384E4F7.9060806@zytor.com> <20051123220324.GA24517@nevyn.them.org>
 <4384E880.4060305@zytor.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Wed, 23 Nov 2005, H. Peter Anvin wrote:
> 
> Yes.  Any shared mmaps may require working lock.

Not "any". Only writable shared mmap. Which is actually the rare case.

Even then, we might want to have such processes have a way to say "I don't 
do futexes in this mmap" or similar. Quite often, writable shared mmaps 
aren't interested in locked cycles - they are there to just write things 
to disk, and all the serialization is done in the kernel when the user 
does a "munmap()" or a "msync()".

		Linus
