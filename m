Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266303AbUHROL4@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266303AbUHROL4 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 18 Aug 2004 10:11:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266316AbUHROLz
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 18 Aug 2004 10:11:55 -0400
Received: from unthought.net ([212.97.129.88]:1712 "EHLO unthought.net")
	by vger.kernel.org with ESMTP id S266303AbUHROLU (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 18 Aug 2004 10:11:20 -0400
Date: Wed, 18 Aug 2004 16:11:19 +0200
From: Jakob Oestergaard <jakob@unthought.net>
To: Gene Heskett <gene.heskett@verizon.net>
Cc: linux-kernel@vger.kernel.org, Anders Saaby <as@cohaesio.com>,
       sct@redhat.com
Subject: Re: oom-killer 2.6.8.1
Message-ID: <20040818141118.GY27443@unthought.net>
Mail-Followup-To: Jakob Oestergaard <jakob@unthought.net>,
	Gene Heskett <gene.heskett@verizon.net>,
	linux-kernel@vger.kernel.org, Anders Saaby <as@cohaesio.com>,
	sct@redhat.com
References: <200408181455.42279.as@cohaesio.com> <200408180957.04039.gene.heskett@verizon.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200408180957.04039.gene.heskett@verizon.net>
User-Agent: Mutt/1.3.28i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Aug 18, 2004 at 09:57:03AM -0400, Gene Heskett wrote:
...
 >Any ideas?
> >
> >Try to disable swap?  Tune magic VM settings?  Any suggestions are
> > highly welcome.
> >
> >Thank you very much,
> 
> You may be another candidate for the same thing thats troubleing me.  
> Back up the log above that and look for an Oops and post that please.

Looking thru the swapfile.c and oom killer code, one thing that is
making me scratch my head:

nr_swap_pages is a *signed* integer.  This does not make sense. There
are even tests in swapfile.c that explicitly test "nr_swap_pages <= 0"
instead of simply "!nr_swap_pages" - this does not make sense at all
either - or does it?

Stephen is that your code?

See, if nr_swap_pages can validly be negative and some meaning is
attached to that (some meaning other than "we're out of swap"), the
oom_killer surely misses that, as it tests "nr_swap_pages > 0".

I don't think that nr_swap_pages can be negative (unless one adds a
*lot* of swap in which case this will unintentionally happen all by
itself),  but I felt I should chirp in with this comment in case
someone's looking at it anyway  :)

-- 

 / jakob

