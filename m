Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265897AbUATX1K (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 20 Jan 2004 18:27:10 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265902AbUATX0c
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 20 Jan 2004 18:26:32 -0500
Received: from gprs214-112.eurotel.cz ([160.218.214.112]:9088 "EHLO amd.ucw.cz")
	by vger.kernel.org with ESMTP id S265897AbUATX0R (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 20 Jan 2004 18:26:17 -0500
Date: Wed, 21 Jan 2004 00:25:15 +0100
From: Pavel Machek <pavel@suse.cz>
To: Andrew Morton <akpm@osdl.org>
Cc: linux-kernel@vger.kernel.org, trivial@rustcorp.com.au
Subject: Re: More cleanups for swsusp
Message-ID: <20040120232515.GD1234@elf.ucw.cz>
References: <20040120225219.GA19190@elf.ucw.cz> <20040120151358.09608fc3.akpm@osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040120151358.09608fc3.akpm@osdl.org>
X-Warning: Reading this can be dangerous to your mental health.
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

> > +	BUG_ON (sizeof(struct link) != PAGE_SIZE);
> 
> Looking at the code, this hardly seems worth checking.  But the compiler
> should just rub this code out anwyay, so whatever.
> 
> hmm, one could do:
> 
> #define compile_time_assert(expr)					\
> 	do {								\
> 		if (!(expr))						\
> 			compile_time_assert_failed();	/* undefined */	\
> 	} while (0)

Well, if you provide such macro, I'll be happy to use it ;-). It
should be something like 

compile_time_assert(expr, "message")

because with more of these are in the code, it would be nightmare to
find out which one is wrong.

Perhaps better name, too?

pavel@elonex:/tmp$ cat delme.c

#define COMPILE_ERR_ON(expr, message) \
        do { if (!(expr)) compile_time_assert_failed_##message(); } while (0)

void main(void)
{
        COMPILE_ERR_ON(0==8, cpu_broke_zeros_neck);
        COMPILE_ERR_ON(0==0, compiler_went_crazy);
}
pavel@elonex:/tmp$ gcc delme.c -o delme
delme.c: In function `main':
delme.c:6: warning: return type of `main' is not `int'
/tmp/ccAx2alr.o(.text+0x11): In function `main':
: undefined reference to `compile_time_assert_failed_cpu_broke_zeros_neck'
collect2: ld returned 1 exit status
pavel@elonex:/tmp$



								Pavel

-- 
When do you have a heart between your knees?
[Johanka's followup: and *two* hearts?]
