Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S268294AbTCFUvo>; Thu, 6 Mar 2003 15:51:44 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S268346AbTCFUvo>; Thu, 6 Mar 2003 15:51:44 -0500
Received: from almesberger.net ([63.105.73.239]:51727 "EHLO
	host.almesberger.net") by vger.kernel.org with ESMTP
	id <S268294AbTCFUvn>; Thu, 6 Mar 2003 15:51:43 -0500
Date: Thu, 6 Mar 2003 18:02:09 -0300
From: Werner Almesberger <wa@almesberger.net>
To: chas williams <chas@locutus.cmf.nrl.navy.mil>
Cc: "David S. Miller" <davem@redhat.com>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH][ATM] make atm (and clip) modular + try_module_get()
Message-ID: <20030306180209.C525@almesberger.net>
References: <20030305125230.B525@almesberger.net> <200303062044.h26Ki7Gi013598@locutus.cmf.nrl.navy.mil>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200303062044.h26Ki7Gi013598@locutus.cmf.nrl.navy.mil>; from chas@locutus.cmf.nrl.navy.mil on Thu, Mar 06, 2003 at 03:44:07PM -0500
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

chas williams wrote:
> while you could make skb_migrate() generic, in this case it doesnt
> really need to be.

Yes, that's a possible simplification.

> requeue the data.  what keeps data from arriving on the vcc while
> you are reprocessing -- this could lead to out of order packet
> arrival.

I don't think that would be much of a problem: ATMARP basically
aggregates information, but does very little in terms of actual
state transitions based on ATMARP/InARP messages. And IP doesn't
mind a bit of reordering anyway. (Reconnecting an SVC in the
middle of a TCP session may of course cause performance
glitches, but that would be more a problem of detaching the VC
in the first place, than anything happening when re-attaching.)

- Werner

-- 
  _________________________________________________________________________
 / Werner Almesberger, Buenos Aires, Argentina         wa@almesberger.net /
/_http://www.almesberger.net/____________________________________________/
