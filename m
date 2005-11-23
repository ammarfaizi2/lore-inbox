Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030511AbVKWXmK@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030511AbVKWXmK (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 23 Nov 2005 18:42:10 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030513AbVKWXlK
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 23 Nov 2005 18:41:10 -0500
Received: from smtp.osdl.org ([65.172.181.4]:14256 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S1030511AbVKWXks (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 23 Nov 2005 18:40:48 -0500
Date: Wed, 23 Nov 2005 15:40:18 -0800 (PST)
From: Linus Torvalds <torvalds@osdl.org>
To: "Eric W. Biederman" <ebiederm@xmission.com>
cc: "H. Peter Anvin" <hpa@zytor.com>, Daniel Jacobowitz <dan@debian.org>,
       Alan Cox <alan@lxorguk.ukuu.org.uk>, Andi Kleen <ak@suse.de>,
       Gerd Knorr <kraxel@suse.de>, Dave Jones <davej@redhat.com>,
       Zachary Amsden <zach@vmware.com>, Pavel Machek <pavel@ucw.cz>,
       Andrew Morton <akpm@osdl.org>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Zwane Mwaikambo <zwane@arm.linux.org.uk>,
       Pratap Subrahmanyam <pratap@vmware.com>,
       Christopher Li <chrisl@vmware.com>, Ingo Molnar <mingo@elte.hu>
Subject: Re: [patch] SMP alternatives
In-Reply-To: <m1br0bhrk1.fsf@ebiederm.dsl.xmission.com>
Message-ID: <Pine.LNX.4.64.0511231534110.13959@g5.osdl.org>
References: <1132764133.7268.51.camel@localhost.localdomain>
 <20051123163906.GF20775@brahms.suse.de> <1132766489.7268.71.camel@localhost.localdomain>
 <Pine.LNX.4.64.0511230858180.13959@g5.osdl.org> <4384AECC.1030403@zytor.com>
 <Pine.LNX.4.64.0511231031350.13959@g5.osdl.org> <1132782245.13095.4.camel@localhost.localdomain>
 <Pine.LNX.4.64.0511231331040.13959@g5.osdl.org> <20051123214835.GA24044@nevyn.them.org>
 <4384E4F7.9060806@zytor.com> <20051123220324.GA24517@nevyn.them.org>
 <4384E880.4060305@zytor.com> <Pine.LNX.4.64.0511231419310.13959@g5.osdl.org>
 <m1br0bhrk1.fsf@ebiederm.dsl.xmission.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Wed, 23 Nov 2005, Eric W. Biederman wrote:
> 
> In fact for being explict we already have PROT_SEM on some architectures
> to report if we are going to use atomic operations, in the mmap.  For
> x86 we would probably need to introduce a PROT_NOSEM but it is sounds
> fairly straight forward to implement.

PROT_SEM was a mistake, I feel. It's way too easy to get it wrong. You 
have most architectures and environments that don't need it, and as a 
result, applications simply won't have it in their sources.

I suspect that with MAP_SHARED + PROT_WRITE being pretty uncommon anyway, 
we can probably find trivial patterns in the kernel. Like only one process 
holding that file open - which is what you get with things that use mmap() 
to write a new file (I think "ld" used to have a config option to write 
files that way, for example).

And if we end up sometimes giving "lock" meaning even when it's not 
needed, tough. The point of the simple hack is very much a "get 90% of the 
advantage for very little effort". 

Regardless, even if we get a flag like that (and the Intel people didn't 
seem to dismiss the idea), it's likely a more than a few years down the 
line. So it's not like this is a pressing concern ;)

		Linus
