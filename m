Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1753600AbWKDNvl@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753600AbWKDNvl (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 4 Nov 2006 08:51:41 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753603AbWKDNvl
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 4 Nov 2006 08:51:41 -0500
Received: from extu-mxob-1.symantec.com ([216.10.194.28]:55004 "EHLO
	extu-mxob-1.symantec.com") by vger.kernel.org with ESMTP
	id S1751850AbWKDNvj (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 4 Nov 2006 08:51:39 -0500
X-AuditID: 7f000001-a2c2fbb000004817-67-454c9aea57e1 
Date: Sat, 4 Nov 2006 13:51:53 +0000 (GMT)
From: Hugh Dickins <hugh@veritas.com>
X-X-Sender: hugh@blonde.wat.veritas.com
To: Adrian Bunk <bunk@stusta.de>
cc: "Michael S. Tsirkin" <mst@mellanox.co.il>, Pavel Machek <pavel@suse.cz>,
       Linus Torvalds <torvalds@osdl.org>, Andrew Morton <akpm@osdl.org>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       len.brown@intel.com, linux-acpi@vger.kernel.org, linux-pm@osdl.org,
       Martin Lorenz <martin@lorenz.eu.org>, Andi Kleen <ak@suse.de>,
       discuss@x86-64.org, Russell King <rmk@dyn-67.arm.linux.org.uk>,
       linux-serial@vger.kernel.org, linux-thinkpad@linux-thinkpad.org,
       Ernst Herzberg <earny@net4u.de>
Subject: Re: 2.6.19-rc <-> ThinkPads, summary
In-Reply-To: <20061104034906.GO13381@stusta.de>
Message-ID: <Pine.LNX.4.64.0611041348510.5975@blonde.wat.veritas.com>
References: <20061029231358.GI27968@stusta.de> <20061030135625.GB1601@mellanox.co.il>
 <20061101030126.GE27968@stusta.de> <20061104034906.GO13381@stusta.de>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
X-OriginalArrivalTime: 04 Nov 2006 13:51:38.0084 (UTC) FILETIME=[594DE240:01C70018]
X-Brightmail-Tracker: AAAAAA==
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 4 Nov 2006, Adrian Bunk wrote:
> 
> Hugh Dickins:
> - ThinkPad T43p
> - booting with "noapic nolapic" didn't make any difference
> - reverting commit cf4c6a2f27f5db810b69dcb1da7f194489e8ff88
>   ("i386: Factor out common io apic routing entry access") didn't help
> - question: Was your bisecting successful?

Not quite what I'd call successful, but I think I've just about arrived
at some kind of conclusion.

Short summary: forget my complaint, assume it's fixed in current -git.

Boring version:

I think I have two slightly different, perhaps not unrelated, issues.
One manifested in habitual usage, to and from work, suspending for quiet
at home, etc, etc.  As 2.6.19-rc progressed, I more and more often found
it impossible to re-suspend after the first time: suspend key ignored.
rc3 seemed worst, rc4 at first seemed okay, then not, perhaps because...

In order to bisect on this, I had to speed up the testing from a day
or two to a few minutes; and I'm now thinking that this may have
focussed on a different problem.  After several reset bisections
converging on absurd patches (e.g. sparse annotations or unbuilt
sources), I grew even more suspicious of my "good" cases, and
yesterday found even 2.6.18 and 2.6.17 (didn't try earlier) behave
like this: occasionally the suspend key gets ignored for about one
minute (in the few cases I timed).

So whatever I was bisecting on, it's not a regression in 2.6.19.
It may be a software bug, it would be worth fixing if I can work
it out (though the pleasure of bisection was not having to think,
I've grown addicted); but it's not anything to hold up 2.6.19.

And as far as habitual usage goes, experience so far with -gits
post rc4 suggests that that problem has gone away: it's a little
too early to tell for sure, but I've not had to go back to using
2.6.18 to avoid it yet.

Hugh
