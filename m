Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267531AbUHPLQf@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267531AbUHPLQf (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 16 Aug 2004 07:16:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267540AbUHPLQf
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 16 Aug 2004 07:16:35 -0400
Received: from viper.oldcity.dca.net ([216.158.38.4]:49832 "HELO
	viper.oldcity.dca.net") by vger.kernel.org with SMTP
	id S267531AbUHPLQU (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 16 Aug 2004 07:16:20 -0400
Subject: Re: [patch] voluntary-preempt-2.6.8.1-P1
From: Lee Revell <rlrevell@joe-job.com>
To: Florian Schmidt <mista.tapas@gmx.net>
Cc: Ingo Molnar <mingo@elte.hu>, linux-kernel <linux-kernel@vger.kernel.org>,
       Felipe Alfaro Solana <felipe_alfaro@linuxmail.org>
In-Reply-To: <20040816131359.1107bd69@mango.fruits.de>
References: <20040815115649.GA26259@elte.hu>
	 <20040816022554.16c3c84a@mango.fruits.de>
	 <1092622121.867.109.camel@krustophenia.net> <20040816023655.GA8746@elte.hu>
	 <1092624221.867.118.camel@krustophenia.net>
	 <20040816032806.GA11750@elte.hu> <20040816033623.GA12157@elte.hu>
	 <1092627691.867.150.camel@krustophenia.net>
	 <20040816034618.GA13063@elte.hu> <1092628493.810.3.camel@krustophenia.net>
	 <20040816040515.GA13665@elte.hu>  <20040816131359.1107bd69@mango.fruits.de>
Content-Type: text/plain
Message-Id: <1092655029.13981.24.camel@krustophenia.net>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6 
Date: Mon, 16 Aug 2004 07:17:10 -0400
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2004-08-16 at 07:13, Florian Schmidt wrote:
> On Mon, 16 Aug 2004 06:05:15 +0200
> Ingo Molnar <mingo@elte.hu> wrote:
> 
> > 
> > * Lee Revell <rlrevell@joe-job.com> wrote:
> > 
> > > Anyway, the change to sched.c fixes the mlockall bug, it works
> > > perfectly now.  Thanks!
> > 
> > great! This fix also means that we've got one more lock-break in the
> > ext3 journalling code and one more lock-break in dcache.c. I've
> > released-P1 with the fix included:
> > 
> >  http://redhat.com/~mingo/voluntary-preempt/voluntary-preempt-2.6.8.1-P1
> 
> Hi,
> 
> cool, i can mlockall_test 500000  without an xrun in jackd! :) 
> 
> But it seems that this wasn't the only thing causing an xrun on jackd
> client startup. I will try to take another look at the jackd source..
> 

Ingo mentioned that possibly the mlockall issue resulted from both
processes mapping some of the same pages, which was ruled out by using
small test programs, but maybe that is what is going on here.  A jack
client and server by definition have to map some of the same pages.

Would it be worthwhile to compile the jack client -static?

Lee

