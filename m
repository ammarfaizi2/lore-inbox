Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262069AbULHHmW@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262069AbULHHmW (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 8 Dec 2004 02:42:22 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262039AbULHHjX
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 8 Dec 2004 02:39:23 -0500
Received: from ns.virtualhost.dk ([195.184.98.160]:43944 "EHLO virtualhost.dk")
	by vger.kernel.org with ESMTP id S262062AbULHHha (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 8 Dec 2004 02:37:30 -0500
Date: Wed, 8 Dec 2004 08:36:37 +0100
From: Jens Axboe <axboe@suse.de>
To: Andrew Morton <akpm@osdl.org>
Cc: nickpiggin@yahoo.com.au, andrea@suse.de, linux-kernel@vger.kernel.org
Subject: Re: Time sliced CFQ io scheduler
Message-ID: <20041208073637.GF19522@suse.de>
References: <1102467253.8095.10.camel@npiggin-nld.site> <20041208013732.GF16322@dualathlon.random> <20041207180033.6699425b.akpm@osdl.org> <20041208022020.GH16322@dualathlon.random> <20041207182557.23eed970.akpm@osdl.org> <1102473213.8095.34.camel@npiggin-nld.site> <20041208065858.GH3035@suse.de> <1102490086.8095.63.camel@npiggin-nld.site> <20041208072052.GC19522@suse.de> <20041207233027.20f29a16.akpm@osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20041207233027.20f29a16.akpm@osdl.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Dec 07 2004, Andrew Morton wrote:
> Jens Axboe <axboe@suse.de> wrote:
> >
> >  I think we need to end up with something that sets the machine profile
> >  for the interesting disks. Some things you can check for at runtime
> >  (like the writes being extremely fast is a good indicator of write
> >  caching), but it is just not possible to cover it all. Plus, you end up
> >  with 30-40% of the code being convoluted stuff added to detect it.
> 
> We can detect these things from userspace.  Parse the hdparm/scsiinfo
> output, then poke numbers into /sys tunables.

The simple things, like cache settings and queue depth - definitely. The
harder things like how does this drive behave you cannot. And
unfortunately the former is also pretty easy to control (at least for
the depth) and at least gather at runtime. So I think a user mode helper
only makes sense if it can help you with real drive characteristics that
are hard to detect. Plus, settings have a nack for changing while we
are running as well.

Hmm so perhaps not such a hot idea after all. I don't envision anyone
actually doing it anyways, so...

-- 
Jens Axboe

