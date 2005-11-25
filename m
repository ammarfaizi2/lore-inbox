Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932698AbVKYPYy@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932698AbVKYPYy (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 25 Nov 2005 10:24:54 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932702AbVKYPYy
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 25 Nov 2005 10:24:54 -0500
Received: from scrub.xs4all.nl ([194.109.195.176]:53661 "EHLO scrub.xs4all.nl")
	by vger.kernel.org with ESMTP id S932698AbVKYPYx (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 25 Nov 2005 10:24:53 -0500
Date: Fri, 25 Nov 2005 16:24:45 +0100 (CET)
From: Roman Zippel <zippel@linux-m68k.org>
X-X-Sender: roman@scrub.home
To: David Woodhouse <dwmw2@infradead.org>
cc: linux-kernel@vger.kernel.org
Subject: Re: RFC: Kill -ERESTART_RESTARTBLOCK.
In-Reply-To: <1132919594.4044.41.camel@baythorne.infradead.org>
Message-ID: <Pine.LNX.4.61.0511251602460.1609@scrub.home>
References: <1132859323.11921.110.camel@baythorne.infradead.org> 
 <Pine.LNX.4.61.0511250110470.1610@scrub.home> <1132919594.4044.41.camel@baythorne.infradead.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Fri, 25 Nov 2005, David Woodhouse wrote:

> > Instead of messing with the signal delivery it may be better to slightly 
> > change the restart logic. Instead of calling a separate function, we could 
> > call the original function with all the arguments, which would reduce the 
> > state required to be saved.
>  < ... >
> > AFAICT only the timeout argument needs to saved over a restart, the rest 
> > can be reinitialized from the original arguments.
> 
> Yeah, that might be nice -- but if the argument registers are
> call-clobbered, then those original arguments don't actually exist
> anywhere any more, except in the syscall function which got interrupted.

The arguments have to be saved somewhere, otherwise ERESTARTNOHAND 
wouldn't work, so my basic idea would be to change ERESTART_RESTARTBLOCK 
into ERESTARTNOHAND + some extra state.

> One simpler option which _might_ work for pselect(), ppoll() and
> sigsuspend() is a TIF_RESTORE_SIGMASK flag which restores the original
> signal mask on the way back to userspace but _after_ calling do_signal()
> with the temporary mask.

Now I see the problem with the signal mask and I agree, this would be a 
simpler and IMO preferable approach.

bye, Roman
