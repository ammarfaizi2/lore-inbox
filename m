Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264343AbTDXASk (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 23 Apr 2003 20:18:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264346AbTDXASk
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 23 Apr 2003 20:18:40 -0400
Received: from smtp-out2.iol.cz ([194.228.2.87]:40629 "EHLO smtp-out2.iol.cz")
	by vger.kernel.org with ESMTP id S264343AbTDXASb (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 23 Apr 2003 20:18:31 -0400
Date: Thu, 24 Apr 2003 02:25:52 +0200
From: Pavel Machek <pavel@ucw.cz>
To: "Martin J. Bligh" <mbligh@aracnet.com>
Cc: "Grover, Andrew" <andrew.grover@intel.com>,
       Nigel Cunningham <ncunningham@clear.net.nz>,
       Marc Giger <gigerstyle@gmx.ch>,
       Geert Uytterhoeven <geert@linux-m68k.org>,
       Linux Kernel Development <linux-kernel@vger.kernel.org>
Subject: Re: Fix SWSUSP & !SWAP
Message-ID: <20030424002551.GA2980@elf.ucw.cz>
References: <F760B14C9561B941B89469F59BA3A847E96E0E@orsmsx401.jf.intel.com> <20030424000344.GC32577@atrey.karlin.mff.cuni.cz> <1592050000.1051142225@flay>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1592050000.1051142225@flay>
X-Warning: Reading this can be dangerous to your mental health.
User-Agent: Mutt/1.5.3i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

> >> > From: Martin J. Bligh [mailto:mbligh@aracnet.com] 
> >> > Can't you just create a pre-reserved separate swsusp area on 
> >> > disk the size 
> >> > of RAM (maybe a partition rather than a file to make things 
> >> > easier), and 
> >> > then you know you're safe (basically what Marc was 
> >> > suggesting, except pre-allocated)? Or does that make me the 
> >> > prince of all evil? ;-)
> >> > 
> >> > However much swap space you allocate, it can always all be 
> >> > used, so that seems futile ...
> >> 
> >> This is what Other OSes do, and I believe this is the correct path.
> >> Using swap for swsusp is a clever hack but not a 100% solution.
> > 
> > Well, for normal use its clearly inferior -- suspend partition is unused
> > when it could be used for speeding system up by swapping out unused
> > stuff.
> > 
> > OtherOS approach is better because it can guarantee suspend-to-disk
> > for critical situations like overheat or battery-critical.
> > 
> > But we can get best of both worlds if we OOM-kill during critical
> > suspend. [If suspend partition was not used for swapping, machine
> > would *already* OOM-killed someone, so we are only improving stuff].
> 
> OK ... but at least having the *option* to have a separate reserved
> area would be nice, no? For most people, RAM is just a tiny amount
> of their disk space ... and damn, does it make the code simpler ;-)

If it is an *option*, it does not make code simpler.

And OOM-killing during suspend is just what you want. It makes suspend
deterministic but it might kill someone. [Well, your solution would
kill him sooner than that...]
								Pavel

-- 
When do you have a heart between your knees?
[Johanka's followup: and *two* hearts?]
