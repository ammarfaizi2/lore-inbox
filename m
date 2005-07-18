Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261400AbVGRNpL@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261400AbVGRNpL (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 18 Jul 2005 09:45:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261674AbVGRNpK
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 18 Jul 2005 09:45:10 -0400
Received: from ms-smtp-04.nyroc.rr.com ([24.24.2.58]:57852 "EHLO
	ms-smtp-04.nyroc.rr.com") by vger.kernel.org with ESMTP
	id S261400AbVGRNpI (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 18 Jul 2005 09:45:08 -0400
Subject: Re: Merging relayfs?
From: Steven Rostedt <rostedt@goodmis.org>
To: Tom Zanussi <zanussi@us.ibm.com>
Cc: richardj_moore@uk.ibm.com, varap@us.ibm.com, karim@opersys.com,
       linux-kernel@vger.kernel.org, Christoph Hellwig <hch@infradead.org>,
       Andrew Morton <akpm@osdl.org>, Roman Zippel <zippel@linux-m68k.org>
In-Reply-To: <17114.32450.420164.971783@tut.ibm.com>
References: <17107.6290.734560.231978@tut.ibm.com>
	 <20050712022537.GA26128@infradead.org>
	 <20050711193409.043ecb14.akpm@osdl.org>
	 <Pine.LNX.4.61.0507131809120.3743@scrub.home>
	 <17110.32325.532858.79690@tut.ibm.com>
	 <Pine.LNX.4.61.0507171551390.3728@scrub.home>
	 <17114.32450.420164.971783@tut.ibm.com>
Content-Type: text/plain
Organization: Kihon Technologies
Date: Mon, 18 Jul 2005 09:44:35 -0400
Message-Id: <1121694275.12862.23.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.3 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 2005-07-17 at 10:52 -0500, Tom Zanussi wrote:

>  > 
>  > >  > - overwrite mode can be implemented via the buffer switch callback
>  > > 
>  > > The buffer switch callback is already where this is handled, unless
>  > > you're thinking of something else - one of the first checks in the
>  > > buffer switch is relay_buf_full(), which always returns 0 if the
>  > > buffer is in overwrite mode.
>  > 
>  > I mean, relayfs doesn't has to know about this, the client itself can do 
>  > it (e.g. via helper functions).
> 
> In a previous version, we did something like having the client pass
> back a return value from the callback indicating whether or not to
> continue or stop.  I can try doing something like that instead again.

Tom,

I'm actually very much against this. Looking at a point of view from the
logdev device. Having a callback to know to continue at every buffer
switch would just be slowing down something that is expected to be very
fast. I don't see the problem with having an overwrite mode or not. Why
can't relayfs know this? It _is_ an operation of relayfs, and having it
pushed to the client would seem to make the client need to know more
about how relayfs works that it needs to.  Because, the logdev device
doesn't care about buffer switches.

-- Steve


