Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S264746AbSJVPDl>; Tue, 22 Oct 2002 11:03:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S264726AbSJVPDk>; Tue, 22 Oct 2002 11:03:40 -0400
Received: from serenity.mcc.ac.uk ([130.88.200.93]:38925 "EHLO
	serenity.mcc.ac.uk") by vger.kernel.org with ESMTP
	id <S264746AbSJVPDg>; Tue, 22 Oct 2002 11:03:36 -0400
Date: Tue, 22 Oct 2002 16:09:44 +0100
From: John Levon <levon@movementarian.org>
To: Corey Minyard <cminyard@mvista.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [PATCH] NMI request/release
Message-ID: <20021022150944.GC70310@compsoc.man.ac.uk>
References: <3DB4AABF.9020400@mvista.com> <20021022021005.GA39792@compsoc.man.ac.uk> <3DB4B8A7.5060807@mvista.com> <20021022025346.GC41678@compsoc.man.ac.uk> <3DB54C53.9010603@mvista.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3DB54C53.9010603@mvista.com>
User-Agent: Mutt/1.3.25i
X-Url: http://www.movementarian.org/
X-Record: Mr. Scruff - Trouser Jazz
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Oct 22, 2002 at 08:02:11AM -0500, Corey Minyard wrote:

> Ok.  I'd be inclined to leave the high-usage things where they are, 
> although it would be nice to be able to make the NMI watchdog a module. 
> oprofile should probably stay where it is.  Do you have an alternate 
> implementation that would be more efficient?

I'm beginning to think you're right. You should ask Keith Owens if kdb
etc. can use your API successfully.

> >>dev_name could be removed, although it would be nice for reporting 
> >>
> >Reporting what ? from where ?
> >
> Registered NMI users in procfs.

Then if you add such code, you can add dev_name ... I hate code that
does nothing ...

> Yes.  But I don't understand why they would be used in the notifier code.

I'm trying to reduce code duplication - you do basically the same thing
notifier register/unregister does.

btw, the stuff you add to header files should all be in asm-i386/nmi.h
IMHO.

It would make it clear that there's a fast-path "set nmi handler" and
the slow one, and you can document the difference there, if that's what
we're going to do.

regards
john

-- 
"Lots of companies would love to be in our hole."
	- Scott McNealy
