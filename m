Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267473AbTAVNLe>; Wed, 22 Jan 2003 08:11:34 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267479AbTAVNLe>; Wed, 22 Jan 2003 08:11:34 -0500
Received: from bjl1.asuk.net.64.29.81.in-addr.arpa ([81.29.64.88]:34518 "EHLO
	bjl1.asuk.net") by vger.kernel.org with ESMTP id <S267473AbTAVNLd>;
	Wed, 22 Jan 2003 08:11:33 -0500
Date: Wed, 22 Jan 2003 13:20:40 +0000
From: Jamie Lokier <jamie@shareable.org>
To: Ed Tomlinson <tomlins@cam.org>
Cc: linux-kernel@vger.kernel.org
Subject: Re: {sys_,/dev/}epoll waiting timeout
Message-ID: <20030122132040.GA4752@bjl1.asuk.net>
References: <20030122065502.GA23790@math.leidenuniv.nl> <20030122080322.GB3466@bjl1.asuk.net> <20030122124625.8CBFD2661@oscar.casa.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20030122124625.8CBFD2661@oscar.casa.dyndns.org>
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Ed Tomlinson wrote:
> Jamie Lokier wrote:
> 
> >         jtimeout = 0;
> >         if (timeout) {
> >                 /* Careful about overflow in the intermediate values */
> >                 if ((unsigned long) timeout < MAX_SCHEDULE_TIMEOUT / HZ)
> >                         jtimeout = (unsigned long)(timeout*HZ+999)/1000+1;
> >                 else /* Negative or overflow */
> >                         jtimeout = MAX_SCHEDULE_TIMEOUT;
> >         }
> 
> Why assume HZ=1000?  Would not:
> 
> timeout = (unsigned long)(timeout*HZ+(HZ-1))/HZ+1;
> 
> make more sense?

No, that's silly.  Why do you want to multiply by HZ and then divide by HZ?

-- Jamie
