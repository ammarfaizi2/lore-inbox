Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932564AbVKWWDc@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932564AbVKWWDc (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 23 Nov 2005 17:03:32 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932567AbVKWWDc
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 23 Nov 2005 17:03:32 -0500
Received: from nevyn.them.org ([66.93.172.17]:5805 "EHLO nevyn.them.org")
	by vger.kernel.org with ESMTP id S932564AbVKWWDb (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 23 Nov 2005 17:03:31 -0500
Date: Wed, 23 Nov 2005 17:03:24 -0500
From: Daniel Jacobowitz <dan@debian.org>
To: "H. Peter Anvin" <hpa@zytor.com>
Cc: Linus Torvalds <torvalds@osdl.org>, Alan Cox <alan@lxorguk.ukuu.org.uk>,
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
Message-ID: <20051123220324.GA24517@nevyn.them.org>
Mail-Followup-To: "H. Peter Anvin" <hpa@zytor.com>,
	Linus Torvalds <torvalds@osdl.org>,
	Alan Cox <alan@lxorguk.ukuu.org.uk>, Andi Kleen <ak@suse.de>,
	Gerd Knorr <kraxel@suse.de>, Dave Jones <davej@redhat.com>,
	Zachary Amsden <zach@vmware.com>, Pavel Machek <pavel@ucw.cz>,
	Andrew Morton <akpm@osdl.org>,
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
	Zwane Mwaikambo <zwane@arm.linux.org.uk>,
	Pratap Subrahmanyam <pratap@vmware.com>,
	Christopher Li <chrisl@vmware.com>,
	"Eric W. Biederman" <ebiederm@xmission.com>,
	Ingo Molnar <mingo@elte.hu>
References: <1132764133.7268.51.camel@localhost.localdomain> <20051123163906.GF20775@brahms.suse.de> <1132766489.7268.71.camel@localhost.localdomain> <Pine.LNX.4.64.0511230858180.13959@g5.osdl.org> <4384AECC.1030403@zytor.com> <Pine.LNX.4.64.0511231031350.13959@g5.osdl.org> <1132782245.13095.4.camel@localhost.localdomain> <Pine.LNX.4.64.0511231331040.13959@g5.osdl.org> <20051123214835.GA24044@nevyn.them.org> <4384E4F7.9060806@zytor.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <4384E4F7.9060806@zytor.com>
User-Agent: Mutt/1.5.8i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Nov 23, 2005 at 01:53:59PM -0800, H. Peter Anvin wrote:
> Daniel Jacobowitz wrote:
> >
> >I don't think I see the point.  This would let you optimize for the
> >"multi-threaded, but hasn't created any threads yet" or even
> >"multi-threaded, but not right now" cases.  But those really aren't the
> >interesting case to optimize for - that's the equivalent of supporting
> >CPU hotplug.
> >
> >The interesting case is when you know at static link time that the
> >library is single-threaded, or even at dynamic link time.  And it's
> >easy enough at both of those times to handle this.  In many cases glibc
> >doesn't, because it's valid to dlopen libpthread.so, but that could be
> >accomodated - a simple matter of software.
> >
> 
> No, you can never know that unless you can't call mmap().

Please explain what problem you see.  If you use mmap to manually load
libpthread.so, and patch up its relocations without going to ld.so,
obviously you get to keep both pieces.  Or are you talking about
synchronizing access to shared mmaped buffers?

This is different from what Linus was talking about precisely because
we can do it imperatively ("I know this program is single-threaded and
I'm telling you so" instead of "Hmm, this program hasn't called clone
yet").

It's not as technologically slick but I'd need a lot of convincing to
believe it wasn't just as useful; and it has the benefit of not
requiring new silicon.

-- 
Daniel Jacobowitz
CodeSourcery, LLC
