Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S274966AbTHFXcj (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 6 Aug 2003 19:32:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S272057AbTHFXba
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 6 Aug 2003 19:31:30 -0400
Received: from mail.kroah.org ([65.200.24.183]:48021 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S275029AbTHFXax (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 6 Aug 2003 19:30:53 -0400
Date: Wed, 6 Aug 2003 16:31:03 -0700
From: Greg KH <greg@kroah.com>
To: Jeff Garzik <jgarzik@pobox.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: devinit
Message-ID: <20030806233103.GA8497@kroah.com>
References: <3F315CDD.12EB17FE@hp.com> <20030806230919.GB8187@kroah.com> <3F318D73.3000809@pobox.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3F318D73.3000809@pobox.com>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Aug 06, 2003 at 07:21:23PM -0400, Jeff Garzik wrote:
> Greg KH wrote:
> >I've applied the 2.6 patch to my trees and will send it on to Linus in a
> >few days, thanks.
> 
> 
> Speaking of PCI... are we gonna have to zap __devinit too?  Another 
> option is to think of add-new-pci-ids-on-the-fly as a CONFIG_HOTPLUG 
> feature, which should(?) maintain the current __devinit semantics: no 
> re-probes.

Yeah, that option does break almost all current usages of __devinit* in
pci drivers today with CONFIG_HOTPLUG disabled :(

So either making it a different config option, or just dropping
__devinit* all together is fine with me, one of them needs to happen.

Any preferences from anyone else?

> OTOH, __devinit already is a no-op for CONFIG_HOTPLUG cases (read: most 
> everybody), so I wonder if we care enough about __devinit anymore?  I 
> used the same logic to support __devinitdata removal, after all.

If we drop __devinit* then having CONFIG_HOTPLUG as a config option is
almost pointless as it doesn't really affect much code at all.  Any
objections to just always enabling it?

Anyone want to make up any before and after memory usages with
CONFIG_HOTPLUG enabled and disabled to see if it's really as small as
I'm thinking it is?  

Do the embedded people care?  :)

thanks,

greg k-h
