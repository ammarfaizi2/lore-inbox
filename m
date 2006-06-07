Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751055AbWFGGXe@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751055AbWFGGXe (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 7 Jun 2006 02:23:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751056AbWFGGXd
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 7 Jun 2006 02:23:33 -0400
Received: from ns.virtualhost.dk ([195.184.98.160]:46690 "EHLO virtualhost.dk")
	by vger.kernel.org with ESMTP id S1751053AbWFGGXd (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 7 Jun 2006 02:23:33 -0400
Date: Wed, 7 Jun 2006 08:22:08 +0200
From: Jens Axboe <axboe@suse.de>
To: Andrew Morton <akpm@osdl.org>
Cc: Ingo Molnar <mingo@elte.hu>, laurent.riffard@free.fr, barryn@pobox.com,
       76306.1226@compuserve.com, linux-kernel@vger.kernel.org,
       jbeulich@novell.com, arjan@linux.intel.com
Subject: Re: 2.6.17-rc5-mm1
Message-ID: <20060607062208.GZ6693@suse.de>
References: <44840838.7030802@free.fr> <4484584D.4070108@free.fr> <20060605110046.2a7db23f.akpm@osdl.org> <986ed62e0606051452x320cce2ap9598558b5343ae6b@mail.gmail.com> <20060606072628.GA28752@elte.hu> <4485E0D3.8080708@free.fr> <20060606205801.GC17787@elte.hu> <4485F5E2.5040708@free.fr> <20060606220507.GA19882@elte.hu> <20060606152930.adc58fe4.akpm@osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060606152930.adc58fe4.akpm@osdl.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jun 06 2006, Andrew Morton wrote:
> On Wed, 7 Jun 2006 00:05:07 +0200
> Ingo Molnar <mingo@elte.hu> wrote:
> 
> > 
> > * Laurent Riffard <laurent.riffard@free.fr> wrote:
> > 
> > > >> Results:
> > > >> - 2.6.17-rc4-mm3 with 4K stack works fine (this is the latest good 4K-kernel).
> > > >> - 2.6.17-rc5-mm3 with 4K stack crashes, the stack seems to be corrupted.
> > > > 
> > > > that's vanilla mm3, or mm3 patched with extra lockdep patches? If it's 
> > > > patched then you should try vanilla mm3 too.
> > > 
> > > It was vanilla mm3.
> > 
> > ok, i'll check the stack impact of the block_dev.c changes tomorrow.
> > 
> 
> Note that Laurent is also passing through ide_cdrom_packet(), which has a
> `struct request' on the stack.  The kernel does this in a lot of places,
> and at 168 bytes on x86, it'd really be best if we were to dynamically
> allocate these things.

That's an old peeve of mine, on-stack requests... It's nasty from
several angles, stack usage just being one of them. Perhaps I'll give it
a go for 2.6.18 and add checks for request being thrown at the block
layer which didn't originate from get_request().

-- 
Jens Axboe

