Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S273372AbRIWKng>; Sun, 23 Sep 2001 06:43:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S273376AbRIWKn0>; Sun, 23 Sep 2001 06:43:26 -0400
Received: from obelix.hrz.tu-chemnitz.de ([134.109.132.55]:43414 "EHLO
	obelix.hrz.tu-chemnitz.de") by vger.kernel.org with ESMTP
	id <S273372AbRIWKnQ>; Sun, 23 Sep 2001 06:43:16 -0400
Date: Sun, 23 Sep 2001 12:43:36 +0200
From: Ingo Oeser <ingo.oeser@informatik.tu-chemnitz.de>
To: Rusty Russell <rusty@rustcorp.com.au>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [PATCH] PART1: Proposed init & module changes for 2.5
Message-ID: <20010923124336.D30515@nightmaster.csn.tu-chemnitz.de>
In-Reply-To: <E15l2tb-0004KK-00@wagner>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2i
In-Reply-To: <E15l2tb-0004KK-00@wagner>; from rusty@rustcorp.com.au on Sun, Sep 23, 2001 at 04:37:43PM +1000
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

I like the PARAM() part, but still have some question. Hope you
can clarify.

On Sun, Sep 23, 2001 at 04:37:43PM +1000, Rusty Russell wrote:
> OLD:	module_init(initfn)
> NEW:	init_and_startcall(initfn, startfn);
> COMMENTS:
> 	Please use a semicolon at the end.  Modulable code should
> 	transition to a two-stage init (initfn sets everything up
> 	and may fail, and startfn which exposes the module to the rest
> 	of the kernel and can't fail).  Some modules only need
> 	initfn or startfn, in which case use initcall() or startcall().
 
Why separating them?

> OLD:	void exitfn(void) { ...; }
> 	module_exit(void)
> NEW:	int stopfn(void) { ...; return 0; }
> 	void exitfn(void) { ...; }
> 	stopcall(stopfn);
> 	exitcall(exitfn);
> COMMENTS:
> 	If there are neither, then module is not unloadable.  This is
> 	perfectly OK.  If stopfn returns 0 (otherwise it should be
> 	-errno) it must have deregistered itself from the rest of the
> 	kernel (ie. module count can never increase again), but still
> 	be usable to anyone using it currently.  Once exitfn is
> 	called, it is guaranteed to be unused.

Same question here: Why you changed this? 

What is meant with "usable to anyone using it currently"? 
Does it mean the variables of it can still be read/written? 
Can the startcall or the initcall still be called after stopcall? 

(Important if we rely on zero initialization, which we do in many
modules).

Can IO to ports still be issued and "transactions" still be
finished after stopcall has been issued?

Thanks and Regards

Ingo Oeser
-- 
In der Wunschphantasie vieler Mann-Typen [ist die Frau] unsigned und
operatorvertraeglich. --- Dietz Proepper in dasr
