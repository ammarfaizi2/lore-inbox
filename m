Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S281762AbRKQPPP>; Sat, 17 Nov 2001 10:15:15 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S281763AbRKQPPG>; Sat, 17 Nov 2001 10:15:06 -0500
Received: from atrey.karlin.mff.cuni.cz ([195.113.31.123]:11782 "EHLO
	atrey.karlin.mff.cuni.cz") by vger.kernel.org with ESMTP
	id <S281762AbRKQPOs>; Sat, 17 Nov 2001 10:14:48 -0500
Date: Sat, 17 Nov 2001 16:14:36 +0100
From: Jan Hubicka <jh@suse.cz>
To: Momchil Velikov <velco@fadata.bg>
Cc: linux-kernel@vger.kernel.org, gcc@gcc.gnu.org
Subject: Re: i386 flags register clober in inline assembly
Message-ID: <20011117161436.B23331@atrey.karlin.mff.cuni.cz>
In-Reply-To: <87y9l58pb5.fsf@fadata.bg>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <87y9l58pb5.fsf@fadata.bg>
User-Agent: Mutt/1.3.20i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> 
> There are several inline assembly routines in the i386 port, which
> clobber the flags register, nevertheless fail to declare that.
> E.g. atomic_inc
> 
> 	__asm__ __volatile__(
> 		LOCK "incl %0"
> 		:"=m" (v->counter)
> 		:"m" (v->counter));
> 
> should be
> 
> 	__asm__ __volatile__(
> 		LOCK "incl %0"
> 		:"=m" (v->counter)
> 		:"m" (v->counter)
>                 : "cc");
> 
> since "incl" clobbers flags.
> 
> Any ideas if these functions should be corrected ?
They don't need to be. On i386, the flags are (partly for historical reasons) clobbered
by default.
> 
> Although gcc documentation says "cc" has no effect on some machines,
> it seems this is not the case with i386, judging from the "(set (reg:CC 17) ..."
> and "(clobber (reg:CC 17))" in i386.md.
i386.md does add the clobber to each asm statement.

Honza
> 
> Regards,
> -velco
> 
