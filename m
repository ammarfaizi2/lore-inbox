Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S311562AbSCNIk2>; Thu, 14 Mar 2002 03:40:28 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S311564AbSCNIkT>; Thu, 14 Mar 2002 03:40:19 -0500
Received: from ns.suse.de ([213.95.15.193]:45074 "HELO Cantor.suse.de")
	by vger.kernel.org with SMTP id <S311562AbSCNIkE>;
	Thu, 14 Mar 2002 03:40:04 -0500
To: Rusty Russell <rusty@rustcorp.com.au>
Cc: davidm@hpl.hp.com, linux-kernel@vger.kernel.org, torvalds@transmeta.com,
        rth@twiddle.net
Subject: Re: [PATCH] 2.5.1-pre5: per-cpu areas
In-Reply-To: <15504.7958.677592.908691@napali.hpl.hp.com.suse.lists.linux.kernel> <E16lMzi-0002bb-00@wagner.rustcorp.com.au.suse.lists.linux.kernel>
From: Andi Kleen <ak@suse.de>
Date: 14 Mar 2002 09:39:57 +0100
In-Reply-To: Rusty Russell's message of "14 Mar 2002 05:37:11 +0100"
Message-ID: <p73bsdrsftu.fsf@oldwotan.suse.de>
X-Mailer: Gnus v5.7/Emacs 20.6
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Rusty Russell <rusty@rustcorp.com.au> writes:

> In message <15504.7958.677592.908691@napali.hpl.hp.com> you write:
> > OK, I see this.  Unfortunately, HIDE_RELOC() causes me problems
> > because it prevents me from taking the address of a per-CPU variable.
> > This is useful when you have a per-CPU structure (e.g., cpu_info).
> > Perhaps there should/could be a version of HIDE_RELOC() that doesn't
> > dereference the resulting address?
> 
> Yep, valid point.  Patch below: please play.

Please don't do that. I cannot easily take the address of a per CPU 
variable on x86-64, or rather only with additional overhead. If you need the
address of one please use a different macro for that.

[on x86-64 per cpu data is referenced using a segment register, but
leaq %segreg:offset,%reg does not do the expected thing, it just loads 
offset but doesn't add in the segment register base address. To get the
address I always need to fetch a pointer from the the per cpu data 
that points to itself and work with that]

-Andi
