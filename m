Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751926AbWCHAzO@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751926AbWCHAzO (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 7 Mar 2006 19:55:14 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751940AbWCHAzO
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 7 Mar 2006 19:55:14 -0500
Received: from dsl093-040-174.pdx1.dsl.speakeasy.net ([66.93.40.174]:45273
	"EHLO aria.kroah.org") by vger.kernel.org with ESMTP
	id S1751926AbWCHAzN (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 7 Mar 2006 19:55:13 -0500
Date: Tue, 7 Mar 2006 16:54:55 -0800
From: Greg KH <greg@kroah.com>
To: Chuck Ebbert <76306.1226@compuserve.com>
Cc: Linus Torvalds <torvalds@osdl.org>, Andrew Morton <akpm@osdl.org>,
       Ingo Molnar <mingo@elte.hu>,
       linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: Fw: Re: oops in choose_configuration()
Message-ID: <20060308005455.GA23921@kroah.com>
References: <200603071657_MC3-1-BA0F-6372@compuserve.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200603071657_MC3-1-BA0F-6372@compuserve.com>
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Mar 07, 2006 at 04:54:24PM -0500, Chuck Ebbert wrote:
> In-Reply-To: <Pine.LNX.4.64.0603051840280.13139@g5.osdl.org>
> 
> On Sun, 5 Mar 2006 19:27:53 -0800, Linus Torvalds wrote:
> 
> > So I'd be more inclined to blame a buffer overflow on a kmalloc, and the 
> > obvious target is the "add_uevent_var()" thing, since all/many of the 
> > corruptions seem to come from uevent environment variable strings.
> 
> At least one susbsystem rolls its own method of adding env vars to the
> uevent buffer, and it's so broken it triggers the WARN_ON() in
> lib/vsprintf.c::vsnprintf() by passing a negative length to that function.
> Start at drivers/input/input.c::input_dev_uevent() and watch the fun.

All of the INPUT_ADD_HOTPLUG_VAR() calls do use add_uevent_var(), so we
should be safe there.  The other calls also look safe, if not a bit
wierd...  So I don't see how we could change this to be any safer, do
you?

> I reported this to linux-kernel, the input maintainer and the author
> of that code on Feb. 26:
> 
>         http://lkml.org/lkml/2006/2/26/39

We should have fixed that already by increasing the size of the buffer,
but yes, we should catch errors in the MODALIAS function, that would
have stopped that previous overflow.  Are you still seeing problems now?

thanks,

greg k-h
