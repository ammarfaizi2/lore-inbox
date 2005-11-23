Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932198AbVKWVsv@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932198AbVKWVsv (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 23 Nov 2005 16:48:51 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932549AbVKWVsv
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 23 Nov 2005 16:48:51 -0500
Received: from nevyn.them.org ([66.93.172.17]:29157 "EHLO nevyn.them.org")
	by vger.kernel.org with ESMTP id S932198AbVKWVsu (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 23 Nov 2005 16:48:50 -0500
Date: Wed, 23 Nov 2005 16:48:35 -0500
From: Daniel Jacobowitz <dan@debian.org>
To: Linus Torvalds <torvalds@osdl.org>
Cc: Alan Cox <alan@lxorguk.ukuu.org.uk>, "H. Peter Anvin" <hpa@zytor.com>,
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
Message-ID: <20051123214835.GA24044@nevyn.them.org>
Mail-Followup-To: Linus Torvalds <torvalds@osdl.org>,
	Alan Cox <alan@lxorguk.ukuu.org.uk>,
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
References: <438359D7.7090308@suse.de> <p7364qjjhqx.fsf@verdi.suse.de> <1132764133.7268.51.camel@localhost.localdomain> <20051123163906.GF20775@brahms.suse.de> <1132766489.7268.71.camel@localhost.localdomain> <Pine.LNX.4.64.0511230858180.13959@g5.osdl.org> <4384AECC.1030403@zytor.com> <Pine.LNX.4.64.0511231031350.13959@g5.osdl.org> <1132782245.13095.4.camel@localhost.localdomain> <Pine.LNX.4.64.0511231331040.13959@g5.osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.64.0511231331040.13959@g5.osdl.org>
User-Agent: Mutt/1.5.8i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Nov 23, 2005 at 01:36:08PM -0800, Linus Torvalds wrote:
> But optimizing for a single _thread_ is not a lost game. I don't believe 
> that threaded applications are necessarily going to take over all that 
> much in a lot of areas. Sure, we'll have more threaded apps too, but we'll 
> continue to have tons more of performance-critical non-threaded things 
> like compilers etc.
> 
> And _that_ is worth optimizing for. General libraries that have to be able 
> to handle the threaded case dynamically, but that are often run with no 
> shared memory anywhere.
> 
> THAT is what I'd like to have CPU support for. Not for UP (it's going 
> away), and not for the kernel (it's never single-threaded).

I don't think I see the point.  This would let you optimize for the
"multi-threaded, but hasn't created any threads yet" or even
"multi-threaded, but not right now" cases.  But those really aren't the
interesting case to optimize for - that's the equivalent of supporting
CPU hotplug.

The interesting case is when you know at static link time that the
library is single-threaded, or even at dynamic link time.  And it's
easy enough at both of those times to handle this.  In many cases glibc
doesn't, because it's valid to dlopen libpthread.so, but that could be
accomodated - a simple matter of software.

-- 
Daniel Jacobowitz
CodeSourcery, LLC
