Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264104AbTH1QRd (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 28 Aug 2003 12:17:33 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264108AbTH1QRc
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 28 Aug 2003 12:17:32 -0400
Received: from postman1.arcor-online.net ([151.189.0.187]:64651 "EHLO
	postman.arcor.de") by vger.kernel.org with ESMTP id S264104AbTH1QRa
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 28 Aug 2003 12:17:30 -0400
Date: Thu, 28 Aug 2003 18:17:22 +0200
From: Juergen Quade <quade@hsnr.de>
To: kuznet@ms2.inr.ac.ru
Cc: nagendra_tomar@adaptec.com, linux-kernel@vger.kernel.org,
       wa@almesberger.net
Subject: Re: tasklet_kill will always hang for recursive tasklets on a UP
Message-ID: <20030828161722.GA4384@hsnr.de>
References: <20030828152934.GA7924@hsnr.de> <200308281553.TAA22047@dub.inr.ac.ru>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
In-Reply-To: <200308281553.TAA22047@dub.inr.ac.ru>
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Aug 28, 2003 at 07:53:11PM +0400, kuznet@ms2.inr.ac.ru wrote:
> Hello!
> 
> > Here we have it! In my opintion, the line
> > 
> > 	clear_bit(TASKLET_STATE_SCHED, &t->state);
> > 
> > is just a _BUG_. 
> 
> No, really. The sense of tasklet_kill() is that tasklet is under complete
> control of caller upon exit from it. This clear_bit just makes some (only
> marginally useful) reinitialization for the case the user will want
> to reuse the struct. Essentially, after tasklet_unlock_wait() you can do
> everything with the struct, it is not an alive object anymore.

Because the function as it is written is useless, but with
changing from "clear_bit" to "set_bit" it would be - at least partly -
useful, I still believe, it is a bug. Does anybody know, who is
responsible for the function?

> > 2. we should find some means to make it usable for recursive tasklets.
> 
> I would not say it is easy. When tasklet is enqueued on another cpu you
> have no way to stop it unless you are in process context, where you can
> sit and wait for completion.

For sure, not easy.
But tasklet_kill will mostly be called in process context, won't it?

   Juergen.
