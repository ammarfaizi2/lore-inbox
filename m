Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262889AbUJ1Vff@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262889AbUJ1Vff (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 28 Oct 2004 17:35:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262881AbUJ1Vff
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 28 Oct 2004 17:35:35 -0400
Received: from mail.kroah.org ([69.55.234.183]:33701 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S263032AbUJ1VPm (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 28 Oct 2004 17:15:42 -0400
Date: Thu, 28 Oct 2004 16:14:32 -0500
From: Greg KH <greg@kroah.com>
To: Andrew Morton <akpm@osdl.org>
Cc: dsaxena@plexity.net, torvalds@osdl.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] Remove inclusion of <linux/irq.h> from pci/quirks.c
Message-ID: <20041028211432.GB9369@kroah.com>
References: <20041020182222.GA20201@plexity.net> <20041020215750.3f3764e6.akpm@osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20041020215750.3f3764e6.akpm@osdl.org>
User-Agent: Mutt/1.5.6i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Oct 20, 2004 at 09:57:50PM -0700, Andrew Morton wrote:
> Deepak Saxena <dsaxena@plexity.net> wrote:
> >
> > <linux/irq.h> states:
> > 
> >  /*
> >   * Please do not include this file in generic code.  There is currently
> >   * no requirement for any architecture to implement anything held
> >   * within this file.
> >   *
> >   * Thanks. --rmk
> >   */
> > 
> >  The latest update into pci/quirks.c did not follow this and breaks 
> >  building on ARM.
> 
> But it does break building on x86, which might prove a tad unpopular.
> 
> That x86 code shouldn't be in the generic PCI code at all, I guess.  This
> patch move it into io_apic.c and appears to build OK.  I'll play with it a
> bit more.
> 
> Also, it worries me that quirk_intel_irqbalance() is marked __devinit and
> calls irqbalance_disable(), which is marked __init.  I guess a fix for that
> would be to mark quirk_intel_irqbalance() as __init, since it's unlikely to
> be called after free_initmem().  Does Greg agree?

I do agree.  But I think the intel people are mucking around in this
area too and hopefully they'll fix it all up soon...

thanks,

greg k-h
