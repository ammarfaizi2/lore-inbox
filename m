Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S318284AbSHKKOS>; Sun, 11 Aug 2002 06:14:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S318298AbSHKKOS>; Sun, 11 Aug 2002 06:14:18 -0400
Received: from ns.virtualhost.dk ([195.184.98.160]:36067 "EHLO virtualhost.dk")
	by vger.kernel.org with ESMTP id <S318284AbSHKKNo>;
	Sun, 11 Aug 2002 06:13:44 -0400
Date: Sun, 11 Aug 2002 12:17:09 +0200
From: Jens Axboe <axboe@suse.de>
To: martin@dalecki.de
Cc: Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Linus Torvalds <torvalds@transmeta.com>
Subject: Re: [PATCH] 2.5.30 IDE 115
Message-ID: <20020811101709.GI8755@suse.de>
References: <3D53AE13.7060907@evision.ag> <20020809134839.GO2243@suse.de> <3D54279B.2050500@evision.ag>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3D54279B.2050500@evision.ag>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Aug 09 2002, Marcin Dalecki wrote:
> Jens Axboe wrote:
> >On Fri, Aug 09 2002, Marcin Dalecki wrote:
> >
> >>- Fix small typo introduced in 113, which prevented CD-ROMs from
> >> working altogether.
> >
> >
> >Have you fixed the sense reporting issue I told you about months ago?
> 
> Well at least ide-116 will start to unify the corresponding code.
> But please don't expecty anything "revolutionary" yet... Just for
> example using GPCMD_ constants throughout the code and a unified error
> dissection function. One of the issues involved is rq->buffer in
> ide-floppy versus rq->special in ide-cd.c

Well I consider the sense decoding a somewhat important feature, hence
it's really bad it has been broken for months now. It's impossible to
diagnose problems in ide-cd code without it.

> >>- Eliminate block_ioctl(). This code can't be shared in the way
> >> proposed by this file. We will port it to the proper
> >> blk_insert_request() soon. This will eliminate the _elv_add_request()
> >> "layering violation".
> >
> >
> >What are you talking about?
> 
> Hmm, so apparently you where not the one who "inventid" it?

? I added block_ioct.c, yes.

> Anyway I talk about the block_ioctl.c file, which was supposed
> to contain the two eject ioctl functions for "generic" packet code.

It _did_ contain two eject ioctl as a "here's what it's supposed to do"
proof of concept type thing.

> But since we don't have any kind of "generic" packet commands this
> didn't make much sense.

What are you talking about?!

> It was inventing a function called blk_do_rq(), which was using
> elv_add_request(). You called this not a long time ago a "layering
> violation" yourself. And I simply intend to replace it in one of the
> forthcomming patches  with the recently inventid blk_insert_request() 
> function.

Sigh... Martin, for fscks sake please stop always just assuming and get
your facts straight. This is why you are repeatedly pissing me (and
others) off. blk_do_rq() means "insert request and execute it, return
when it's done". It probably should have been in ll_rw_blk.c itself,
sinoce it's that sort of helper.

Using elv_add_request() is not a layering violation, that's the exported
interface... The layering violation is using __elv_add_request() since
it exposes the internal queue lists, which may not be appropriate for
all io schedulers.

> Oh, I realize I didn't express myself properly. I certinaly don't intend
> to eliminate elv_add_request() itself any time soon ;-).

No, I would appreciate it if you would keep your hands out of the block
code.

-- 
Jens Axboe

