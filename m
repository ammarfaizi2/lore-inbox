Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264338AbTH2Cas (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 28 Aug 2003 22:30:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264362AbTH2Cas
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 28 Aug 2003 22:30:48 -0400
Received: from almesberger.net ([63.105.73.239]:57098 "EHLO
	host.almesberger.net") by vger.kernel.org with ESMTP
	id S264338AbTH2Car (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 28 Aug 2003 22:30:47 -0400
Date: Thu, 28 Aug 2003 23:30:24 -0300
From: Werner Almesberger <wa@almesberger.net>
To: kuznet@ms2.inr.ac.ru
Cc: quade@hsnr.de, nagendra_tomar@adaptec.com, linux-kernel@vger.kernel.org
Subject: Re: tasklet_kill will always hang for recursive tasklets on a UP
Message-ID: <20030828233024.G1212@almesberger.net>
References: <20030826145636.E1212@almesberger.net> <200308270147.FAA07024@dub.inr.ac.ru>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200308270147.FAA07024@dub.inr.ac.ru>; from kuznet@ms2.inr.ac.ru on Wed, Aug 27, 2003 at 05:47:18AM +0400
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

kuznet@ms2.inr.ac.ru wrote:
> It still holds. tasklet_kill just waits for completion of scheduled
> events. Well, it _assumes_ that cpu which calls tasklet_schedule
> does not try to wake the tasklet after death.

Well, the tasklet isn't dead yet - it's still running.

> But it is from area of pure scholastics already: waker and killer
> have to synchronize in some way anyway. 

Yes, all I'm saying is that one can't rely on tasklet_kill to
make a self-rescheduling tasklet go away, which, given the name,
would seem a reasonably assumption.

Also, in this case, tasklet_schedule behaves differently on SMP.
So I'd suggest to resolve all this by clarifying that
tasklet_schedule must not be called while tasklet_kill is
executing.

- Werner

-- 
  _________________________________________________________________________
 / Werner Almesberger, Buenos Aires, Argentina         wa@almesberger.net /
/_http://www.almesberger.net/____________________________________________/
