Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1752162AbWAET0e@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752162AbWAET0e (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 5 Jan 2006 14:26:34 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752164AbWAET0d
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 5 Jan 2006 14:26:33 -0500
Received: from smtp.osdl.org ([65.172.181.4]:15001 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S1752162AbWAET0d (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 5 Jan 2006 14:26:33 -0500
Date: Thu, 5 Jan 2006 11:17:38 -0800 (PST)
From: Linus Torvalds <torvalds@osdl.org>
To: Martin Bligh <mbligh@mbligh.org>
cc: Matt Mackall <mpm@selenic.com>, Arjan van de Ven <arjan@infradead.org>,
       Chuck Ebbert <76306.1226@compuserve.com>, Adrian Bunk <bunk@stusta.de>,
       Andrew Morton <akpm@osdl.org>, Ingo Molnar <mingo@elte.hu>,
       linux-kernel <linux-kernel@vger.kernel.org>,
       Dave Jones <davej@redhat.com>,
       Tim Schmielau <tim@physik3.uni-rostock.de>
Subject: Re: [patch 00/2] improve .text size on gcc 4.0 and newer  compilers
In-Reply-To: <43BD5E6F.1040000@mbligh.org>
Message-ID: <Pine.LNX.4.64.0601051112070.3169@g5.osdl.org>
References: <200601041959_MC3-1-B550-5EE2@compuserve.com> <43BC716A.5080204@mbligh.org>
 <1136463553.2920.22.camel@laptopd505.fenrus.org> <20060105170255.GK3356@waste.org>
 <43BD5E6F.1040000@mbligh.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Thu, 5 Jan 2006, Martin Bligh wrote:
> 
> There are tools already around to do this sort of thing as well - "profile
> directed optimization" or whatever they called it. Seems to be fairly commonly
> done with userspace, but not with the kernel. I'm not sure why not ...
> possibly because it's not available for gcc ?

.. and they are totally useless.

The fact is, the last thing we want to do is to ship a magic profile file 
around for each and every release. And that's what we'd have to do to
get consistent and _useful_ performance increases.

That kind of profile-directed stuff is useful mainly for commercial binary 
releases (where the release binary can be guided by a profile file), or 
speciality programs that can tune themselves a few times before running.

A kernel that people recompile themselves simply isn't something where it 
works.

What _would_ work is something that actually CHECKS (and suggests) the 
hints we already have in the kernel. IOW, you could have an automated 
test-bed that runs some reasonable load, and then verifies whether there 
are branches that go only one way that could be annotated as such, or 
whether some annotation is wrong.

That way the "profile data" actually follows the source code, and is thus 
actually relevant to an open-source project. Because we do _not_ start 
having specially optimized binaries. That's against the whole point of 
being open source and trying to get users to get more deeply involved with 
the project.

			Linus
