Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751551AbWE0Owo@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751551AbWE0Owo (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 27 May 2006 10:52:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751552AbWE0Owo
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 27 May 2006 10:52:44 -0400
Received: from ns.virtualhost.dk ([195.184.98.160]:48158 "EHLO virtualhost.dk")
	by vger.kernel.org with ESMTP id S1751550AbWE0Owo (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 27 May 2006 10:52:44 -0400
Date: Sat, 27 May 2006 16:52:24 +0200
From: Jens Axboe <axboe@suse.de>
To: Dave Jones <davej@redhat.com>, Andrew Morton <akpm@osdl.org>,
       linux-kernel@vger.kernel.org
Subject: Re: .17rc5 cfq slab corruption.
Message-ID: <20060527145224.GA13546@suse.de>
References: <20060526213915.GB7585@redhat.com> <20060526170013.67391a2b.akpm@osdl.org> <20060527070724.GB24988@suse.de> <20060527133122.GB3086@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060527133122.GB3086@redhat.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, May 27 2006, Dave Jones wrote:
> On Sat, May 27, 2006 at 09:07:24AM +0200, Jens Axboe wrote:
>  > On Fri, May 26 2006, Andrew Morton wrote:
>  > > Dave Jones <davej@redhat.com> wrote:
>  > > >
>  > > > Was playing with googles new picasa toy, which hammered the disks
>  > > > hunting out every image file it could find, when this popped out:
>  > > > 
>  > > > Slab corruption: (Not tainted) start=ffff810012b998c8, len=168
>  > > > Redzone: 0x5a2cf071/0x5a2cf071.
>  > > > Last user: [<ffffffff8032c319>](cfq_free_io_context+0x2f/0x74)
>  > > > 090: 10 bd 28 1b 00 81 ff ff 6b 6b 6b 6b 6b 6b 6b 6b
>  > > > Prev obj: start=ffff810012b99808, len=168
>  > > > Redzone: 0x5a2cf071/0x5a2cf071.
>  > > > Last user: [<ffffffff8032c319>](cfq_free_io_context+0x2f/0x74)
>  > > > 000: 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b
>  > > > 010: 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b
>  > > > Next obj: start=ffff810012b99988, len=168
>  > > > Redzone: 0x5a2cf071/0x5a2cf071.
>  > > > Last user: [<ffffffff8032c319>](cfq_free_io_context+0x2f/0x74)
>  > > > 000: 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b
>  > > > 010: 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b
>  > 
>  > Pretty baffling... cfq has been hammered pretty thoroughly over the
>  > last months and _nothing_ has shown up except some performance anomalies
>  > that are now fixed. Since daves case (at least) seems to be
>  > use-after-free, I'll see if I can reproduce with some contrived case.
>  > I'm asuming that picasa forks and exits a lot with submitted io in
>  > between than may not have finished at exit.
> 
> The second time I hit it, was actually during boot up.

Boot up sees a lot of that same pattern.

-- 
Jens Axboe

