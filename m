Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264545AbTIIUch (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 9 Sep 2003 16:32:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264493AbTIIU0Z
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 9 Sep 2003 16:26:25 -0400
Received: from palrel10.hp.com ([156.153.255.245]:3263 "EHLO palrel10.hp.com")
	by vger.kernel.org with ESMTP id S264451AbTIIUZb (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 9 Sep 2003 16:25:31 -0400
From: David Mosberger <davidm@napali.hpl.hp.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <16222.14136.21774.211178@napali.hpl.hp.com>
Date: Tue, 9 Sep 2003 13:25:28 -0700
To: Jes Sorensen <jes@wildopensource.com>
Cc: "Siddha, Suresh B" <suresh.b.siddha@intel.com>,
       "Christoph Hellwig" <hch@infradead.org>,
       "Andrew Morton" <akpm@osdl.org>, "Linus Torvalds" <torvalds@osdl.org>,
       <linux-kernel@vger.kernel.org>,
       "Nakajima, Jun" <jun.nakajima@intel.com>,
       "Mallick, Asit K" <asit.k.mallick@intel.com>
Subject: Re: [Patch] asm workarounds in generic header files
In-Reply-To: <m3llsxivva.fsf@trained-monkey.org>
References: <A609E6D693908E4697BF8BB87E76A07A022114C0@fmsmsx408.fm.intel.com>
	<m3llsxivva.fsf@trained-monkey.org>
X-Mailer: VM 7.07 under Emacs 21.2.1
Reply-To: davidm@hpl.hp.com
X-URL: http://www.hpl.hp.com/personal/David_Mosberger/
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>>>>> On 09 Sep 2003 15:51:05 -0400, Jes Sorensen <jes@wildopensource.com> said:

  Jes> I actually think this is degrading the code rather then
  Jes> improving it. Right now the various macros are located in the
  Jes> include/asm-<foo> directory next to the items where they are
  Jes> used. Moving it all into one big catch-all assembly file makes
  Jes> it a lot harder to read things and debug the code. I already
  Jes> took a look at the changes that went into the ia64 part of the
  Jes> tree and I really think that was a step backwards.

In my opinion, moving all the asm-stuff greatly improved readability
of the source code.  Especially for folks who are not intimately
familiar with GCC asm syntax (which is hairy _and_ platform-specific).

  Jes> In terms of compiling the Linux kernel, I will argue that the
  Jes> Intel compiler is broken if it cannot handle inline
  Jes> assembly. Inline assembly is just too fundamental a feature for
  Jes> the kernel. This is totally ignoring the question of whether
  Jes> one should be compiling the kernel with non-GCC in the first
  Jes> place.

I think the jury is out on this one.  Clearly it's a huge benefit if
you can make do without inline asm.  GCC has to make lots of
worst-case assumptions whenever it encounters an asm statement and,
due to macros and inlining, the asm statements are not just hidden in
a few leaf routines.  In my opinion, this experiment is at least worth
a try.  If it succeeds, great, if it fails (e.g., the Intel compiler
folks fail to keep up with the kernel), all we have to do is
rm intel_intrin.h.

	--david
