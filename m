Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S266453AbTAQCAR>; Thu, 16 Jan 2003 21:00:17 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265633AbTAQCAR>; Thu, 16 Jan 2003 21:00:17 -0500
Received: from are.twiddle.net ([64.81.246.98]:9355 "EHLO are.twiddle.net")
	by vger.kernel.org with ESMTP id <S261486AbTAQCAQ>;
	Thu, 16 Jan 2003 21:00:16 -0500
Date: Thu, 16 Jan 2003 18:09:13 -0800
From: Richard Henderson <rth@twiddle.net>
To: Rusty Russell <rusty@rustcorp.com.au>
Cc: linux-kernel@vger.kernel.org, davem@vger.kernel.org
Subject: Re: [module-init-tools] fix weak symbol handling
Message-ID: <20030116180913.C15981@twiddle.net>
Mail-Followup-To: Rusty Russell <rusty@rustcorp.com.au>,
	linux-kernel@vger.kernel.org, davem@vger.kernel.org
References: <20030114171457.E5751@twiddle.net> <20030117015756.409DF2C437@lists.samba.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <20030117015756.409DF2C437@lists.samba.org>; from rusty@rustcorp.com.au on Fri, Jan 17, 2003 at 12:57:03PM +1100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jan 17, 2003 at 12:57:03PM +1100, Rusty Russell wrote:
> > No.  The semantics I need is if A references a weak symbol S 
> > and *no one* implements it, then S resolves to NULL.
> 
> Sorry, I was unclear.  I want to know the dependency semantics:
> 
> If B exports S, should depmod believe A needs B, or not?  Your patch
> leaves that semantic (all it does is suppress the errors).

Well, that depends on whether A defines S or not.  If A does
define S, then I don't care.  I'd say "no", A does not depend
on B.  If A does not define S, then most definitely "yes", as
with any other definition.

> I'm not sure what semantics are "right", since I don't know what
> you're trying to do, or what is wrong with get_symbol().

I just told you.  Quoted again above.  Perhaps the following
dummy module will make things even clearer.

---
#include <linux/module.h>
#include <linux/init.h>

extern int not_defined __attribute__((weak));

static int init(void)
{
  return &not_defined ? -EINVAL : 0;
}

static void fini(void)
{
}

module_init(init);
module_exit(fini);
---

You should be able to load this module.


r~
