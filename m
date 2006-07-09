Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1161014AbWGIRzW@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161014AbWGIRzW (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 9 Jul 2006 13:55:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161026AbWGIRzW
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 9 Jul 2006 13:55:22 -0400
Received: from ns.virtualhost.dk ([195.184.98.160]:33284 "EHLO virtualhost.dk")
	by vger.kernel.org with ESMTP id S1161014AbWGIRzV (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 9 Jul 2006 13:55:21 -0400
Date: Sun, 9 Jul 2006 19:57:44 +0200
From: Jens Axboe <axboe@suse.de>
To: "Luiz Fernando N. Capitulino" <lcapitulino@mandriva.com.br>
Cc: Andrew Morton <akpm@osdl.org>, Michael Kerrisk <mtk-manpages@gmx.net>,
       linux-kernel@vger.kernel.org, michael.kerrisk@gmx.net,
       vendor-sec@lst.de
Subject: Re: splice/tee bugs?
Message-ID: <20060709175744.GZ4188@suse.de>
References: <20060707070703.165520@gmx.net> <20060707040749.97f8c1fc.akpm@osdl.org> <20060707131310.0e382585@doriath.conectiva> <20060708064131.GG4188@suse.de> <20060708180926.00b1c0f8@home.brethil> <20060709103606.GU4188@suse.de> <20060709111629.GV4188@suse.de> <20060709134703.0aa5bc41@home.brethil>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060709134703.0aa5bc41@home.brethil>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Jul 09 2006, Luiz Fernando N. Capitulino wrote:
> On Sun, 9 Jul 2006 13:16:29 +0200
> Jens Axboe <axboe@suse.de> wrote:
> 
> | On Sun, Jul 09 2006, Jens Axboe wrote:
> | > On Sat, Jul 08 2006, Luiz Fernando N. Capitulino wrote:
> | > > 
> | > >  Hi Jens,
> | > > 
> | > > On Sat, 8 Jul 2006 08:41:32 +0200
> | > > Jens Axboe <axboe@suse.de> wrote:
> | > > 
> | > > | On Fri, Jul 07 2006, Luiz Fernando N. Capitulino wrote:
> | > > | > On Fri, 7 Jul 2006 04:07:49 -0700
> | > > | > Andrew Morton <akpm@osdl.org> wrote:
> | > > | > 
> | > > | > | On Fri, 07 Jul 2006 09:07:03 +0200
> | > > | > | "Michael Kerrisk" <mtk-manpages@gmx.net> wrote:
> | > > | > | 
> | > > | > | > c) Occasionally the command line just hangs, producing no output.
> | > > | > | >    In this case I can't kill it with ^C or ^\.  This is a 
> | > > | > | >    hard-to-reproduce behaviour on my (x86) system, but I have 
> | > > | > | >    seen it several times by now.
> | > > | > | 
> | > > | > | aka local DoS.  Please capture sysrq-T output next time.
> | > > | > 
> | > > | >  If I run lots of them in parallel, I get the following OOPs in a few
> | > > | > seconds:
> | > > | 
> | > > | With the patch posted? You need the i vs nrbufs fix.
> | > > 
> | > >  Yes, it fixes the problem. I didn't try it before because I thought
> | > > you were going to double check it [1].
> | > 
> | > Yeah the patch needs reworking, however the isolated i vs nrbufs fix is
> | > safe enough on its own. I'll post a full patch for inclusion, I'm afraid
> | > I wont be able to fully test it enough for submitting it until tomorrow
> | > though.
> | 
> | Something like this, testing would be appreciated! Michael, can you
> | repeat your testing as well? Thanks.
> 
>  Yeah, it fixes the problem for 2.6.18-rc1.
> 
>  But doesn't compile for 2.6.17.4:
> 
>   CC      fs/splice.o
> fs/splice.c: In function `link_pipe':
> fs/splice.c:1378: warning: implicit declaration of function `mutex_lock_nested'
> fs/splice.c:1378: error: `I_MUTEX_PARENT' undeclared (first use in this function)
> fs/splice.c:1378: error: (Each undeclared identifier is reported only once
> fs/splice.c:1378: error: for each function it appears in.)
> fs/splice.c:1379: error: `I_MUTEX_CHILD' undeclared (first use in this function)
> make[1]: ** [fs/splice.o] Erro 1
> make: ** [fs] Erro 2
> 
>  Should we use the first patch for it? It does work too.

No, I'll rebase the patch for 2.6.17.x - basically you just need to
change the two mutex_lock_nested() to mutex_lock() and that is it. But
first I'd like Michael to retest as well (and more importantly, I'll do
some testing myself too).

-- 
Jens Axboe

