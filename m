Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261353AbVAMRsM@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261353AbVAMRsM (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 13 Jan 2005 12:48:12 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261347AbVAMRrr
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 13 Jan 2005 12:47:47 -0500
Received: from canuck.infradead.org ([205.233.218.70]:16403 "EHLO
	canuck.infradead.org") by vger.kernel.org with ESMTP
	id S261341AbVAMRqi (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 13 Jan 2005 12:46:38 -0500
Subject: Re: thoughts on kernel security issues
From: Arjan van de Ven <arjan@infradead.org>
To: Linus Torvalds <torvalds@osdl.org>
Cc: Christoph Hellwig <hch@infradead.org>, Dave Jones <davej@redhat.com>,
       Andrew Morton <akpm@osdl.org>, marcelo.tosatti@cyclades.com,
       Greg KH <greg@kroah.com>, chrisw@osdl.org,
       Alan Cox <alan@lxorguk.ukuu.org.uk>,
       Kernel Mailing List <linux-kernel@vger.kernel.org>
In-Reply-To: <Pine.LNX.4.58.0501130909270.2310@ppc970.osdl.org>
References: <Pine.LNX.4.58.0501121002200.2310@ppc970.osdl.org>
	 <20050112185133.GA10687@kroah.com>
	 <Pine.LNX.4.58.0501121058120.2310@ppc970.osdl.org>
	 <20050112161227.GF32024@logos.cnet>
	 <Pine.LNX.4.58.0501121148240.2310@ppc970.osdl.org>
	 <20050112205350.GM24518@redhat.com>
	 <Pine.LNX.4.58.0501121750470.2310@ppc970.osdl.org>
	 <20050112182838.2aa7eec2.akpm@osdl.org> <20050113033542.GC1212@redhat.com>
	 <Pine.LNX.4.58.0501122025140.2310@ppc970.osdl.org>
	 <20050113082320.GB18685@infradead.org>
	 <Pine.LNX.4.58.0501130822280.2310@ppc970.osdl.org>
	 <1105635662.6031.35.camel@laptopd505.fenrus.org>
	 <Pine.LNX.4.58.0501130909270.2310@ppc970.osdl.org>
Content-Type: text/plain
Date: Thu, 13 Jan 2005 18:45:37 +0100
Message-Id: <1105638338.6031.42.camel@laptopd505.fenrus.org>
Mime-Version: 1.0
X-Mailer: Evolution 2.0.2 (2.0.2-3) 
Content-Transfer-Encoding: 7bit
X-Spam-Score: 4.1 (++++)
X-Spam-Report: SpamAssassin version 2.63 on canuck.infradead.org summary:
	Content analysis details:   (4.1 points, 5.0 required)
	pts rule name              description
	---- ---------------------- --------------------------------------------------
	0.3 RCVD_NUMERIC_HELO      Received: contains a numeric HELO
	0.0 SEE_FOR_YOURSELF       BODY: See for yourself
	1.1 RCVD_IN_DSBL           RBL: Received via a relay in list.dsbl.org
	[<http://dsbl.org/listing?80.57.133.107>]
	2.5 RCVD_IN_DYNABLOCK      RBL: Sent directly from dynamic IP address
	[80.57.133.107 listed in dnsbl.sorbs.net]
	0.1 RCVD_IN_SORBS          RBL: SORBS: sender is listed in SORBS
	[80.57.133.107 listed in dnsbl.sorbs.net]
X-SRS-Rewrite: SMTP reverse-path rewritten from <arjan@infradead.org> by canuck.infradead.org
	See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2005-01-13 at 09:19 -0800, Linus Torvalds wrote:
> 
> On Thu, 13 Jan 2005, Arjan van de Ven wrote:
> > 
> > I think you are somewhat misguided on these: the randomisation done in
> > FC does NOT prohibit prelink for working, with the exception of special
> > PIE binaries. Does this destroy the randomisation? No: prelink *itself*
> > randomizes the addresses when creating it's prelink database
> 
> There was a kernel-based randomization patch floating around at some 
> point, though. I think it's part of PaX. That's the one I hated. 
> 
> Although I haven't seen it in a long time, so you may well be right that 
> that one too is fine. 

I don't know about the pax one, we were careful with the fc one to not
break prelink for obvious reasons ;)

> I just think that forking at some levels is _good_. I like the fact that 
> different vendors have different objectives, and that there are things 
> like Immunix and PaX etc around. Of course, the problem that sometimes 
> results in is the very fact that because I encourage others to have 
> special patches, they en dup not even trying to feed back _parts_ of them.

actually I was hoping to feed some bits of execshield (eg the
randomisation) to you sometime in the next weeks/months, after a
thorough cleaning of the code, and defaulting to off.

The code can be made quite reasonable I suspect if I manage to find a
few hours to clean it up some
(the pre-cleanup patch is at
http://www.kernel.org/pub/linux/kernel/people/arjan/execshield/00-
randomize-A0

in case you want to see for yourself)

that patch randomizes the stack (well already done via an x86 specific
hack in the existing kernel, this pulls that more generic)
the brk start
the start of mmap space (but leaves mmaps where the app gives a hint for
the address alone, like ld.so does for prelinked libs)




