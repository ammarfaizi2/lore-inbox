Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262841AbUCRSLR (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 18 Mar 2004 13:11:17 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262839AbUCRSLR
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 18 Mar 2004 13:11:17 -0500
Received: from smtp02.uc3m.es ([163.117.136.122]:31190 "EHLO smtp02.uc3m.es")
	by vger.kernel.org with ESMTP id S262838AbUCRSLE (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 18 Mar 2004 13:11:04 -0500
From: "Peter T. Breuer" <ptb@it.uc3m.es>
Message-Id: <200403181811.i2IIB1f18197@oboe.it.uc3m.es>
Subject: Re: floppy driver 2.6.3 question
In-Reply-To: <20040318161647.GT22234@suse.de> from Jens Axboe at "Mar 18, 2004
 05:16:48 pm"
To: Jens Axboe <axboe@suse.de>
Date: Thu, 18 Mar 2004 19:11:01 +0100 (MET)
Cc: linux kernel <linux-kernel@vger.kernel.org>
X-Anonymously-To: 
Reply-To: ptb@it.uc3m.es
X-Mailer: ELM [version 2.4ME+ PL66 (25)]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

"Also sprach Jens Axboe:"
> > I mean that I thought that if ->flags & REQ_SPECIAL were set, then
> > we were obliged to flush the driver request queue before treating 
> > this request, and I also thought that the driver was liable to receive
> > such things from somewhere else.
> 
> I dunno where you get those crazy ideas, REQ_SPECIAL has absolutely
> nothing to do with that.

Sorry about that. Perhaps I saw it in 2.5.


> You may use REQ_SPECIAL bit as you see fit, and ->special as well. You
> don't have to use them together, must do though. However, as I said
> earlier, if you push these requests on to someone else request queue,
> you must not fiddle with REQ_SPECIAL and/or ->special. In that case you
> cannot touch/use more than what the block layer already does.

Well hooray. All seems to be working fine now that I shifted the burden
to ->special and stopped playing with ->flags (touch wood). Even
revalidation is working AOK as far as I can tell. I'll reenable that
read of the first block a-la-floppy to see if it causes some extra magic.

Many thanks!


> > Are you going to say, set REQ_SPECIAL on everything and add all the
> > real request info and a bit more to ->special? I suspect you are!
> 
> That's where to put it, indeed. But if you pass it on...


Peter
