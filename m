Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932319AbWCIAau@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932319AbWCIAau (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 8 Mar 2006 19:30:50 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932631AbWCIAau
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 8 Mar 2006 19:30:50 -0500
Received: from smtp3.Stanford.EDU ([171.67.16.138]:40165 "EHLO
	smtp3.Stanford.EDU") by vger.kernel.org with ESMTP id S932319AbWCIAat
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 8 Mar 2006 19:30:49 -0500
Subject: Re: 2.6.15-rt20, "bad page state", jackd
From: Fernando Lopez-Lezcano <nando@ccrma.Stanford.EDU>
To: Steven Rostedt <rostedt@goodmis.org>, Ingo Molnar <mingo@elte.hu>
Cc: nando@ccrma.Stanford.EDU,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
In-Reply-To: <1141854504.5262.36.camel@cmn3.stanford.edu>
References: <1141846564.5262.20.camel@cmn3.stanford.edu>
	 <1141854504.5262.36.camel@cmn3.stanford.edu>
Content-Type: text/plain
Date: Wed, 08 Mar 2006 16:30:32 -0800
Message-Id: <1141864232.5262.47.camel@cmn3.stanford.edu>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.3 (2.2.3-2.fc4) 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2006-03-08 at 13:48 -0800, Fernando Lopez-Lezcano wrote:
> On Wed, 2006-03-08 at 11:36 -0800, Fernando Lopez-Lezcano wrote:
> > Hi all, I reported this in mid January (I thought I had sent to the list
> > but the report went to Ingo and Steven off list)
> > 
> > I'm seeing the same problem in 2.6.15-rt21 in some of my machines. After
> > a reboot into the kernel I just login as root in a terminal, start the
> > jackd sound server ("jackd -d alsa -d hw") and when stopping it (just
> > doing a <ctrl>c) I get a bunch of messages of this form:
> > 
> > > Trying to fix it up, but a reboot is needed
> > > Bad page state at __free_pages_ok (in process 'jackd', page c10012fc)
> > 
> > Has anyone else seen this?
> > 
> > I'm in the process of building an -rt21 kernel before posting more
> > detailed error messages (this kernel is patched with some additional
> > stuff). 
> 
> This is what the errors look like (I'm attaching the whole dmesg output
> and the .config file used to build the smp kernel):
> 
> Bad page state at __free_pages_ok (in process 'jackd', page c1013ce0)
> flags:0x00000414 mapping:00000000 mapcount:0 count:0
> Backtrace:
>  [<c015947d>] bad_page+0x7d/0xc0 (8)
>  [<c01598fd>] __free_pages_ok+0x9d/0x180 (36)
>  [<c015a5ac>] __pagevec_free+0x3c/0x50 (40)
>  [<c015db47>] release_pages+0x127/0x1a0 (16)
>  [<c016c93d>] free_pages_and_swap_cache+0x7d/0xc0 (80)
>  [<c01681ae>] unmap_region+0x13e/0x160 (28)
>  [<c0168461>] do_munmap+0xe1/0x120 (48)
>  [<c01684df>] sys_munmap+0x3f/0x60 (32)
>  [<c01034a1>] syscall_call+0x7/0xb (16)
> Trying to fix it up, but a reboot is needed

[MUNCH]

> I'm now building another -rt21 with DEBUG_PAGEALLOC and DEBUG_SLAB
> enabled to see if I can pinpoint in more detail what's happening (if I
> can get it to boot!). 

I'm not able to boot with those two options enabled. It looks like it is
hanging after loading the sound drivers - this is on top of fc4. I can't
even get to single user and I'm searching for a serial cable right now
to see if I can get more information in a way that can be posted here. 
Arghhh :-)
-- Fernando


