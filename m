Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263273AbUDOUaY (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 15 Apr 2004 16:30:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262175AbUDOU22
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 15 Apr 2004 16:28:28 -0400
Received: from mail.cyclades.com ([64.186.161.6]:45967 "EHLO
	intra.cyclades.com") by vger.kernel.org with ESMTP id S262213AbUDOU1k
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 15 Apr 2004 16:27:40 -0400
Date: Thu, 15 Apr 2004 16:54:30 -0300
From: Marcelo Tosatti <marcelo.tosatti@cyclades.com>
To: Andrew Morton <akpm@osdl.org>
Cc: Manfred Spraul <manfred@colorfullife.com>, linux-kernel@vger.kernel.org,
       drepper@redhat.com
Subject: Re: message queue limits
Message-ID: <20040415195430.GB3568@logos.cnet>
References: <407A2DAC.3080802@redhat.com> <20040415145350.GF2085@logos.cnet> <20040415122411.0bcb9195.akpm@osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040415122411.0bcb9195.akpm@osdl.org>
User-Agent: Mutt/1.5.5.1i
X-Cyclades-MailScanner-Information: Please contact the ISP for more information
X-Cyclades-MailScanner: Found to be clean
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Apr 15, 2004 at 12:24:11PM -0700, Andrew Morton wrote:
> Marcelo Tosatti <marcelo.tosatti@cyclades.com> wrote:
> >
> > On Sun, Apr 11, 2004 at 10:48:28PM -0700, Ulrich Drepper wrote:
> >  > Something has to change in the way message queues are created.
> >  > Currently it is possible for an unprivileged user to exhaust all mq
> >  > slots so that only root can create a few more.  Any other unprivileged
> >  > user has no change to create anything.
> >  > 
> >  > I think it is necessary to create a per-user limit instead of a
> >  > system-wide limit.
> > 
> >  Actually, there is no infrastructure to account for per-UID limits right now AFAICS 
> >  (please someone correct me) at ALL. We need to account and limit for per-user
> > 
> >  - pending signals
> >  - message queues
> 
> The stuff in kernel/user.c may be sufficient for this.

Oh, sweat! I'll try adding a "atomic_t signal_pending" to "user_struct" 
to be checked at send_signal(), and then go for message queue limiting.

Something which sucks is to add a atomic read/inc at each send signal operation.

Can we avoid the locking in some way?
