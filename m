Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267546AbTALWEI>; Sun, 12 Jan 2003 17:04:08 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267547AbTALWEI>; Sun, 12 Jan 2003 17:04:08 -0500
Received: from mailout09.sul.t-online.com ([194.25.134.84]:14809 "EHLO
	mailout09.sul.t-online.com") by vger.kernel.org with ESMTP
	id <S267546AbTALWEH> convert rfc822-to-8bit; Sun, 12 Jan 2003 17:04:07 -0500
Content-Type: text/plain; charset=US-ASCII
From: Oliver Neukum <oliver@neukum.name>
To: robw@optonline.net, Rik van Riel <riel@conectiva.com.br>
Subject: Re: any chance of 2.6.0-test*?
Date: Sun, 12 Jan 2003 23:12:41 +0100
User-Agent: KMail/1.4.3
Cc: Matti Aarnio <matti.aarnio@zmailer.org>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
References: <Pine.LNX.4.44.0301121100380.14031-100000@home.transmeta.com> <Pine.LNX.4.50L.0301121939170.26759-100000@imladris.surriel.com> <1042407845.3162.131.camel@RobsPC.RobertWilkens.com>
In-Reply-To: <1042407845.3162.131.camel@RobsPC.RobertWilkens.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Message-Id: <200301122312.41879.oliver@neukum.name>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Am Sonntag, 12. Januar 2003 22:44 schrieb Rob Wilkens:
> On Sun, 2003-01-12 at 16:40, Rik van Riel wrote:
> > OK, now imagine the dcache locking changing a little bit.
> > You need to update this piece of (duplicated) code in half
> > a dozen places in just this function and no doubt in dozens
> > of other places all over fs/*.c.
> >
> > >From a maintenance point of view, a goto to a single block
> >
> > of error handling code is easier to maintain.
>
> There's no reason, though, that the error handling/cleanup code can't be
> in an entirely separate function, and if speed is needed, there's no
> reason it can't be an "inline" function.  Or am I oversimplifying things
> again?

Yes. Typical error cleanup looks like:
err_out:
	up(&sem);
	return err;

Releasing a lock in another function is a crime punished by slow death.
(Some might even resort to voodoo to make sure your shadow suffers
in the beyond.)
It makes code absolutely unreadable.

	Regards
		Oliver

