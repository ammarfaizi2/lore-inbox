Return-Path: <linux-kernel-owner+willy=40w.ods.org-S269067AbUIMX4i@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S269067AbUIMX4i (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 13 Sep 2004 19:56:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S269042AbUIMXzw
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 13 Sep 2004 19:55:52 -0400
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:22488 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id S269040AbUIMXzn
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 13 Sep 2004 19:55:43 -0400
Date: Mon, 13 Sep 2004 19:21:27 -0300
From: Marcelo Tosatti <marcelo.tosatti@cyclades.com>
To: Nick Piggin <nickpiggin@yahoo.com.au>
Cc: William Lee Irwin III <wli@holomorphy.com>, Andrew Morton <akpm@osdl.org>,
       linux-kernel@vger.kernel.org
Subject: Re: [pagevec] resize pagevec to O(lg(NR_CPUS))
Message-ID: <20040913222127.GA23588@logos.cnet>
References: <20040909163929.GA4484@logos.cnet> <20040909155226.714dc704.akpm@osdl.org> <20040909230905.GO3106@holomorphy.com> <20040909162245.606403d3.akpm@osdl.org> <20040910000717.GR3106@holomorphy.com> <414133EB.8020802@yahoo.com.au> <20040910174915.GA4750@logos.cnet> <20040912045636.GA2660@holomorphy.com> <4143D07E.3030408@yahoo.com.au>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <4143D07E.3030408@yahoo.com.au>
User-Agent: Mutt/1.5.5.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


> Sure. And when you fill it with pages, they'll use up 32KB of dcache
> by using a single 64B line per page. Now that you've blown the cache,
> when you go to move those pages to another list, you'll have to pull
> them out of L2 again one at a time.
>
> OK, so a 511 item pagevec is pretty unlikely. How about a 64 item one
> with 128 byte cachelines, and you're touching two cachelines per
> page operation? That's 16K.

Nick, 

Note that you dont read/write data to the actual pages most of the 
times pagevec's are used. The great majority is just page management code.  
So we dont really blow the caches like you said.

I agree we need more tests :) 

