Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751178AbWEJPYo@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751178AbWEJPYo (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 10 May 2006 11:24:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751465AbWEJPYn
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 10 May 2006 11:24:43 -0400
Received: from ms-smtp-01.nyroc.rr.com ([24.24.2.55]:37111 "EHLO
	ms-smtp-01.nyroc.rr.com") by vger.kernel.org with ESMTP
	id S1751178AbWEJPYn (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 10 May 2006 11:24:43 -0400
Date: Wed, 10 May 2006 11:24:31 -0400 (EDT)
From: Steven Rostedt <rostedt@goodmis.org>
X-X-Sender: rostedt@gandalf.stny.rr.com
To: Daniel Walker <dwalker@mvista.com>
cc: Alan Cox <alan@lxorguk.ukuu.org.uk>, akpm@osdl.org,
       linux-kernel@vger.kernel.org
Subject: Re: [PATCH -mm] sys_semctl gcc 4.1 warning fix
In-Reply-To: <1147273598.21536.92.camel@c-67-180-134-207.hsd1.ca.comcast.net>
Message-ID: <Pine.LNX.4.58.0605101116590.5532@gandalf.stny.rr.com>
References: <200605100256.k4A2u8bd031779@dwalker1.mvista.com> 
 <1147257266.17886.3.camel@localhost.localdomain> 
 <1147271489.21536.70.camel@c-67-180-134-207.hsd1.ca.comcast.net> 
 <1147273787.17886.46.camel@localhost.localdomain>
 <1147273598.21536.92.camel@c-67-180-134-207.hsd1.ca.comcast.net>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Wed, 10 May 2006, Daniel Walker wrote:

> On Wed, 2006-05-10 at 16:09 +0100, Alan Cox wrote:
> > On Mer, 2006-05-10 at 07:31 -0700, Daniel Walker wrote:
> > > > Hiding warnings like this can be a hazard as it will hide real warnings
> > > > later on.
> > >
> > > How could it hide real warnings? If anything these patch allow other
> > > (real warnings) to be seen .
> >
> > Because while the warning is present people will check it now and again.
>
> But it's pointless to review it, in this case and for this warning .
>
> > If you set the variable to zero then you generate extra code and you
> > ensure nobody will look in future.
>
> The extra code is a problem , I'll admit that . But the warning should
> disappear , it's just a waste .
>

What is really needed is an attribute to add to function parameters, that
tells gcc that the parameter, if a pointer, will be initialize via the
function.

For example:

#define __assigned  __attribute__((initialized))

then declare a function:

int my_init_variabl(__assigned struct mystruct *var);

So gcc can know that the passed in variable will be updated. It could
then check to see if the function actually does initialize the pointer,
if the declaration is visible to the function definition itself.

Any gcc developers watching :)

-- Steve

