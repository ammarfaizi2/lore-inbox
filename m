Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S284264AbRL1A7j>; Thu, 27 Dec 2001 19:59:39 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S284017AbRL1A73>; Thu, 27 Dec 2001 19:59:29 -0500
Received: from dsl254-112-233.nyc1.dsl.speakeasy.net ([216.254.112.233]:52431
	"EHLO snark.thyrsus.com") by vger.kernel.org with ESMTP
	id <S283938AbRL1A7Y>; Thu, 27 Dec 2001 19:59:24 -0500
Date: Thu, 27 Dec 2001 19:44:44 -0500
From: "Eric S. Raymond" <esr@thyrsus.com>
To: Linux Kernel List <linux-kernel@vger.kernel.org>
Subject: ISA core vs. ISA card support
Message-ID: <20011227194444.A26341@thyrsus.com>
Reply-To: esr@thyrsus.com
Mail-Followup-To: "Eric S. Raymond" <esr@thyrsus.com>,
	Linux Kernel List <linux-kernel@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
Organization: Eric Conspiracy Secret Labs
X-Eric-Conspiracy: There is no conspiracy
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Because the CML2 coodebase is basically buttoned down at this point,
I'm now trying to do a little forward design -- looking for rulebase
cleanups that will get much harder to do once the CML2 rulebase is
dispersed to the care of four-dozen maintainers.

Top of my list is maybe doing something about the ISA config symbol.
There is a declaration in my arch/i386 rules file that looks like this:

# There are PCI-only machines out there, but as of 2.4.0-test1 I'm told
# nobody has tested the kernel with an x86 lacking ISA.  Giacomo Catenazzi
# believes that some motherboard chips use the ISA support code anyway even
# if you don't have an ISA bus.
require X86 implies ISA==y

This is a real problem, because it means that people configuring for 
PCI-only X86 machines (an increasingly common case) are going to see a
whole boatload of ISA-card questions irrelevant to them.  I'd like to
fix this *before* changing it everywhere might imply a turf war, thank you.

There are a couple of ways I could address this in the rulebase. The best
course depends on facts I don't know.  Like, have kernels more recent than
2.4.0-test1 been built without ISA and tested on PCI-only machines?  If
this is known to work reliably, I can remove the above rule and life will
be simpler and happier.

If not, then I need to tghink about splitting the config symbol into ISA 
and ISA_SLOTS and hacking all of the present driver-visibility predicates
to use the latter, with an implication like this

require ISA_SLOTS implies ISA==y
-- 
		<a href="http://www.tuxedo.org/~esr/">Eric S. Raymond</a>

It would be thought a hard government that should tax its people one tenth 
part.	-- Benjamin Franklin
