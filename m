Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262110AbUKJTwO@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262110AbUKJTwO (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 10 Nov 2004 14:52:14 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262113AbUKJTwN
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 10 Nov 2004 14:52:13 -0500
Received: from sd291.sivit.org ([194.146.225.122]:56040 "EHLO sd291.sivit.org")
	by vger.kernel.org with ESMTP id S262110AbUKJTvn (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 10 Nov 2004 14:51:43 -0500
Date: Wed, 10 Nov 2004 20:52:00 +0100
From: Stelian Pop <stelian@popies.net>
To: "Randy.Dunlap" <rddunlap@osdl.org>
Cc: Jeff Garzik <jgarzik@pobox.com>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Dominik Brodowski <linux@dominikbrodowski.de>,
       Andrew Morton <akpm@osdl.org>
Subject: Re: [PATCH] drivers/net/pcmcia: use module_param() instead of MODULE_PARM()
Message-ID: <20041110195200.GJ2706@deep-space-9.dsnet>
Reply-To: Stelian Pop <stelian@popies.net>
Mail-Followup-To: Stelian Pop <stelian@popies.net>,
	"Randy.Dunlap" <rddunlap@osdl.org>, Jeff Garzik <jgarzik@pobox.com>,
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
	Dominik Brodowski <linux@dominikbrodowski.de>,
	Andrew Morton <akpm@osdl.org>
References: <20041104112736.GT3472@crusoe.alcove-fr> <418AE490.1010304@pobox.com> <20041110155903.GA8542@sd291.sivit.org> <20041110160058.GB8542@sd291.sivit.org> <41924339.1070809@osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <41924339.1070809@osdl.org>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Nov 10, 2004 at 08:35:05AM -0800, Randy.Dunlap wrote:

> Hi Stelian,

Hi.
> 
> Several of these changes expose module parameters to sysfs
> (i.e., have permissions of non-zero value) without need for that IMO.
> 
> This came up yesterday on the kernel-janitors mailing list.
> When asked about it, Greg KH replied:

:)

I shouldn't probably discuss Greg's advice, but...
> 
> > Can someone please clarify the "official guidelines" for
> > module parameter permissions in sysfs?
> 
> "When it makes sense to have it exposed to userspace"
> 
> Yeah, it's vague, sorry, but it all depends.
> 
> For things that can be changed on the fly, expose it.

... with a write permission. Agreed.

> For things that don't really matter, and no one will ever look them up,
> don't. 
>I think the irq stuff is in the "don't" category, as almost no
> one messes with them anymore.

In this case why is this a module parameter at all ? If it doesn't
matter at all then it should get removed from all places.

In fact, I do think that all module parameter should be exposed in
/sys, and that a '0' in module_param() should really mean 0400.

It can be useful to know what parameters have been passed to a module,
and I cannot think of a single case where we want to hide this 
information (and no, security doesn't really apply here. If you have
root rights than you can also look into the kernel memory and find
out the value by yourself).

The only questions one should ask himself about a module parameter is
whether:
	- it is a R/O or a R/W value (and this is determined by
	  the code who uses this value, if it is dynamic then let
	  the parameter be R/W, if it's only used to make assumptions
	  in the init phase then it must be R/O).

	- it can be shown to everybody, or only root should be able
	  to read the value (0400 vs 0440/0444). I'm not sure this is
	  really useful since /etc/modprobe.conf is generaly 0644,
	  but it could be in some cases...

Stelian.
-- 
Stelian Pop <stelian@popies.net>
