Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751101AbWE3NpA@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751101AbWE3NpA (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 30 May 2006 09:45:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751503AbWE3NpA
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 30 May 2006 09:45:00 -0400
Received: from mx1.redhat.com ([66.187.233.31]:12474 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S1751101AbWE3No7 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 30 May 2006 09:44:59 -0400
Date: Tue, 30 May 2006 09:44:50 -0400
From: Dave Jones <davej@redhat.com>
To: Jens Axboe <axboe@suse.de>
Cc: Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org
Subject: Re: .17rc5 cfq slab corruption.
Message-ID: <20060530134450.GF14721@redhat.com>
Mail-Followup-To: Dave Jones <davej@redhat.com>, Jens Axboe <axboe@suse.de>,
	Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org
References: <20060526213915.GB7585@redhat.com> <20060526170013.67391a2b.akpm@osdl.org> <20060527070724.GB24988@suse.de> <20060527133122.GB3086@redhat.com> <20060530131728.GX4199@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060530131728.GX4199@suse.de>
User-Agent: Mutt/1.4.2.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, May 30, 2006 at 03:17:28PM +0200, Jens Axboe wrote:
 > On Sat, May 27 2006, Dave Jones wrote:
 > > On Sat, May 27, 2006 at 09:07:24AM +0200, Jens Axboe wrote:
 > >  > On Fri, May 26 2006, Andrew Morton wrote:
 > >  > > Dave Jones <davej@redhat.com> wrote:
 > >  > > >
 > >  > > > Was playing with googles new picasa toy, which hammered the disks
 > >  > > > hunting out every image file it could find, when this popped out:
 > >  > > > 
 > >  > > > Slab corruption: (Not tainted) start=ffff810012b998c8, len=168
 > >  > > > Redzone: 0x5a2cf071/0x5a2cf071.
 > >  > > > Last user: [<ffffffff8032c319>](cfq_free_io_context+0x2f/0x74)
 > >  > > > 090: 10 bd 28 1b 00 81 ff ff 6b 6b 6b 6b 6b 6b 6b 6b
 > >  > > > Prev obj: start=ffff810012b99808, len=168
 > >  > > > Redzone: 0x5a2cf071/0x5a2cf071.
 > >  > > > Last user: [<ffffffff8032c319>](cfq_free_io_context+0x2f/0x74)
 > >  > > > 000: 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b
 > >  > > > 010: 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b
 > >  > > > Next obj: start=ffff810012b99988, len=168
 > >  > > > Redzone: 0x5a2cf071/0x5a2cf071.
 > >  > > > Last user: [<ffffffff8032c319>](cfq_free_io_context+0x2f/0x74)
 > >  > > > 000: 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b
 > >  > > > 010: 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b
 > >  > 
 > >  > Pretty baffling... cfq has been hammered pretty thoroughly over the
 > >  > last months and _nothing_ has shown up except some performance anomalies
 > >  > that are now fixed. Since daves case (at least) seems to be
 > >  > use-after-free, I'll see if I can reproduce with some contrived case.
 > >  > I'm asuming that picasa forks and exits a lot with submitted io in
 > >  > between than may not have finished at exit.
 > > 
 > > The second time I hit it, was actually during boot up.
 > 
 > Dave, do you have any io scheduler switching going on?

Nope, everything set to use CFQ as default, and left that way.

		Dave

-- 
http://www.codemonkey.org.uk
