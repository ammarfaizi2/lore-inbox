Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264300AbTH2CW5 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 28 Aug 2003 22:22:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264331AbTH2CW5
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 28 Aug 2003 22:22:57 -0400
Received: from almesberger.net ([63.105.73.239]:54282 "EHLO
	host.almesberger.net") by vger.kernel.org with ESMTP
	id S264300AbTH2CWz (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 28 Aug 2003 22:22:55 -0400
Date: Thu, 28 Aug 2003 23:22:41 -0300
From: Werner Almesberger <wa@almesberger.net>
To: Juergen Quade <quade@hsnr.de>
Cc: kuznet@ms2.inr.ac.ru, nagendra_tomar@adaptec.com,
       linux-kernel@vger.kernel.org
Subject: Re: tasklet_kill will always hang for recursive tasklets on a UP
Message-ID: <20030828232240.F1212@almesberger.net>
References: <20030828152934.GA7924@hsnr.de> <200308281553.TAA22047@dub.inr.ac.ru> <20030828161722.GA4384@hsnr.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20030828161722.GA4384@hsnr.de>; from quade@hsnr.de on Thu, Aug 28, 2003 at 06:17:22PM +0200
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Juergen Quade wrote:
> useful, I still believe, it is a bug. Does anybody know, who is
> responsible for the function?

If it's not Alexey himself, I'm sure he knows who is :-)

> > > 2. we should find some means to make it usable for recursive tasklets.
> > 
> > I would not say it is easy. When tasklet is enqueued on another cpu you
> > have no way to stop it unless you are in process context, where you can
> > sit and wait for completion.
> 
> For sure, not easy.
> But tasklet_kill will mostly be called in process context, won't it?

Ah, a misunderstanding. You meant "can be used to kill 'recursive'
tasklets" (with "recursive" = re-schedules itself). Apparently,
Alexey understood "can be used from a tasklet".

The latter would basically mean to busy loop for the other tasklet
to be scheduled, run, and complete. Not nice.

- Werner

-- 
  _________________________________________________________________________
 / Werner Almesberger, Buenos Aires, Argentina         wa@almesberger.net /
/_http://www.almesberger.net/____________________________________________/
