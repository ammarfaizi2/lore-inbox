Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262737AbUKZVqp@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262737AbUKZVqp (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 26 Nov 2004 16:46:45 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262598AbUKZVqW
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 26 Nov 2004 16:46:22 -0500
Received: from pop5-1.us4.outblaze.com ([205.158.62.125]:36531 "HELO
	pop5-1.us4.outblaze.com") by vger.kernel.org with SMTP
	id S264002AbUKZVmm (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 26 Nov 2004 16:42:42 -0500
Subject: Re: Suspend2 merge: 1/51: Device trees
From: Nigel Cunningham <ncunningham@linuxmail.org>
Reply-To: ncunningham@linuxmail.org
To: Pavel Machek <pavel@ucw.cz>
Cc: kernel list <linux-kernel@vger.kernel.org>
In-Reply-To: <20041125232612.GJ2711@elf.ucw.cz>
References: <20041125165413.GB476@openzaurus.ucw.cz>
	 <20041125185304.GA1260@elf.ucw.cz>
	 <1101421336.27250.80.camel@desktop.cunninghams>
	 <20041125224124.GE2711@elf.ucw.cz>
	 <1101423148.27250.110.camel@desktop.cunninghams>
	 <20041125232612.GJ2711@elf.ucw.cz>
Content-Type: text/plain
Message-Id: <1101426734.27250.155.camel@desktop.cunninghams>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6-1mdk 
Date: Fri, 26 Nov 2004 10:52:14 +1100
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi.

On Fri, 2004-11-26 at 10:26, Pavel Machek wrote:
> > > > I thought I wrote - perhaps I'm wrong here - that I understand that your
> > > > new work in this area might make this unnecessary. I really only want to
> > > > do it this way because I don't know what other drivers might be doing
> > > > while we're writing the LRU pages. I'm not worried about them touching
> > > > LRU. What I am worried about is them allocating memory and starving
> > > > suspend so that we get hangs due to being oom. If they're suspended, we
> > > > have more certainty as to how memory is being used. I don't remember
> > > > what prompted me to do this in the first place, but I'm pretty sure it
> > > > would have been a real observed issue.
> > > 
> > > Uh... It seems like quite a lot of work. Would not reserving few more
> > > pages help here? Or perhaps right solution is to fix "broken" drivers
> > > that need too much memory...
> > 
> > I'd agree, except that I don't know how many to allocate. It makes
> > getting a reliable suspend the result of guess work and favourable
> > circumstances. Fixing 'broken' drivers by really suspending them seems
> > to me to be the right solution. Make their memory requirements perfectly
> > predictable.
> 
> Except for the few drivers that are between suspend device and
> root. So you still have the same problem, and still need to
> guess. Plus you get complex changes to driver model.

I think you're overstating your case. All we're talking about doing is
quiescing the same drivers that would be quiesced later, in the same
way, but earlier in the process. Apart from the code I already have in
that patch, nothing else is needed. The changes aren't that complex,
either.
-- 
Nigel Cunningham
Pastoral Worker
Christian Reformed Church of Tuggeranong
PO Box 1004, Tuggeranong, ACT 2901

You see, at just the right time, when we were still powerless, Christ
died for the ungodly.		-- Romans 5:6

