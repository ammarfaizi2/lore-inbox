Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751288AbWARRDt@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751288AbWARRDt (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 18 Jan 2006 12:03:49 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751363AbWARRDt
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 18 Jan 2006 12:03:49 -0500
Received: from mail.kroah.org ([69.55.234.183]:1450 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S1751288AbWARRDs (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 18 Jan 2006 12:03:48 -0500
Date: Wed, 18 Jan 2006 09:02:12 -0800
From: Greg KH <greg@kroah.com>
To: Blaisorblade <blaisorblade@yahoo.it>
Cc: user-mode-linux-devel@lists.sourceforge.net, akpm@osdl.org,
       Jeff Dike <jdike@addtoit.com>, linux-kernel@vger.kernel.org
Subject: Re: [uml-devel] Re: [PATCH 1/9] uml: avoid sysfs warning on hot-unplug
Message-ID: <20060118170212.GB12757@kroah.com>
References: <20060118011200.GA28086@kroah.com> <200601181253.54942.blaisorblade@yahoo.it>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200601181253.54942.blaisorblade@yahoo.it>
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jan 18, 2006 at 12:53:54PM +0100, Blaisorblade wrote:
> On Wednesday 18 January 2006 02:12, Greg KH wrote:
> > > From: Jeff Dike <jdike@addtoit.com>, Paolo 'Blaisorblade' Giarrusso
> > > <blaisorblade@yahoo.it>
> > >
> > > Define a release method for the ubd and network driver so that sysfs
> > > doesn't complain when one is removed via:
> 
> > What?  No.  The kernel is complaining for a reason, don't try to
> > out-smart it.
> 
> I'm not trying to ignore the warning.

By providing a release function that does nothing, all you are doing is
shutting the kernel up.  You are not doing anything to "fix" the real
problem at all.

> > > host $ uml_mconsole <umid> remove <dev>
> 
> > > Done by Jeff around January for ubd only, later lost, then restored in
> > > his tree - however I'm merging it now since there's no reason to leave
> > > this here.
> 
> > > We don't need to do any cleanup in the new added method, because when
> > > hot-unplug is done by uml_mconsole we already handle cleanup in mconsole
> > > infrastructure, i.e.  mc_device->remove (net_remove/ubd_remove), which is
> > > also the calling method.
> 
> > Huh?  You have 2 different release functions for the same object?
> 
> Not sure which ones you refer. net_remove and ubd_remove are for different 
> devices; mc_device->remove and the sysfs release are in different layers and 
> for different things.

Ok, but you are still adding 2 empty release functions.

Please do not do that, if you think you need this, your code logic is
wrong.

As for your specific bug report, sorry, I really don't know.

good luck,

greg k-h
