Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262005AbUJYQgN@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262005AbUJYQgN (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 25 Oct 2004 12:36:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262030AbUJYQFO
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 25 Oct 2004 12:05:14 -0400
Received: from alephnull.demon.nl ([212.238.201.82]:15245 "EHLO
	xi.wantstofly.org") by vger.kernel.org with ESMTP id S262005AbUJYQBp
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 25 Oct 2004 12:01:45 -0400
Date: Mon, 25 Oct 2004 18:01:45 +0200
From: Lennert Buytenhek <buytenh@wantstofly.org>
To: Gerd Knorr <kraxel@bytesex.org>
Cc: linux-kernel@vger.kernel.org
Subject: Re: bttv hang problem on 2.6.8
Message-ID: <20041025160145.GA23760@xi.wantstofly.org>
References: <20041025150349.GA22915@xi.wantstofly.org> <20041025151841.GA10042@bytesex>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20041025151841.GA10042@bytesex>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Oct 25, 2004 at 05:18:41PM +0200, Gerd Knorr wrote:

> > When there is a background thread doing VIDIOCSYNC in a loop, issuing
> > VIDIOCSPICT in the current thread on the same file descriptor causes
> > it to go into uninterruptable sleep and hang.  This is on kernel 2.6.8
> > using the bttv driver, and appears easily reproducible.
> 
> Don't do that.  bttv serializes ioctls with a lock.  Well, not all of
> them, but the ones which change the state of the filehandle, and both
> VIDIOCSYNC + VIDIOCSPICT fall into that group.  You simply can't run
> them in parallel on the same filehandle.

OK, even though it worked fine on 2.4 I'll buy that, but it still
shouldn't result in an unkillable process, should it?


cheers,
Lennert
