Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263493AbUDBBJY (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 1 Apr 2004 20:09:24 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263480AbUDBBJX
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 1 Apr 2004 20:09:23 -0500
Received: from ppp-217-133-42-200.cust-adsl.tiscali.it ([217.133.42.200]:64402
	"EHLO dualathlon.random") by vger.kernel.org with ESMTP
	id S263493AbUDBBJA (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 1 Apr 2004 20:09:00 -0500
Date: Fri, 2 Apr 2004 03:09:00 +0200
From: Andrea Arcangeli <andrea@suse.de>
To: Andrew Morton <akpm@osdl.org>
Cc: pavel@suse.cz, linux-kernel@vger.kernel.org, hugh@veritas.com
Subject: Re: Properly stop kernel threads on aic7xxx
Message-ID: <20040402010900.GJ18585@dualathlon.random>
References: <20040401170808.GA696@elf.ucw.cz> <20040402003520.GH18585@dualathlon.random> <20040401170403.76d86432.akpm@osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040401170403.76d86432.akpm@osdl.org>
User-Agent: Mutt/1.4.1i
X-GPG-Key: 1024D/68B9CB43 13D9 8355 295F 4823 7C49  C012 DFA1 686E 68B9 CB43
X-PGP-Key: 1024R/CB4660B9 CC A0 71 81 F4 A0 63 AC  C0 4B 81 1D 8C 15 C8 E5
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Apr 01, 2004 at 05:04:03PM -0800, Andrew Morton wrote:
> Andrea Arcangeli <andrea@suse.de> wrote:
> >
> > I'm also unsure why _all_ multipage allocations really need this
> > compound thing setup and why can't the owner of the page take care of
> > the refcounting itself by always using the head page. I may actually
> > add a GFP bitflag asking for a multipage but w/o a compound setup. There
> > are million ways to fix this, none of which is obvious.
> 
> For direct-io into higher-order pages.  When doing direct-io into a hugetlb
> page we need to make sure that get_user_pages() pins the correct pageframe.

we do the same in bigpages 2.4 just fine with a basic math on the page_t
knowing it's 2M naturally aligned, very easy to find the head page on
vmas with VM_HUGETLBFS.

> Possibly we need to turn it on regardless of CONFIG_HUGETLBPAGE for people
> who want to do direct-io or PEEKTEXT/POKETEXT into mmapped soundcard
> buffers, for example.  Perhaps there's a race which could permit direct-io
> to write to a freed page via this route..
> 
> Davem had some reason why he might want to turn on the compound logic
> permanently - related to TCP access to/from higher-order pages, I think.

currently it's turned on only with HUGTLBFS=y though.
