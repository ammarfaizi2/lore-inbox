Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266048AbUJVT6M@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266048AbUJVT6M (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 22 Oct 2004 15:58:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267370AbUJVT5r
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 22 Oct 2004 15:57:47 -0400
Received: from mail.kroah.org ([69.55.234.183]:9660 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S266048AbUJVT4c (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 22 Oct 2004 15:56:32 -0400
Date: Fri, 22 Oct 2004 12:55:15 -0700
From: Greg KH <greg@kroah.com>
To: linux-kernel@vger.kernel.org, sensors@stimpy.netroedge.com,
       Nishanth Aravamudan <nacc@us.ibm.com>
Subject: Re: [PATCH] fix recently introduced race in IBM PPC4xx I2C driver
Message-ID: <20041022195515.GF24282@kroah.com>
References: <10982315061975@kroah.com> <1098231506495@kroah.com> <20041020052108.GA14871@gate.ebshome.net> <20041020062633.GA16580@gate.ebshome.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20041020062633.GA16580@gate.ebshome.net>
User-Agent: Mutt/1.5.6i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Oct 19, 2004 at 11:26:33PM -0700, Eugene Surovegin wrote:
> On Tue, Oct 19, 2004 at 10:21:08PM -0700, Eugene Surovegin wrote:
> 
> [snip]
> 
> > It looks like this change added race I tried to avoid here.
> > 
> > This code is modeled after __wait_event_interruptible_timeout, where 
> > "prepare_to_wait" is done _before_ checking completion status. This 
> > change breaks this, e.g. if IRQ happens right after we check iic->sts, 
> > but before calling msleep_interruptible(). In this case we'll sleep 
> > much more than required (seconds instead of microseconds)
> > 
> > Greg, if my analysis is correct, please rollback this change.
> > 
> > Nishanth, I'd be nice if you CC'ed me with this patch, my e-mail is at 
> > the top of that source file.
> 
> Oh, well. I should have used wait_event_interruptible_timeout when I 
> ported this driver to 2.6.
> 
> This patch fixes recently introduced race and also cleans ups some 
> 2.4-ism.
> 
> Please, apply.

Applied, thanks.

greg k-h
