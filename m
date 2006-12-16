Return-Path: <linux-kernel-owner+w=401wt.eu-S1753770AbWLPSdN@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753770AbWLPSdN (ORCPT <rfc822;w@1wt.eu>);
	Sat, 16 Dec 2006 13:33:13 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753771AbWLPSdN
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 16 Dec 2006 13:33:13 -0500
Received: from mx1.redhat.com ([66.187.233.31]:55694 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753768AbWLPSdM (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 16 Dec 2006 13:33:12 -0500
Date: Sat, 16 Dec 2006 13:33:01 -0500
From: Dave Jones <davej@redhat.com>
To: Linus Torvalds <torvalds@osdl.org>
Cc: Willy Tarreau <w@1wt.eu>, karderio <karderio@gmail.com>,
       linux-kernel@vger.kernel.org
Subject: Re: GPL only modules [was Re: [GIT PATCH] more Driver core patches for 2.6.19]
Message-ID: <20061216183301.GA14286@redhat.com>
Mail-Followup-To: Dave Jones <davej@redhat.com>,
	Linus Torvalds <torvalds@osdl.org>, Willy Tarreau <w@1wt.eu>,
	karderio <karderio@gmail.com>, linux-kernel@vger.kernel.org
References: <1166226982.12721.78.camel@localhost> <Pine.LNX.4.64.0612151615550.3849@woody.osdl.org> <1166236356.12721.142.camel@localhost> <Pine.LNX.4.64.0612151841570.3557@woody.osdl.org> <20061216064344.GF24090@1wt.eu> <Pine.LNX.4.64.0612160820240.3557@woody.osdl.org> <20061216164947.GB31013@1wt.eu> <Pine.LNX.4.64.0612160858100.3557@woody.osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.64.0612160858100.3557@woody.osdl.org>
User-Agent: Mutt/1.4.2.2i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Dec 16, 2006 at 09:20:15AM -0800, Linus Torvalds wrote:

 > Anything else, you have to make some really scary decisions. Can a judge 
 > decide that a binary module is a derived work even though you didn't 
 > actually use any code? The real answer is: HELL YES. It's _entirely_ 
 > possible that a judge would find NVidia and ATI in violation of the GPLv2 
 > with their modules.

ATI in particular, I'm amazed their lawyers OK'd stuff like..

+ifdef STANDALONE
 MODULE_LICENSE(GPL);
+endif

This a paraphrased diff, it's been a while since I've seen it.
It's GPL if you build their bundled copy of the AGPGART code as agpgart.ko,
but the usual use case is that it's built-in to fglrx.ko, which sounds
incredibly dubious.

Now, AGPGART has a murky past wrt licenses.  It initally was imported
into the tree with the license "GPL plus additional rights".
Nowhere was it actually documented what those rights were, but I'm
fairly certain it wasn't to enable nonsense like the above.
As it came from the XFree86 folks, it's more likely they really meant
"Dual GPL/MIT" or similar.

When I took over, any new code I wrote I explicitly set out to mark as GPL
code, as my modifications weren't being contributed back to X, they were
going back to the Linux kernel.  ATI took those AGPv3 modifications from
a 2.5 kernel, backported them to their 2.4 driver, and when time came
to do a 2.6 driver, instead of doing the sensible thing and dropping
them in favour of using the kernel AGP driver, they chose to forward
port their unholy abomination to 2.6.
It misses so many fixes (and introduces a number of other problems)
that its just unfunny.

The thing that really ticks me off though is the free support ATI seem
to think they're entitled to.  I've had end-users emailing me
"I asked ATI about this crash I've been seeing with fglrx, and they
 asked me to mail you".

I invest my time into improving free drivers.  When companies start
expecting me to debug their part binary garbage mixed with license
violations, frankly, I think they're taking the piss.

A year and a half ago, I met an ATI engineer at OLS, who told me they
were going to 'resolve this'.  I'm still waiting.
I live in hope that the AMD buyout will breathe some sanity into ATI.
Then again, I've only a limited supply of optimism.

		Dave

-- 
http://www.codemonkey.org.uk
