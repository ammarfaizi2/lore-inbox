Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S266473AbSLTXm4>; Fri, 20 Dec 2002 18:42:56 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S266546AbSLTXm4>; Fri, 20 Dec 2002 18:42:56 -0500
Received: from neon-gw-l3.transmeta.com ([63.209.4.196]:59920 "EHLO
	neon-gw.transmeta.com") by vger.kernel.org with ESMTP
	id <S266473AbSLTXmz>; Fri, 20 Dec 2002 18:42:55 -0500
Message-ID: <3E03ACCD.70600@transmeta.com>
Date: Fri, 20 Dec 2002 15:50:37 -0800
From: "H. Peter Anvin" <hpa@transmeta.com>
Organization: Transmeta Corporation
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.3a) Gecko/20021119
X-Accept-Language: en, sv
MIME-Version: 1.0
To: Jamie Lokier <lk@tantalophile.demon.co.uk>
CC: Linus Torvalds <torvalds@transmeta.com>,
       Ulrich Drepper <drepper@redhat.com>, bart@etpmod.phys.tue.nl,
       davej@codemonkey.org.uk, terje.eggestad@scali.com,
       matti.aarnio@zmailer.org, hugh@veritas.com, mingo@elte.hu,
       linux-kernel@vger.kernel.org
Subject: Re: Intel P6 vs P7 system call performance
References: <20021220120656.GA20674@bjl1.asuk.net> <Pine.LNX.4.44.0212200834590.2035-100000@home.transmeta.com> <20021220233825.GA22232@bjl1.asuk.net>
In-Reply-To: <20021220233825.GA22232@bjl1.asuk.net>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Jamie Lokier wrote:
> 
> No, your "real" code sequence is wrong.
> 
> %ebx/%edi/%esi are preserved across sysenter/sysexit, whereas
> %ecx/%edx are call-clobbered registers in the i386 function call ABI.
> 
> This is not a coincidence.
> 
> So, getpid looks like this with the _smaller_ vsyscall code:
> 
>  	getpid():
>  		movl $__NR_getpid,%eax
>  		call *%gs:0x18
>  		ret

... or just...

getpid:
	movl $__NR_getpid, %eax
	jmp *%gs:0x18

This doesn't mess up the call/return stack, even, because the ret in the
stub matches the call to getpid.

	-hpa

