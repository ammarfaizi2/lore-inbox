Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261322AbVAGJAx@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261322AbVAGJAx (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 7 Jan 2005 04:00:53 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261323AbVAGJAw
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 7 Jan 2005 04:00:52 -0500
Received: from mx2.elte.hu ([157.181.151.9]:15045 "EHLO mx2.elte.hu")
	by vger.kernel.org with ESMTP id S261322AbVAGJAr (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 7 Jan 2005 04:00:47 -0500
Date: Fri, 7 Jan 2005 10:00:14 +0100
From: Ingo Molnar <mingo@elte.hu>
To: Christoph Hellwig <hch@infradead.org>, Andrew Morton <akpm@osdl.org>,
       viro@parcelfarce.linux.theplanet.co.uk, paulmck@us.ibm.com,
       arjan@infradead.org, linux-kernel@vger.kernel.org, jtk@us.ibm.com,
       wtaber@us.ibm.com, pbadari@us.ibm.com, markv@us.ibm.com,
       greghk@us.ibm.com, torvalds@osdl.org
Subject: Re: [PATCH] fs: Restore files_lock and set_fs_root exports
Message-ID: <20050107090014.GA24946@elte.hu>
References: <20050106190538.GB1618@us.ibm.com> <1105039259.4468.9.camel@laptopd505.fenrus.org> <20050106201531.GJ1292@us.ibm.com> <20050106203258.GN26051@parcelfarce.linux.theplanet.co.uk> <20050106210408.GM1292@us.ibm.com> <20050106212417.GQ26051@parcelfarce.linux.theplanet.co.uk> <20050106152621.395f935e.akpm@osdl.org> <20050106234123.GA27869@infradead.org> <20050106162928.650e9d71.akpm@osdl.org> <20050107002624.GA29006@infradead.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20050107002624.GA29006@infradead.org>
User-Agent: Mutt/1.4.1i
X-ELTE-SpamVersion: MailScanner 4.31.6-itk1 (ELTE 1.2) SpamAssassin 2.63 ClamAV 0.73
X-ELTE-VirusStatus: clean
X-ELTE-SpamCheck: no
X-ELTE-SpamCheck-Details: score=-4.9, required 5.9,
	autolearn=not spam, BAYES_00 -4.90
X-ELTE-SpamLevel: 
X-ELTE-SpamScore: -4
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


* Christoph Hellwig <hch@infradead.org> wrote:

> > What's under discussion here is "how to do it".  Do we just remove things
> > when we notice them, or do we give (say) 12 months notice?
> 
> Remove when we notice with a short (measured in weeks) period where
> that removal happens only in -mm.  It's a price people have to pay for
> not submitting their code upstream.

let me chime in as the author/maintainer of Tux, which is an out-of-tree
patch that relies on VFS internals. VFS changes constantly break Tux in
one way or another, but i've not complained once because:

   _I simply have no right to complain_

either i submit the code and then i can expect it to be taken into
account, or i dont. It's _the_ basic quid pro quo that keeps technology
moving towards mainline Linux. So if i have to fix up Tux (both for
exports and for other internal details), then that's the price. Often i
have to change Tux to do things differently - and in most cases it's Tux
that was doing things incorrectly. And note that Tux is not a
binary-only module, it's a fully GPL patch.

does this cause more work for me? Sure. Would i prefer to have less
work? Yes, but not in such a shortsighted way. Tux staying external is a
choice i made and i also care about Linux and i very much like the way
the VFS is evolving.

so my strong position is that even asking for any 'warning period' for
changes in VFS internals (including exports/unexports) would be
extremely rude. It would be rude not only towards the authors and
maintainers of mainline VFS code, but also towards other external
trees/drivers who do _not_ ask for any special status and accept the
deal: "follow internals, notice kernel people if they do bad stuff
(extremely rare in my case) and fix/redesign stuff if the external tree
is broken (much more common)".

	Ingo
