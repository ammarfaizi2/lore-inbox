Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S316364AbSGQSTU>; Wed, 17 Jul 2002 14:19:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S316339AbSGQSTU>; Wed, 17 Jul 2002 14:19:20 -0400
Received: from tmr-02.dsl.thebiz.net ([216.238.38.204]:59143 "EHLO
	gatekeeper.tmr.com") by vger.kernel.org with ESMTP
	id <S316364AbSGQSTS>; Wed, 17 Jul 2002 14:19:18 -0400
To: linux-kernel@vger.kernel.org
Path: gatekeeper.tmr.com!davidsen
From: davidsen@tmr.com (bill davidsen)
Newsgroups: mail.linux-kernel
Subject: Re: Rusty's module talk at the Kernel Summit
Date: 17 Jul 2002 18:16:56 GMT
Organization: TMR Associates, Schenectady NY
Message-ID: <ah4cao$2ne$1@gatekeeper.tmr.com>
References: <Pine.LNX.4.44.0207111929500.8911-100000@serv> <Pine.LNX.4.44.0207111158160.3582-100000@hawkeye.luckynet.adm>
X-Trace: gatekeeper.tmr.com 1026929816 2798 192.168.12.62 (17 Jul 2002 18:16:56 GMT)
X-Complaints-To: abuse@tmr.com
Originator: davidsen@gatekeeper.tmr.com
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

In article <Pine.LNX.4.44.0207111158160.3582-100000@hawkeye.luckynet.adm>,
Thunder from the hill  <thunder@ngforever.de> wrote:
| Hi,
| 
| On Thu, 11 Jul 2002, Roman Zippel wrote:
| > On Thu, 11 Jul 2002, Daniel Phillips wrote:
| > > Closing the rmmod race with this interface is easy.  We can for example just
| > > keep a state variable in the module struct (protected by a lock) to say the
| > > module is in the process of being deregistered.
| > 
| > Please check try_inc_mod_count(). It's already done.
| 
| Btw, couldn't the module/non-module issue be solved like this:
| 
| int module_do_blah(struct blah *blah, didel_t dei)
| #ifdef __MODULE__
| {
| 	locking_code();
| 	pure_module_do_blah(blah, dei)
| 	unlocking_code();
| }
| 
| int pure_module_do_blah(struct blah *blah, didel_t dei)
| #endif /* __MODULE__ */
| 
| Just an idea...

Other than a thought that the locking_code() might be a non-trivial
effort to get right if preempt and smp are present, I like it. I guess
efficient is not a big concern for module ins/rm since it's not likely
to be a high rate issue.

I might write the un/lock code as a macro rather than use the ifdef, but
that's a style thing.
-- 
bill davidsen <davidsen@tmr.com>
  CTO, TMR Associates, Inc
Doing interesting things with little computers since 1979.
