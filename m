Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262608AbUCRNZL (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 18 Mar 2004 08:25:11 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262609AbUCRNZK
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 18 Mar 2004 08:25:10 -0500
Received: from smtp03.uc3m.es ([163.117.136.123]:11209 "EHLO smtp03.uc3m.es")
	by vger.kernel.org with ESMTP id S262608AbUCRNZG (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 18 Mar 2004 08:25:06 -0500
From: "Peter T. Breuer" <ptb@it.uc3m.es>
Message-Id: <200403181325.i2IDP4N19962@oboe.it.uc3m.es>
Subject: Re: floppy driver 2.6.3 question
In-Reply-To: <20040318122831.GO22234@suse.de> from Jens Axboe at "Mar 18, 2004
 01:28:31 pm"
To: Jens Axboe <axboe@suse.de>
Date: Thu, 18 Mar 2004 14:25:04 +0100 (MET)
Cc: linux kernel <linux-kernel@vger.kernel.org>
X-Anonymously-To: 
Reply-To: ptb@it.uc3m.es
X-Mailer: ELM [version 2.4ME+ PL66 (25)]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

"Also sprach Jens Axboe:"
> > Good idea. rl is inviolate, but I set at least |=REQ_NOMERGE sometimes
> > on flags. And I pass ioctl information in fake requests by setting
> 
> May I ask on what commands you set that bit?

I set it on requests I have gotten myself via blk_get_request(..., WRITE,
GFP_ATOMIC) and which are destined to be passed onto the drivers request
queue and treated by the request function. The request function will
know what to do with them. The bit I mention below is also set on them:

> > the bit just beyond the edge of those currently used (__REQ_BITS) to
> > indicate its an ioctl and treating it specially in end request. Maybe
> > on error I forgot to remove the extra bit before doing put_blk_request
> 
> Ugh, that sounds like very bad practice... The 'standard' way of doing
> something like that is to flag REQ_SPECIAL and put whatever structure
> you want in ->special.

Hmm .. I though SPECIAL was "just" to ensure ordering of requests and
I went to some lengths to ensure that if I receive a request then we
start diverting incoming requests to an alternate queue until we have
treated all the requests already on the device queue! Then we ack the
special and pass the requests back from the alternate queue. You are
telling me that I needn't have bothered since I'm the only one who
could generate a special? Owww.

Peter
