Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751052AbWCIIsH@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751052AbWCIIsH (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 9 Mar 2006 03:48:07 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751061AbWCIIsH
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 9 Mar 2006 03:48:07 -0500
Received: from mtagate2.de.ibm.com ([195.212.29.151]:41004 "EHLO
	mtagate2.de.ibm.com") by vger.kernel.org with ESMTP
	id S1751052AbWCIIsG (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 9 Mar 2006 03:48:06 -0500
Date: Thu, 9 Mar 2006 09:47:46 +0100
From: Heiko Carstens <heiko.carstens@de.ibm.com>
To: Fernando Lopez-Lezcano <nando@ccrma.Stanford.EDU>
Cc: Steven Rostedt <rostedt@goodmis.org>, Ingo Molnar <mingo@elte.hu>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: 2.6.15-rt20, "bad page state", jackd
Message-ID: <20060309084746.GB9408@osiris.boeblingen.de.ibm.com>
References: <1141846564.5262.20.camel@cmn3.stanford.edu>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1141846564.5262.20.camel@cmn3.stanford.edu>
User-Agent: mutt-ng/devel-r781 (Linux)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Mar 08, 2006 at 11:36:04AM -0800, Fernando Lopez-Lezcano wrote:
> Hi all, I reported this in mid January (I thought I had sent to the list
> but the report went to Ingo and Steven off list)
> 
> I'm seeing the same problem in 2.6.15-rt21 in some of my machines. After
> a reboot into the kernel I just login as root in a terminal, start the
> jackd sound server ("jackd -d alsa -d hw") and when stopping it (just
> doing a <ctrl>c) I get a bunch of messages of this form:
> 
> > Trying to fix it up, but a reboot is needed
> > Bad page state at __free_pages_ok (in process 'jackd', page c10012fc)
> 
> Has anyone else seen this?

Actually I have a bug report that looks quite the same. Happens on s390x
with lots of I/O stress. But that is against vanilla 2.6.16-rc4 + additional
patches. I need to ask to reproduce that with a plain vanilla kernel, so
that a git bisect search might help to figure out what is wrong.
Unfortunately it seems to take hours before we hit the bug.

<0>Bad page state in process 'blast'
<0>page:0000000000507d00 flags:0x000000060000002a mapping:00000000007570b0 mapcount:1 count:8
<0>Trying to fix it up, but a reboot is needed
<0>Backtrace:
<4>0000000006e93750 0000000000000000 0000000000773780 0700000000007c7a 
<4>       0000000000000001 000000000025f878 000000000025f878 0000000000104840 
<4>       0000000000000000 000000060000002a 0000000000000000 0000000000518d50 
<4>       000000000000000c 0000000000000008 0000000006e936f8 0000000006e93770 
<4>       000000000044e1f0 0000000000104840 0000000006e936f8 0000000006e93738 
<4>Call Trace:
<4>([<0000000000104870>] dump_stack+0x2b8/0x374)
<4> [<00000000001a97de>] get_page_from_freelist+0x72e/0x8e8
<4> [<00000000001a9aa8>] __alloc_pages+0x110/0x324
<4> [<00000000001b37a0>] page_cache_readahead+0xf6c/0x11e4
<4> [<000000000019f870>] do_generic_mapping_read+0x150/0x828
<4> [<00000000001a07f4>] generic_file_aio_read+0x1f8/0x258
<4> [<00000000001fa844>] do_sync_read+0x130/0x1bc
<4> [<00000000001fc230>] sys_read+0x170/0x3b8
<4> [<000000000010fb20>] sysc_tracego+0xe/0x14
<4> [<0000020000043a84>] 0x20000043a84

Heiko
