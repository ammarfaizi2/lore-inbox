Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932641AbWAGBMe@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932641AbWAGBMe (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 6 Jan 2006 20:12:34 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932663AbWAGBMe
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 6 Jan 2006 20:12:34 -0500
Received: from zproxy.gmail.com ([64.233.162.192]:8050 "EHLO zproxy.gmail.com")
	by vger.kernel.org with ESMTP id S932641AbWAGBMd convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 6 Jan 2006 20:12:33 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=VORkexXD+TPKKL0/oA5h7lKiZeUoJcae3LMmUZSjxwPzcmVYrxGY42GZO6rnqKbwgjYC7dOHIf+yMtOoZ+P4+hqNcnMoELTkLQ22vDrikD0y0uloq3RugbaZVi/F3hDRS2YgdCWF++WhAywvqwP9CPDwBzgx7K02HOjGyLvnhM8=
Message-ID: <9a8748490601061712t6cff0af6y75d68bbabb587739@mail.gmail.com>
Date: Sat, 7 Jan 2006 02:12:32 +0100
From: Jesper Juhl <jesper.juhl@gmail.com>
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Subject: Re: 2.6.15-mm1 - locks solid when starting KDE (EDAC errors)
Cc: Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org
In-Reply-To: <1136555206.30498.10.camel@localhost.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Content-Disposition: inline
References: <9a8748490601051552x4c8315e7n3c61860283a95716@mail.gmail.com>
	 <1136555206.30498.10.camel@localhost.localdomain>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 1/6/06, Alan Cox <alan@lxorguk.ukuu.org.uk> wrote:
> On Gwe, 2006-01-06 at 00:52 +0100, Jesper Juhl wrote:
> > Unfortunately not much makes it to the logs. The only things I can
> > find is this :
> >
> > Jan  6 00:18:39 dragon kernel: [   19.479000] Write protecting the
> > kernel read-only data: 333k
> > Jan  6 00:18:57 dragon kernel: [   46.416000] EDAC PCI- Signaled
> > System Error on 0000:00:18.2
> > Jan  6 00:18:57 dragon kernel: [   46.416000] EDAC PCI- Master Data
> > Parity Error on 0000:00:18.2
> > Jan  6 00:18:57 dragon kernel: [   46.416000] EDAC PCI- Detected
> > Parity Error on 0000:00:18.2
> > <<<here I power off the system since it's locked solid>>>
>
> If those occur just at boot then they may be noise from the bios setup.
> Can you build without EDAC and check if that stops the crash. It
> shouldn't stop it crashing but if it does then its important to know
>
I just build a new 2.6.15-mm1 with the same config as before excet for
the fact that I took out the EDAC support.
It doesn't stop the crash. It still crashes at the same spot, but in a
slightly different manner.
Switching to tty1 just before the crash allowed me to write down the
last bit of several pages of output (copied by hand, so I left out
addresses an offsets, it's quite reproducable though, so if you want
that info I'll crash again and write it down for you) - here's what I
managed to get :

Stack: <0>00000001 c16cea00 c0371e78 00000000 00000000 c0371dcc
0000001f c21fbdcc
       <0>c01475c2 c0371e40 00000000 c0371d80 c0371d80 c0371d80
c0371dc0 c21fbe00
       <0>c0147a9a c0371dcc c0179602 f7afb1a0 f7ae51a0 00000000
c21fbf34 00000256
Call trace:
    show_stack
    show_registers
    die
    do_page_fault
    error_code
    rmqueue_bulk
    buffered_rmqueue
    get_page_from_freelist
    __alloc_pages
    kmem_getppages
    cache_grow
    cache_alloc_refill
    kmem_cache_alloc
    dup_task_struct
    copy_process
    do_fork
    sys_clone
    syscall_call
Code_ 00 89 55 ec 8b 90 c8 00 00 00 3b 55 ec 75 13 41 83 c0 0c 83 f9
0a 76 e3 83 c4 10 31 c0 5b 5e 5f c9 c3 8d 5a e8 89 5d e8 8b 72 04 <39>
16 75 79 8b 1a 39 53 04 75 7f 89 73 04 89 1e c7 42 04 00 02
<6>note: syslogd[1034] exited with preempt_count 2
Debug: sleeping function called from invalid context at include/linux/rwsem.h:43
in_atomic():1, irqs_disabled():1
    dump_stack
    __might_sleep
    exit_mm
    do_exit
    die
    do_page_fault
    error_code
    rmqueue_bulk
    buffered_rmqueue
    get_page_from_freelist
    __alloc_pages
    kmem_getpages
    cache_grow
    cache_alloc_refill
    kmem_cache_alloc
    dup_task_struct
    copy_process
    do_fork
    sys_clone
    syscall_call


--
Jesper Juhl <jesper.juhl@gmail.com>
Don't top-post  http://www.catb.org/~esr/jargon/html/T/top-post.html
Plain text mails only, please      http://www.expita.com/nomime.html
