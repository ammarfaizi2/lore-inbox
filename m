Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267548AbTALWAb>; Sun, 12 Jan 2003 17:00:31 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267550AbTALWAa>; Sun, 12 Jan 2003 17:00:30 -0500
Received: from mta6.srv.hcvlny.cv.net ([167.206.5.17]:50809 "EHLO
	mta6.srv.hcvlny.cv.net") by vger.kernel.org with ESMTP
	id <S267548AbTALWA3>; Sun, 12 Jan 2003 17:00:29 -0500
Date: Sun, 12 Jan 2003 17:07:19 -0500
From: Rob Wilkens <robw@optonline.net>
Subject: Re: any chance of 2.6.0-test*?
In-reply-to: <20030112214937.GM31238@vitelus.com>
To: Aaron Lehmann <aaronl@vitelus.com>
Cc: Rik van Riel <riel@conectiva.com.br>,
       Matti Aarnio <matti.aarnio@zmailer.org>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Reply-to: robw@optonline.net
Message-id: <1042409239.3162.136.camel@RobsPC.RobertWilkens.com>
Organization: Robert Wilkens
MIME-version: 1.0
X-Mailer: Ximian Evolution 1.2.1
Content-type: text/plain
Content-transfer-encoding: 7BIT
References: <Pine.LNX.4.44.0301121100380.14031-100000@home.transmeta.com>
 <1042400094.1208.26.camel@RobsPC.RobertWilkens.com>
 <20030112211530.GP27709@mea-ext.zmailer.org>
 <1042406849.3162.121.camel@RobsPC.RobertWilkens.com>
 <Pine.LNX.4.50L.0301121939170.26759-100000@imladris.surriel.com>
 <1042407845.3162.131.camel@RobsPC.RobertWilkens.com>
 <20030112214937.GM31238@vitelus.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

In the case of an inline function, you're saving a jump, because the
code that you would "goto" is right there in sequence with the code you
are executing as far as the processor is concerned.  In essence, you're
duplicating code, but you're not retyping code, and your keeping code
consistent accross all uses of it (keeping it modular).

It's trivial, but where you're trying to cut down on the total number of
instructions executed in kernel mode, you would think even where you
could save one instructon (and branches are expensive, no?) you would
want to.

-Rob

On Sun, 2003-01-12 at 16:49, Aaron Lehmann wrote:
> On Sun, Jan 12, 2003 at 04:44:05PM -0500, Rob Wilkens wrote:
> > There's no reason, though, that the error handling/cleanup code can't be
> > in an entirely separate function, and if speed is needed, there's no
> > reason it can't be an "inline" function.  Or am I oversimplifying things
> > again?
> 
> Remind me why this is better than a goto?

