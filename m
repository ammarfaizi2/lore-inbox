Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965326AbWGJXWR@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965326AbWGJXWR (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 10 Jul 2006 19:22:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965325AbWGJXWR
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 10 Jul 2006 19:22:17 -0400
Received: from nessie.weebeastie.net ([220.233.7.36]:57348 "EHLO
	bunyip.lochness.weebeastie.net") by vger.kernel.org with ESMTP
	id S965319AbWGJXWQ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 10 Jul 2006 19:22:16 -0400
Date: Tue, 11 Jul 2006 09:23:24 +1000
From: CaT <cat@zip.com.au>
To: "linux-os (Dick Johnson)" <linux-os@analogic.com>
Cc: linux-kernel@vger.kernel.org, netdev@vger.kernel.org
Subject: Re: possible dos / wsize affected frozen connection length (was: Re: 2.6.17.1: fails to fully get webpage)
Message-ID: <20060710232324.GR2344@zip.com.au>
References: <20060629015915.GH2149@zip.com.au> <20060628.194627.74748190.davem@davemloft.net> <20060629030923.GI2149@zip.com.au> <20060628.204709.41634813.davem@davemloft.net> <20060629041827.GJ2149@zip.com.au> <44A3E898.1020202@tmr.com> <20060629225039.GO2149@zip.com.au> <20060705005540.GL2344@zip.com.au> <Pine.LNX.4.61.0607050743470.30694@chaos.analogic.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.61.0607050743470.30694@chaos.analogic.com>
Organisation: Furball Inc.
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jul 05, 2006 at 07:54:01AM -0400, linux-os (Dick Johnson) wrote:
> >> running since 8:42pm yesterday. It's 8:37am now. It hasn't progressed
> >> in any way. It hasn't quit. It hasn't timed out. It just sits there,
> >> hung. This leads me to consider the possibility of a DOS, either
> >> intentional or accidental (think about 2.6.17.x running on a mail server
> >> and someone mails/spams from a broken place).
> 
> TCP/IP connections can continue forever. That's one of the reasons why
> Berkeley sockets has SO_KEEPALIVE for a socket option. In the absence
> of such an option, the physical connection can be broken for a week,
> reconnected, then the session can continue.

D'oh. I knew that. Sigh. It's one of the things I like about having a
static ip on a bad connection. :)

> In your case, you probably have a real error in which one end of the
> connection crashed. However, until the other end shuts down that

Well not so much crashed but became unreachable due to the wsize thing.

> socket, the connection is logically correct and should not be
> forcefully terminated.

It'll never terminate right now unless I hit ^c.

> A DOS is unlikely because with no data being transferred, little

Not all DOS' are transfer based. Just anything that uses up resources to
the point where a service is no longer able to be performed.

> non-swapable resources are used. You can control the maximum number
> of connections allowed from a host with your firewall software
> (like iptables).

After the fact really. In this case one can send mail to a box and make
it bounce to someplace behind a wsize broken network. Resources taken up
that wont return until someone spots what's wrong. You could make your
own wsize broken network, connect to someplace a few times and then move
on whilst their end hangs around, waiting for the connections to do
somthing.

In my test case I am wondering if there was/is a web process hanging
about doing nothing other then waiting for my end to do something.

-- 
    "To the extent that we overreact, we proffer the terrorists the
    greatest tribute."
    	- High Court Judge Michael Kirby
