Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261466AbVGCQvh@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261466AbVGCQvh (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 3 Jul 2005 12:51:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261473AbVGCQvh
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 3 Jul 2005 12:51:37 -0400
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:38333 "EHLO
	parcelfarce.linux.theplanet.co.uk") by vger.kernel.org with ESMTP
	id S261466AbVGCQvQ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 3 Jul 2005 12:51:16 -0400
Date: Sun, 3 Jul 2005 08:56:59 -0300
From: Marcelo Tosatti <marcelo.tosatti@cyclades.com>
To: George Anzinger <george@mvista.com>
Cc: Olivier Croquette <ocroquette@free.fr>, Andrew Morton <akpm@osdl.org>,
       torvalds@osdl.org, linux-kernel@vger.kernel.org
Subject: Re: setitimer expire too early (Kernel 2.4)
Message-ID: <20050703115659.GA20204@logos.cnet>
References: <42C444AA.2070508@free.fr> <20050630165053.GA8220@logos.cnet> <20050630160537.7d05d467.akpm@osdl.org> <42C582CC.5050907@free.fr> <20050701144901.GC11975@logos.cnet> <42C5B242.5010002@mvista.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <42C5B242.5010002@mvista.com>
User-Agent: Mutt/1.5.5.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jul 01, 2005 at 02:14:42PM -0700, George Anzinger wrote:
> Marcelo Tosatti wrote:
> >Hi Olivier,
> >
> >On Fri, Jul 01, 2005 at 07:52:12PM +0200, Olivier Croquette wrote:
> >
> >>Andrew Morton wrote:
> >>
> >>>>Linus, Andrew, do you consider this critical enough to be merged to 
> >>>>the v2.4 tree?
> >>>
> >>>
> >>>No.  I'd expect this would hurt more people than it would benefit.
> >>
> >>
> >>Probably.
> >>Does that mean that the kernel 2.4 will keep this bug for ever?
> >
> >
> >Probably, yes. I've never heard such complaints before your message.
> >
> >The right way to do it seems something else BTW:
> >
> >quoting Nish Aravamudan (http://lkml.org/lkml/2005/4/29/240):
> >
> >Your patch is the only way to guarantee no early timeouts, as far as I 
> >know.
> >
> >Really, what you want is:
> >
> >on adding timers, take the ceiling of the interval into which it could be 
> >added
> >on expiring timers, take the floor
> >
> >This combination guarantees no timers go off early (and takes away
> >many of these corner cases). I do exactly this in my patch, btw.
> 
> IMNSHO that is just another way of saying "add 1 to the jiffie count" which 
> is what the proposed patch does.

Hi George, 

OK - I'll write a test case to confirm there are no such longer delay 
regressions as Paulo suggests.  

Thanks for your advice.

