Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751772AbWCHQJd@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751772AbWCHQJd (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 8 Mar 2006 11:09:33 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751834AbWCHQJc
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 8 Mar 2006 11:09:32 -0500
Received: from prgy-npn2.prodigy.com ([207.115.54.38]:20468 "EHLO
	oddball.prodigy.com") by vger.kernel.org with ESMTP
	id S1751772AbWCHQJb (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 8 Mar 2006 11:09:31 -0500
Message-ID: <440DDEE9.8090604@tmr.com>
Date: Tue, 07 Mar 2006 14:28:41 -0500
From: Bill Davidsen <davidsen@tmr.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.8.0.1) Gecko/20060130 SeaMonkey/1.0
MIME-Version: 1.0
To: Linus Torvalds <torvalds@osdl.org>
CC: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Andrew Morton <akpm@osdl.org>, markhe@nextd.demon.co.uk,
       Andrea Arcangeli <andrea@suse.de>, Mike Christie <michaelc@cs.wisc.edu>,
       James Bottomley <James.Bottomley@steeleye.com>,
       Jens Axboe <axboe@suse.de>, Pekka Enberg <penberg@cs.helsinki.fi>
Subject: Re: Slab corruption in 2.6.16-rc5-mm2
References: <200603060117.16484.jesper.juhl@gmail.com>  <Pine.LNX.4.64.0603061122270.13139@g5.osdl.org>  <Pine.LNX.4.64.0603061147260.13139@g5.osdl.org>  <200603062136.17098.jesper.juhl@gmail.com>  <9a8748490603061253u5e4d7561vd4e566f5798a5f4@mail.gmail.com>  <9a8748490603061256h794c5af9wa6fbb616e8ddbd89@mail.gmail.com>  <Pine.LNX.4.64.0603061306300.13139@g5.osdl.org> <9a8748490603061354vaa53c72na161d26065b9302e@mail.gmail.com> <Pine.LNX.4.64.0603061402410.13139@g5.osdl.org> <Pine.LNX.4.64.0603061423160.13139@g5.osdl.org>
In-Reply-To: <Pine.LNX.4.64.0603061423160.13139@g5.osdl.org>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Linus Torvalds wrote:

> has been incorrectly translated for several reasons:
> 
>  - we shouldn't check "cachep->num > offslab_limit". We should check just 
>    "num > offslab_limit" (cachep->num is the _previous_ number we tested).
> 
>  - when we do "break", we've already incremented "gfporder", and we should 
>    correct for that.
> 
> Now, maybe I'm just off my rocker again (I've certainly been batting 0.000 
> so far, even if I think I've been finding real bugs). So who knows. But I 
> get the feeling that that patch is broken.

I thought stumbling over bugs while looking for other things was part of 
the new development model ;-)
> 
> Either revert it, or try this (TOTALLY UNTESTED!!!) patch..
> 
> And hey, maybe I'm just crazy.

Being crazy and being right are not mutually exclusize.
-- 
    -bill davidsen (davidsen@tmr.com)
"The secret to procrastination is to put things off until the
  last possible moment - but no longer"  -me

