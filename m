Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S271071AbTHGXC6 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 7 Aug 2003 19:02:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S271080AbTHGXC6
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 7 Aug 2003 19:02:58 -0400
Received: from vladimir.pegasys.ws ([64.220.160.58]:37904 "EHLO
	vladimir.pegasys.ws") by vger.kernel.org with ESMTP id S271071AbTHGXC5
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 7 Aug 2003 19:02:57 -0400
Date: Thu, 7 Aug 2003 16:02:52 -0700
From: jw schultz <jw@pegasys.ws>
To: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH][TRIVIAL] Bugzilla bug # 322 - double logical operator drivers/char/sx.c
Message-ID: <20030807230252.GJ1380@pegasys.ws>
Mail-Followup-To: jw schultz <jw@pegasys.ws>,
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
References: <200308061830.05586.jeffpc@optonline.net> <3F319EE7.8010409@techsource.com> <200308070420.45464.jeffpc@optonline.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200308070420.45464.jeffpc@optonline.net>
User-Agent: Mutt/1.3.27i
X-Message-Flag: This message may contain content offensive to Atheists and servants of false gods.  Read at your own risk.
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Aug 07, 2003 at 04:20:37AM -0400, Jeff Sipek wrote:
> -----BEGIN PGP SIGNED MESSAGE-----
> Hash: SHA1
> 
> On Wednesday 06 August 2003 20:35, Timothy Miller wrote:
> > Josef 'Jeff' Sipek wrote:
> > > Just a simple fix to make the statements more readable. (instead of
> > > "i < TIMEOUT > 0" the statement is divided into two, joined by &&.)
> >
> > Can you really DO (x < y > z) and have it work as an anded pair of
> > comparisons?  Maybe this is an addition to C that I am not aware of.
> >
> > I would expect (x < y > z) to be equivalent to ((x < y) > z).
> 
> Odd, this has been in the kernel ever since Linus started using BK. I didn't 
> check pre-BK. I wonder what the author intended to say. (I believe in the 
> ((a<b) && (b>c)) theory.)

I've got an old system with 2.2.10 and took a look.  It
appears as though the form of the loop in may of 1999 was

	for(delay = SX_CCR_TIMEOUT; delay; delay--)

so my guess is that the changes were made around the
constant to minimise typing and progressed something like so:

	for(delay = SX_CCR_TIMEOUT; delay; delay--)
	for(delay = SX_CCR_TIMEOUT; delay > 0; delay--)
	for(delay = 0; delay < SX_CCR_TIMEOUT > 0; delay++)

with name changes somewhere in the mix.  So there was never
any intent to have a double test.  Besides comparing a
constant with another constant wouldn't make much sense.


-- 
________________________________________________________________
	J.W. Schultz            Pegasystems Technologies
	email address:		jw@pegasys.ws

		Remember Cernan and Schmitt
