Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261996AbVFQP3l@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261996AbVFQP3l (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 17 Jun 2005 11:29:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261997AbVFQP3l
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 17 Jun 2005 11:29:41 -0400
Received: from mail.kroah.org ([69.55.234.183]:22733 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S261996AbVFQP3j (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 17 Jun 2005 11:29:39 -0400
Date: Fri, 17 Jun 2005 08:29:10 -0700
From: Greg KH <greg@kroah.com>
To: Abhay_Salunke@Dell.com
Cc: linux-kernel@vger.kernel.org, akpm@osdl.org, dmitry.torokhov@gmail.com,
       Matt_Domsch@Dell.com
Subject: Re: [patch 2.6.12-rc3] dell_rbu: Resubmitting patch for new Dell BIOS update driver
Message-ID: <20050617152910.GA20283@kroah.com>
References: <B37DF8F3777DDC4285FA831D366EB9E2073081@ausx3mps302.aus.amer.dell.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <B37DF8F3777DDC4285FA831D366EB9E2073081@ausx3mps302.aus.amer.dell.com>
User-Agent: Mutt/1.5.8i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jun 17, 2005 at 09:55:31AM -0500, Abhay_Salunke@Dell.com wrote:
> > On Wed, Jun 15, 2005 at 12:59:46PM -0500, Abhay Salunke wrote:
> > > +static struct device rbu_device_mono;
> > > +static struct device rbu_device_packet;
> > > +static struct device rbu_device_cancel;
> > 
> > You should never create a struct device on the stack.  Lots of bad
> > things can happen (including not having a release function for them.)
> > 
> they are not declared inside any function; can they be on stack?

Sorry, I didn't mean "on the stack" I ment, they are static and not
dynamically allocated.

> > Why not just point to the cpu device, or some other platform or system
> > device?
> > 
> Not sure what these devices are for and didn't want to mess with them.

Ok, then I suggest you look into them then :)

Again, creating a struct device that is not dynamically allocated is not
allowed.  And creating a struct device that is not tied into the driver
tree, is also a bad thing.  Use the ones that are already present, or
register yours with the core so they show up properly.

thanks,

greg k-h
