Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S316878AbSH0Ty2>; Tue, 27 Aug 2002 15:54:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S316897AbSH0Ty2>; Tue, 27 Aug 2002 15:54:28 -0400
Received: from ns.suse.de ([213.95.15.193]:2565 "EHLO Cantor.suse.de")
	by vger.kernel.org with ESMTP id <S316878AbSH0Ty1>;
	Tue, 27 Aug 2002 15:54:27 -0400
To: Dean Nelson <dcn@sgi.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: atomic64_t proposal
References: <200208271937.OAA78345@cyan.americas.sgi.com.suse.lists.linux.kernel>
From: Andi Kleen <ak@suse.de>
Date: 27 Aug 2002 21:58:45 +0200
In-Reply-To: Dean Nelson's message of "27 Aug 2002 21:41:25 +0200"
Message-ID: <p73sn102hvu.fsf@oldwotan.suse.de>
X-Mailer: Gnus v5.7/Emacs 20.6
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Dean Nelson <dcn@sgi.com> writes:

> I'm proposing the creation of an atomic64_t variable, which is a 64-bit
> version of atomic_t, and the usage of the __typeof__ keyword in macro versions
> of the atomic operations to enable them to operate on either type (atomic_t and
> atomic64_t).
> 
> I submitted the following patch to David Mosberger to be considered for
> inclusion in the IA-64 linux kernel. He suggested that I bring the topic up
> on this list so that the other 64-bit platform maintainers can commment.

Wouldn't it be much cleaner to just define atomic64_add/sub/read etc. ?
That would make the macros much nicer.

On x86-64 it would be fine this way.

Is it supposed to only work on 64bit or do you plan to supply it for 32
bit too? If no, I don't see how drivers etc. should ever use it. linux 
is supposed to have a common kernel api.
If yes, the implementation on 32bit could be a problem. e.g. some 
archs need space in there for spinlocks, so it would be needed to limit
the usable range.

-Andi
