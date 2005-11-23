Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751302AbVKWXb3@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751302AbVKWXb3 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 23 Nov 2005 18:31:29 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751317AbVKWXb3
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 23 Nov 2005 18:31:29 -0500
Received: from ebiederm.dsl.xmission.com ([166.70.28.69]:59356 "EHLO
	ebiederm.dsl.xmission.com") by vger.kernel.org with ESMTP
	id S1751302AbVKWXb2 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 23 Nov 2005 18:31:28 -0500
To: Linus Torvalds <torvalds@osdl.org>
Cc: "H. Peter Anvin" <hpa@zytor.com>, Daniel Jacobowitz <dan@debian.org>,
       Alan Cox <alan@lxorguk.ukuu.org.uk>, Andi Kleen <ak@suse.de>,
       Gerd Knorr <kraxel@suse.de>, Dave Jones <davej@redhat.com>,
       Zachary Amsden <zach@vmware.com>, Pavel Machek <pavel@ucw.cz>,
       Andrew Morton <akpm@osdl.org>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Zwane Mwaikambo <zwane@arm.linux.org.uk>,
       Pratap Subrahmanyam <pratap@vmware.com>,
       Christopher Li <chrisl@vmware.com>, Ingo Molnar <mingo@elte.hu>
Subject: Re: [patch] SMP alternatives
References: <1132764133.7268.51.camel@localhost.localdomain>
	<20051123163906.GF20775@brahms.suse.de>
	<1132766489.7268.71.camel@localhost.localdomain>
	<Pine.LNX.4.64.0511230858180.13959@g5.osdl.org>
	<4384AECC.1030403@zytor.com>
	<Pine.LNX.4.64.0511231031350.13959@g5.osdl.org>
	<1132782245.13095.4.camel@localhost.localdomain>
	<Pine.LNX.4.64.0511231331040.13959@g5.osdl.org>
	<20051123214835.GA24044@nevyn.them.org> <4384E4F7.9060806@zytor.com>
	<20051123220324.GA24517@nevyn.them.org> <4384E880.4060305@zytor.com>
	<Pine.LNX.4.64.0511231419310.13959@g5.osdl.org>
From: ebiederm@xmission.com (Eric W. Biederman)
Date: Wed, 23 Nov 2005 16:29:02 -0700
In-Reply-To: <Pine.LNX.4.64.0511231419310.13959@g5.osdl.org> (Linus
 Torvalds's message of "Wed, 23 Nov 2005 14:21:53 -0800 (PST)")
Message-ID: <m1br0bhrk1.fsf@ebiederm.dsl.xmission.com>
User-Agent: Gnus/5.1007 (Gnus v5.10.7) Emacs/21.4 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Linus Torvalds <torvalds@osdl.org> writes:

> On Wed, 23 Nov 2005, H. Peter Anvin wrote:
>> 
>> Yes.  Any shared mmaps may require working lock.
>
> Not "any". Only writable shared mmap. Which is actually the rare case.
>
> Even then, we might want to have such processes have a way to say "I don't 
> do futexes in this mmap" or similar. Quite often, writable shared mmaps 
> aren't interested in locked cycles - they are there to just write things 
> to disk, and all the serialization is done in the kernel when the user 
> does a "munmap()" or a "msync()".

In fact for being explict we already have PROT_SEM on some architectures
to report if we are going to use atomic operations, in the mmap.  For
x86 we would probably need to introduce a PROT_NOSEM but it is sounds
fairly straight forward to implement.

Eric
