Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261233AbVBFRRl@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261233AbVBFRRl (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 6 Feb 2005 12:17:41 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261228AbVBFRQe
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 6 Feb 2005 12:16:34 -0500
Received: from canuck.infradead.org ([205.233.218.70]:24074 "EHLO
	canuck.infradead.org") by vger.kernel.org with ESMTP
	id S261246AbVBFRN6 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 6 Feb 2005 12:13:58 -0500
Subject: Re: [PROPOSAL/PATCH] Remove PT_GNU_STACK support before 2.6.11
From: Arjan van de Ven <arjan@infradead.org>
To: Linus Torvalds <torvalds@osdl.org>
Cc: Andi Kleen <ak@suse.de>, Ingo Molnar <mingo@elte.hu>,
       Christoph Hellwig <hch@infradead.org>, akpm@osdl.org,
       linux-kernel@vger.kernel.org, drepper@redhat.com
In-Reply-To: <Pine.LNX.4.58.0502060907220.2165@ppc970.osdl.org>
References: <20050206120244.GA28061@elte.hu> <20050206124523.GA762@elte.hu>
	 <20050206125002.GF30109@wotan.suse.de>
	 <1107694800.22680.90.camel@laptopd505.fenrus.org>
	 <20050206130152.GH30109@wotan.suse.de>
	 <20050206130650.GA32015@infradead.org>
	 <20050206131130.GJ30109@wotan.suse.de> <20050206133239.GA4483@elte.hu>
	 <20050206134640.GB30476@wotan.suse.de> <20050206140802.GA6323@elte.hu>
	 <20050206142936.GC30476@wotan.suse.de>
	 <Pine.LNX.4.58.0502060907220.2165@ppc970.osdl.org>
Content-Type: text/plain
Date: Sun, 06 Feb 2005 18:13:43 +0100
Message-Id: <1107710023.22680.138.camel@laptopd505.fenrus.org>
Mime-Version: 1.0
X-Mailer: Evolution 2.0.2 (2.0.2-3) 
Content-Transfer-Encoding: 7bit
X-Spam-Score: 0.3 (/)
X-Spam-Report: SpamAssassin version 2.63 on canuck.infradead.org summary:
	Content analysis details:   (0.3 points, 5.0 required)
	pts rule name              description
	---- ---------------------- --------------------------------------------------
	0.3 RCVD_NUMERIC_HELO      Received: contains a numeric HELO
X-SRS-Rewrite: SMTP reverse-path rewritten from <arjan@infradead.org> by canuck.infradead.org
	See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 2005-02-06 at 09:08 -0800, Linus Torvalds wrote:
> 
> On Sun, 6 Feb 2005, Andi Kleen wrote:
> > 
> > Force READ_IMPLIES_EXEC for all 32bit processes to fix
> > the 32bit source compatibility.
> 
> Andi, stop this. We're _not_ going to say "32-bit executables don't need 
> PROT_EXEC. The executables would need to be marked broken per-executable, 
> not some kind of "we don't do this globally" setting.


marking PT_GNU_STACK as RWE would be an acceptable marking imo; one can
insert such a marking post build (via the execstack tool), and during
the build with either an addition to the cflags or via a one line code
addition. 

In addition there are runtime markings; you can use setarch to start an
application with READ-IMPLIES-EXEC set (although you can't do that for
setuid binaries for obvious reasons)

Note that these techniques all exist today. The only issue is that the
current code doesn't do the RWE->READIMPLIESEXEC binding, which my patch
fixed. 



