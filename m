Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261660AbTKHIv4 (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 8 Nov 2003 03:51:56 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261662AbTKHIv4
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 8 Nov 2003 03:51:56 -0500
Received: from pub234.cambridge.redhat.com ([213.86.99.234]:29444 "EHLO
	phoenix.infradead.org") by vger.kernel.org with ESMTP
	id S261660AbTKHIvz (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 8 Nov 2003 03:51:55 -0500
Date: Sat, 8 Nov 2003 08:51:52 +0000
From: Christoph Hellwig <hch@infradead.org>
To: Andrew Morton <akpm@osdl.org>
Cc: James Bottomley <James.Bottomley@steeleye.com>,
       linux-kernel@vger.kernel.org, rusty@rustcorp.com.au
Subject: Re: lib.a causing modules not to load
Message-ID: <20031108085152.B18856@infradead.org>
Mail-Followup-To: Christoph Hellwig <hch@infradead.org>,
	Andrew Morton <akpm@osdl.org>,
	James Bottomley <James.Bottomley@steeleye.com>,
	linux-kernel@vger.kernel.org, rusty@rustcorp.com.au
References: <1068222065.1894.21.camel@mulgrave> <20031107203419.7d0de676.akpm@osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <20031107203419.7d0de676.akpm@osdl.org>; from akpm@osdl.org on Fri, Nov 07, 2003 at 08:34:19PM -0800
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Nov 07, 2003 at 08:34:19PM -0800, Andrew Morton wrote:
> James Bottomley <James.Bottomley@steeleye.com> wrote:
> >
> > I think this has been mentioned before, but I just ran across it again
> >  recently.  The problem is that if the only reference to a routine in
> >  lib.a is in a module, then it never gets compiled into the kernel, and
> >  the module won't load.
> > 
> >  In 2.6.0-test9 this is shown by compiling both ext2 and ext3 as
> >  modules.  Since they're the only things to refer to percpu_counter_mod
> >  which is in lib.a in an SMP system.
> 
> How about we just link that function into the kernel and be done with it? 
> We'll waste a few bytes on SMP machines which have neither ext2 nor ext3
> linked-in or loaded as modules, but that doesn't sound very important...
> 
> (We don't have a kernel/random-support-stuff.c, but we have
> mm/random-support-stuff.c which for some reason is called mm/swap.c, so
> I put it there).

Well, this solves the problem for this particular case, but not other
stuff in lib for other situations.  We should just stop building lib
as archive and conditionalize building bigger and rarely used stuff in
there using Kconfig symbols.

