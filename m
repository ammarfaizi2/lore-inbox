Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317856AbSGKSxf>; Thu, 11 Jul 2002 14:53:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317869AbSGKSxe>; Thu, 11 Jul 2002 14:53:34 -0400
Received: from dsl-213-023-020-056.arcor-ip.net ([213.23.20.56]:10657 "EHLO
	starship") by vger.kernel.org with ESMTP id <S317856AbSGKSxc>;
	Thu, 11 Jul 2002 14:53:32 -0400
Content-Type: text/plain; charset=US-ASCII
From: Daniel Phillips <phillips@arcor.de>
To: Thunder from the hill <thunder@ngforever.de>,
       Roman Zippel <zippel@linux-m68k.org>
Subject: Re: Rusty's module talk at the Kernel Summit
Date: Thu, 11 Jul 2002 20:50:51 +0200
X-Mailer: KMail [version 1.3.2]
Cc: Rusty Russell <rusty@rustcorp.com.au>, Alexander Viro <viro@math.psu.edu>,
       "David S. Miller" <davem@redhat.com>, <adam@yggdrasil.com>,
       <R.E.Wolff@bitwizard.nl>, <linux-kernel@vger.kernel.org>
References: <Pine.LNX.4.44.0207111158160.3582-100000@hawkeye.luckynet.adm>
In-Reply-To: <Pine.LNX.4.44.0207111158160.3582-100000@hawkeye.luckynet.adm>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Message-Id: <E17Sj1f-0002VB-00@starship>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thursday 11 July 2002 20:01, Thunder from the hill wrote:
> Hi,
> 
> On Thu, 11 Jul 2002, Roman Zippel wrote:
> > On Thu, 11 Jul 2002, Daniel Phillips wrote:
> > > Closing the rmmod race with this interface is easy.  We can for example just
> > > keep a state variable in the module struct (protected by a lock) to say the
> > > module is in the process of being deregistered.
> > 
> > Please check try_inc_mod_count(). It's already done.
> 
> Btw, couldn't the module/non-module issue be solved like this:
> 
> int module_do_blah(struct blah *blah, didel_t dei)
> #ifdef __MODULE__
> {
> 	locking_code();
> 	pure_module_do_blah(blah, dei)
> 	unlocking_code();
> }
> 
> int pure_module_do_blah(struct blah *blah, didel_t dei)
> #endif /* __MODULE__ */
> 
> Just an idea...

It's one of the ideas I had as well, except I would have expressed it:

int MODULE_OP(module_do_blah)(args)
{
	MODULE_RET(expression);
}

so that MODULE_OP and MODULE_RET would do the job of wrapping the
whole function in inc/dec (since our favorite language/compiler is
too braindamaged to do that in a nice way).  Updating all the module
code would be a massive effort, there are still holes open and it 
imposes needless execution overhead, compared to the solution Al's
preparing.  It would be better to stop wasting energy on such
fragile, clumsy low-level solutions and think about perfecting the
nice one that's on the table, or soon will be.

-- 
Daniel
