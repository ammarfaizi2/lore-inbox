Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S287148AbSALQSt>; Sat, 12 Jan 2002 11:18:49 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S287155AbSALQSj>; Sat, 12 Jan 2002 11:18:39 -0500
Received: from penguin.e-mind.com ([195.223.140.120]:9322 "EHLO
	penguin.e-mind.com") by vger.kernel.org with ESMTP
	id <S287148AbSALQSb>; Sat, 12 Jan 2002 11:18:31 -0500
Date: Sat, 12 Jan 2002 17:17:49 +0100
From: Andrea Arcangeli <andrea@suse.de>
To: Manfred Spraul <manfred@colorfullife.com>
Cc: Andi Kleen <ak@suse.de>, Andrew Morton <akpm@zip.com.au>,
        linux-kernel@vger.kernel.org,
        Manfred Spraul <manfreds@colorfullife.com>
Subject: Re: Q: behaviour of mlockall(MCL_FUTURE) and VM_GROWSDOWN segments
Message-ID: <20020112171749.P1482@inspiron.school.suse.de>
In-Reply-To: <3C3F3C7F.76CCAF76@colorfullife.com.suse.lists.linux.kernel> <3C3F4FC6.97A6A66D@zip.com.au.suse.lists.linux.kernel> <p73r8ow4dd7.fsf@oldwotan.suse.de> <20020112163332.M1482@inspiron.school.suse.de> <20020112165443.A13179@wotan.suse.de> <3C405F4E.EADB2294@colorfullife.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.12i
In-Reply-To: <3C405F4E.EADB2294@colorfullife.com>; from manfred@colorfullife.com on Sat, Jan 12, 2002 at 05:07:42PM +0100
X-GnuPG-Key-URL: http://e-mind.com/~andrea/aa.gnupg.asc
X-PGP-Key-URL: http://e-mind.com/~andrea/aa.asc
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Jan 12, 2002 at 05:07:42PM +0100, Manfred Spraul wrote:
> Andi Kleen wrote:
> > 
> > For the stack they can get minor faults anyways when they allocate new
> > stack space below ESP. There is no good way to fix that from the kernel; the
> > application has to preallocate its memory on stack. I think it's reasonable
> > if it does the same for holes on the stack.
> >
> Ok, everyone agrees that mlockall() should not grow VM_GROWSDOWN
> segments to their maximum size.

Ah, definitely. I must have misunderstood something in the discussion
sorry, I thought we were just discussiong the below issue, and I
completly missed the "maximum size" one.

All I was trying to find out here, was about the intermediate pages
between vm_start and vm_end of a VM_GROWSDOWN|VM_LOCKED vma, exactly
your example below.

> Should the page fault handler fill the hole created by
> 
> void * grow_stack(void)
> {
> 	char data[100000];
> 	data[0] = '0';
> 	return data;
> }
> 
> The principle of least surprise would mean filling holes, but OTHO sane
> apps would use memset(data,0,sizeof(data)).

yep.

Andrea
