Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263624AbUDFFPH (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 6 Apr 2004 01:15:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263621AbUDFFPH
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 6 Apr 2004 01:15:07 -0400
Received: from phoenix.infradead.org ([213.86.99.234]:13829 "EHLO
	phoenix.infradead.org") by vger.kernel.org with ESMTP
	id S263624AbUDFFPC (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 6 Apr 2004 01:15:02 -0400
Date: Tue, 6 Apr 2004 06:14:56 +0100
From: Christoph Hellwig <hch@infradead.org>
To: Andrew Morton <akpm@osdl.org>
Cc: Andrea Arcangeli <andrea@suse.de>, hugh@veritas.com, vrajesh@umich.edu,
       linux-kernel@vger.kernel.org, linux-mm@kvack.org
Subject: Re: [RFC][PATCH 1/3] radix priority search tree - objrmap complexity fix
Message-ID: <20040406061456.A14800@infradead.org>
Mail-Followup-To: Christoph Hellwig <hch@infradead.org>,
	Andrew Morton <akpm@osdl.org>, Andrea Arcangeli <andrea@suse.de>,
	hugh@veritas.com, vrajesh@umich.edu, linux-kernel@vger.kernel.org,
	linux-mm@kvack.org
References: <20040402205410.A7194@infradead.org> <20040402203514.GR21341@dualathlon.random> <20040403094058.A13091@infradead.org> <20040403152026.GE2307@dualathlon.random> <20040403155958.GF2307@dualathlon.random> <20040403170258.GH2307@dualathlon.random> <20040405105912.A3896@infradead.org> <20040405131113.A5094@infradead.org> <20040406042222.GP2234@dualathlon.random> <20040405214330.05e4ecd7.akpm@osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <20040405214330.05e4ecd7.akpm@osdl.org>; from akpm@osdl.org on Mon, Apr 05, 2004 at 09:43:30PM -0700
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Apr 05, 2004 at 09:43:30PM -0700, Andrew Morton wrote:
> Andrea Arcangeli <andrea@suse.de> wrote:
> >
> > Then there's the pagebuf_associate_memory that rings
> >  an extremely *loud* bell, pagebuf_get_no_daddr and XBUF_SET_PTR sounds
> >  even more, then I go on with xlog_get_bp and tons of other things doing
> >  pagebuf I/O with kmalloced memory with variable size of the kmalloc. Too
> >  many concidences for this not being an xfs bug.
> 
> It does pagebuf I/O with kmalloced memory?  Wow.  Pretty much anything
> which goes from kmalloc virtual addresses back to pageframes is a big fat
> warning sign.

It's for the log I/O.  I thought about doign __get_free_page for it but that
would waste a lot of memory.

