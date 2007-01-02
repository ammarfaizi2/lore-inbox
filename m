Return-Path: <linux-kernel-owner+w=401wt.eu-S964960AbXABWEo@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964960AbXABWEo (ORCPT <rfc822;w@1wt.eu>);
	Tue, 2 Jan 2007 17:04:44 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964967AbXABWEn
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 2 Jan 2007 17:04:43 -0500
Received: from smtp.osdl.org ([65.172.181.25]:36795 "EHLO smtp.osdl.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S964960AbXABWEm (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 2 Jan 2007 17:04:42 -0500
Date: Tue, 2 Jan 2007 14:01:06 -0800 (PST)
From: Linus Torvalds <torvalds@osdl.org>
To: Adrian Bunk <bunk@stusta.de>
cc: Alistair John Strachan <s0348365@sms.ed.ac.uk>,
       "Zhang, Yanmin" <yanmin_zhang@linux.intel.com>,
       LKML <linux-kernel@vger.kernel.org>, Greg KH <greg@kroah.com>,
       Chuck Ebbert <76306.1226@compuserve.com>, Andrew Morton <akpm@osdl.org>
Subject: Re: kernel + gcc 4.1 = several problems
In-Reply-To: <20070102211045.GY20714@stusta.de>
Message-ID: <Pine.LNX.4.64.0701021349420.4473@woody.osdl.org>
References: <200612201421.03514.s0348365@sms.ed.ac.uk>
 <200612301659.35982.s0348365@sms.ed.ac.uk> <20061231162731.GK20714@stusta.de>
 <200612311655.51928.s0348365@sms.ed.ac.uk> <20070102211045.GY20714@stusta.de>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Tue, 2 Jan 2007, Adrian Bunk wrote:
> 
> My point is that we have several reported problems only visible
> with gcc 4.1.
> 
> Other bug reports are e.g. [2] and [3], but they are only present with
> using gcc 4.1 _and_ using -Os.

Traditionally, afaik, -Os has tended to show compiler problems that 
_could_ happen with -O2 too, but never do in practice. It may be that 
gcc-4.1 without -Os miscompiles some very unusual code, and then with -Os 
we just hit more cases of that.

That said, I th ink gcc-4.1.1 is very common - I know it's the Fedora 
compiler. Also, CC_OPTIMIZE_FOR_SIZE defaults to 'y' if you have 
EXPERIMENTAL on, and from all the bug-reports about other features that 
are marked EXPERIMENTAL, I know that a lot of people do seem to select for 
it. So I would expect that gcc-4.1.1 and -Os is actually a fairly common 
combination. I just checked, and it's what I use personally, for example.

Of course, my main machine is an x86-64, and it has more registers. At 
least some historical -Os bug was about bad things happening under 
register pressure, iirc, and so x86-64 would show fewer problems than 
regular 32-bit x86 (which has far fewer registers for the compiler to 
use).

It is a bit worrisome. These things seem to be about 50:50 real kernel 
bugs (just hidden by some common code generation sequence) and real 
honest-to-goodness compiler bugs. But they are hard as hell to find.

		Linus
