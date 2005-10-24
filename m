Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751137AbVJXXDT@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751137AbVJXXDT (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 24 Oct 2005 19:03:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751350AbVJXXDT
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 24 Oct 2005 19:03:19 -0400
Received: from e33.co.us.ibm.com ([32.97.110.151]:17889 "EHLO
	e33.co.us.ibm.com") by vger.kernel.org with ESMTP id S1751137AbVJXXDT
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 24 Oct 2005 19:03:19 -0400
Date: Mon, 24 Oct 2005 16:03:57 -0700
From: "Paul E. McKenney" <paulmck@us.ibm.com>
To: Badari Pulavarty <pbadari@gmail.com>
Cc: Kyle Moffett <mrmacman_g4@mac.com>, Andrew Morton <akpm@osdl.org>,
       Ingo Oeser <ioe-lkml@rameria.de>, lkml <linux-kernel@vger.kernel.org>,
       arjan@infradead.org, pavel@ucw.cz, dipankar@in.ibm.com,
       vatsa@in.ibm.com, rusty@au1.ib.com, mingo@elte.hu,
       manfred@colorfullife.com, gregkh@kroah.com
Subject: Re: [PATCH] RCU torture-testing kernel module
Message-ID: <20051024230357.GG12812@us.ibm.com>
Reply-To: paulmck@us.ibm.com
References: <20051022231214.GA5847@us.ibm.com> <200510230922.26550.ioe-lkml@rameria.de> <20051023143617.GA7961@us.ibm.com> <200510232055.17782.ioe-lkml@rameria.de> <20051023120521.26031051.akpm@osdl.org> <20051024004709.GA9454@us.ibm.com> <1130171073.6831.6.camel@localhost.localdomain> <5D5AD6EA-5D6E-47DA-8170-0729F9C32889@mac.com> <1130177458.6831.11.camel@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1130177458.6831.11.camel@localhost.localdomain>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Oct 24, 2005 at 11:10:58AM -0700, Badari Pulavarty wrote:
> On Mon, 2005-10-24 at 13:59 -0400, Kyle Moffett wrote:
> > On Oct 24, 2005, at 12:24:33, Badari Pulavarty wrote:
> > > Paul,
> > >
> > > I enabled RCU_TORTURE_TEST in 2.6.14-rc5-mm1. My machine took 10+  
> > > minutes to boot and let me login. RCU kthreads are hogging the  
> > > CPU.  Is this expected ?
> > 
> > Uhh...  It's a torture test.  What exactly do _you_ expect it will  
> > do?  I think the idea is to enable it as a module and load it when  
> > you want to start torture testing, and unload it when done.   
> > "TORTURE_TEST"s are not for production systems :-D.

Hey, and if you think that is fun, just try compiling it in
(CONFIG_RCU_TORTURE_TEST=y) and then build rcutorture.c as an
external module, then insmod'ing it!  You get two torture tests
running concurrently.  I found this out the hard way while
learning how the "tristate" directive works.

> I was expecting that - even if its compiled in, there would be
> a way to turn on/off the tests from /proc or something :)

Well, I submitted -that- patch a couple of weeks ago, and it was
roundly denounced for /proc pollution, hence the shiny new modules
implementation of it.

I must admit I was rather negative on the idea of using modules
for this sort of thing, but after actually trying it, I found that
it really works quite nicely.  The module loader even parses all
your arguments for you, so you can very easily parameterize the
tests.

						Thanx, Paul
