Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129408AbQJaOCw>; Tue, 31 Oct 2000 09:02:52 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S130019AbQJaOCm>; Tue, 31 Oct 2000 09:02:42 -0500
Received: from ppp0.ocs.com.au ([203.34.97.3]:34821 "HELO mail.ocs.com.au")
	by vger.kernel.org with SMTP id <S129408AbQJaOC0>;
	Tue, 31 Oct 2000 09:02:26 -0500
X-Mailer: exmh version 2.1.1 10/15/1999
From: Keith Owens <kaos@ocs.com.au>
To: Russell King <rmk@arm.linux.org.uk>
cc: torvalds@transmeta.com (Linus Torvalds),
        jgarzik@mandrakesoft.com (Jeff Garzik),
        linux-kernel@vger.kernel.org (Kernel Mailing List)
Subject: Re: test10-pre7 
In-Reply-To: Your message of "Tue, 31 Oct 2000 09:37:09 -0000."
             <200010310937.JAA07048@brick.arm.linux.org.uk> 
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Date: Wed, 01 Nov 2000 01:02:10 +1100
Message-ID: <16544.973000930@ocs3.ocs-net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 31 Oct 2000 09:37:09 +0000 (GMT), 
Russell King <rmk@arm.linux.org.uk> wrote:
>Keith Owens writes:
>> kbuild 2.5 splits link order into three categories.  Those that must
>> come first, in the order they are specified - LINK_FIRST.  Those that
>> must come last, in the order they are specified - LINK_LAST.
>Take the instance where we need to link a.o first, z.o second, f.o third
>and p.o fourth.  How does LINK_FIRST / LINK_LAST guarantee this?
>
>LINK_FIRST = a.o z.o
>LINK_LAST = f.o p.o
>
>But then what guarantees that 'a.o' will be linked before 'z.o'?

LINK_FIRST is processed in the order it is specified, so a.o will be
linked before z.o when both are present.  See the patch.

>A first/last implementation can *not* specify precisely a link order without
>guaranteeing that the order of the LINK_FIRST *and* the LINK_LAST objects
>is preserved, which incidentally is the same requirement for the obj-y
>implementation.

It is preserved, see the patch.

>I don't see what this LINK_FIRST / LINK_LAST gains us other than more
>complexity for zero gain.

The vast majority of objects have no link order dependencies.  You only
specify LINK_FIRST or LINK_LAST where it is needed and only for the
small subset of objects that have critical ordering.

There are 82 obj-$(CONFIG_xxx) entries in drivers/scsi.  Which ones
must be executed first?  Which ones must be executed last?  Why do
these requirements (if any) exist?  Can I safely change the order of
any of the driver/scsi entries?  If not, why not?

LINK_FIRST and LINK_LAST serve two purposes.  They self document the
link order where that order matters.  And they solve the problem of
multi part objects being linked into the kernel, although that problem
_may_ have other solutions.  Having documentation makes life easier for
everybody.  Please do not say that the link order could be documented
in the existing Makefiles, that method has completely failed to work.

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
