Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261273AbTHSSra (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 19 Aug 2003 14:47:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261168AbTHSSmo
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 19 Aug 2003 14:42:44 -0400
Received: from mail.kroah.org ([65.200.24.183]:7394 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S261162AbTHSSfw (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 19 Aug 2003 14:35:52 -0400
Date: Tue, 19 Aug 2003 11:35:37 -0700
From: Greg KH <greg@kroah.com>
To: Marc Zyngier <mzyngier@freesurf.fr>
Cc: torvalds@osdl.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] EISA bus update
Message-ID: <20030819183537.GA5297@kroah.com>
References: <wrp3cfxn78n.fsf@hina.wild-wind.fr.eu.org> <20030819174208.GA4992@kroah.com> <wrpptj1fr83.fsf@hina.wild-wind.fr.eu.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <wrpptj1fr83.fsf@hina.wild-wind.fr.eu.org>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Aug 19, 2003 at 08:16:12PM +0200, Marc Zyngier wrote:
> >>>>> "Greg" == Greg KH <greg@kroah.com> writes:
> 
> Greg,
> 
> Greg> Marc, why do you think that you do not need to do anything in
> Greg> this function?  Don't you need to handle the fact that your code
> Greg> could be removed before the release function is called?
> 
> Well, there is nothing to do in this function, because that's what the
> whole driver does: nothing. It just presents a range of IO ports to be
> probed to the main EISA code, and nothing else.

But it exports something in sysfs, right?  Any reason you just don't
dynamically create it?  It's real hard to get static allocation of
struct device correct.

> If the driver is removed from the kernel (which can't happen at the
> moment, since it is not modular), it doesn't matter... 

Will this code ever be able to be built as a module?  If so, this will
not be correct.

> Once it has registered as an EISA bus root, it doesn't get called
> anymore, the core code does it all by itself.

So the release function never gets called at all then?  Why would this
be needed at all?

thanks,

greg k-h
