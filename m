Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262329AbUC1SRl (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 28 Mar 2004 13:17:41 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262322AbUC1SRl
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 28 Mar 2004 13:17:41 -0500
Received: from ns.virtualhost.dk ([195.184.98.160]:61390 "EHLO virtualhost.dk")
	by vger.kernel.org with ESMTP id S262316AbUC1SRf (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 28 Mar 2004 13:17:35 -0500
Date: Sun, 28 Mar 2004 20:17:08 +0200
From: Jens Axboe <axboe@suse.de>
To: William Lee Irwin III <wli@holomorphy.com>,
       Jeff Garzik <jgarzik@pobox.com>, Nick Piggin <nickpiggin@yahoo.com.au>,
       linux-ide@vger.kernel.org, Linux Kernel <linux-kernel@vger.kernel.org>,
       Andrew Morton <akpm@osdl.org>
Subject: Re: [PATCH] speed up SATA
Message-ID: <20040328181708.GP24370@suse.de>
References: <40661049.1050004@yahoo.com.au> <406611CA.3050804@pobox.com> <406612AA.1090406@yahoo.com.au> <4066156F.1000805@pobox.com> <20040328141014.GE24370@suse.de> <40670BD9.9020707@pobox.com> <20040328173508.GI24370@suse.de> <40670FDB.6080409@pobox.com> <20040328175436.GL24370@suse.de> <20040328181223.GA791@holomorphy.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040328181223.GA791@holomorphy.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Mar 28 2004, William Lee Irwin III wrote:
> On Sun, Mar 28, 2004 at 07:54:36PM +0200, Jens Axboe wrote:
> > Sorry, but I cannot disagree more. You think an artificial limit at the
> > block layer is better than one imposed at the driver end, which actually
> > has a lot more of an understanding of what hardware it is driving? This
> > makes zero sense to me. Take floppy.c for instance, I really don't want
> > 1MB requests there, since that would take a minute to complete. And I
> > might not want 1MB requests on my Super-ZXY storage, because that beast
> > completes io easily at an iorate of 200MB/sec.
> > So you want to put this _policy_ in the block layer, instead of in the
> > driver. That's an even worse decision if your reasoning is policy. The
> > only such limits I would want to put in, are those of the bio where
> > simply is best to keep that small and contained within a single page to
> > avoid higher order allocations to do io. Limits based on general sound
> > principles, not something that caters to some particular piece of
> > hardware. I absolutely refuse to put a global block layer 'optimal io
> > size' restriction in, since that is the ugliest of policies and without
> > having _any_ knowledge of what the hardware can do.
> 
> How about per-device policies and driver hints wrt. optimal io?

That would be fine, it's what I suggested in an earlier email. In the
future Jamie's suggestion is probably the one that makes the most sense
- just keep a per-driver limit setting which informs the block layer of
max sectors the hardware truly can do, and try and time request
execution if you care about latencies.

But lets not forget the original question, which is when and if 32MB
request make sense at all. Right now they probably don't.

-- 
Jens Axboe

