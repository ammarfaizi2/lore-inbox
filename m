Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750820AbWH3MTJ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750820AbWH3MTJ (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 30 Aug 2006 08:19:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750824AbWH3MTJ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 30 Aug 2006 08:19:09 -0400
Received: from 1wt.eu ([62.212.114.60]:40209 "EHLO 1wt.eu")
	by vger.kernel.org with ESMTP id S1750820AbWH3MTI (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 30 Aug 2006 08:19:08 -0400
Date: Wed, 30 Aug 2006 14:18:45 +0200
From: Willy Tarreau <w@1wt.eu>
To: Andi Kleen <ak@suse.de>
Cc: Riley@Williams.Name, davej@redhat.com, pageexec@freemail.hu,
       linux-kernel@vger.kernel.org
Subject: Re: [PATCH][RFC] exception processing in early boot
Message-ID: <20060830121845.GA351@1wt.eu>
References: <20060830063932.GB289@1wt.eu> <p73y7t65z6c.fsf@verdi.suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <p73y7t65z6c.fsf@verdi.suse.de>
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Aug 30, 2006 at 11:51:39AM +0200, Andi Kleen wrote:
> Willy Tarreau <w@1wt.eu> writes:
> 
> > Hi,
> > 
> > PaX Team has sent me this patch for inclusion. Basically, during early
> > boot on x86, the exception handler does not make a special case for
> > exceptions which push an error code onto the stack, leading to a return
> > to a wrong address. Two patches were proposed, one which would add a
> > special case for all exceptions using the return code, and this one. The
> > former was of no use in its form because the return from the exception
> > handler would get back to the faulting exception, causing it to loop.
> > 
> > This one should be better as it effectively hangs the system using HLT
> > to prevent CPU from burning.
> 
> Looks good.
> 
> [I'm glad this particular ward in x86 was fixed in x86-64 ...]

good.

> > If nobody has any objections, I will merge it. In this case, I would also
> > like someone to check if 2.6 needs it and to port it in this case.
> 
> I don't think you should merge anything like this before 2.6 does. Otherwise
> we just end up with the mad situation again that an old release has 
> more bugs fixed or more features than the new release.

Unfortunately, this situation is even more difficult for me, because it's
getting very hard to track patches that get applied, rejected, modified or
obsoleted, which is even more true when people don't always think about
sending an ACK after the patch finally gets in. I already have a few pending
patches in my queue waiting for an ACK that will have to be tracked if the
persons do not respond, say, within one week. Otherwise I might simply lose
them.

I think that the good method would be to :
  - announce the patch
  - find a volunteer to port it
  - apply it once the volunteer agrees to handle it

This way, no code gets lost because there's always someone to track it.

> -Andi

Regards,
Willy

