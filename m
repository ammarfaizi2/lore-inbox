Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264476AbUBOKJ4 (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 15 Feb 2004 05:09:56 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264484AbUBOKJ4
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 15 Feb 2004 05:09:56 -0500
Received: from mail.shareable.org ([81.29.64.88]:44675 "EHLO
	mail.shareable.org") by vger.kernel.org with ESMTP id S264476AbUBOKJz
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 15 Feb 2004 05:09:55 -0500
Date: Sun, 15 Feb 2004 10:09:27 +0000
From: Jamie Lokier <jamie@shareable.org>
To: Dmitry Torokhov <dtor_core@ameritech.net>
Cc: linux-kernel@vger.kernel.org, Michael Frank <mhf@linuxmail.org>
Subject: Re: PATCH, RFC: Version 3 of 2.6 Codingstyle
Message-ID: <20040215100927.GA10781@mail.shareable.org>
References: <200402130615.10608.mhf@linuxmail.org> <200402140944.34060.mhf@linuxmail.org> <200402132244.04843.dtor_core@ameritech.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200402132244.04843.dtor_core@ameritech.net>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Dmitry Torokhov wrote:
> On Friday 13 February 2004 08:44 pm, Michael Frank wrote:
> > -expression in parenthesis. Note that this does not eliminate all side effects.
> > +4) forgetting about side effects: macros defining expressions must enclose each
> > +parameter and the expression in parentheses.
> >  
> >  #define CONSTEXP (CONSTANT | 3)
> >  #define MACWEXP(a,b) ((a) + (b))
> >
> 
> The statements above are incorrect.
> 
> Parentheses will never eliminate a side effect, macros do not have a
> "side effect problem". Functions and macros both can have side effects
> and sometimes side effect is a desired outcome.

Macros do have a side effect problem, but it is not something which is
fixed by parentheses.  The problem comes when the argument of the
macro is repeated more than once, or zero times, in the macro body.
Then any side effect that the caller was expecting takes place the
wrong number of times.

A subtler version occurs when the caller expects the side effect in an
argument to occur before the action of the macro, but the macro
doesn't expand the argument in that order.

See "Duplication of Side Effects" in the GNU CPP manual.

-- Jamie
