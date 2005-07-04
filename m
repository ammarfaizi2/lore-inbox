Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261343AbVGDLvt@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261343AbVGDLvt (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 4 Jul 2005 07:51:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261643AbVGDLvs
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 4 Jul 2005 07:51:48 -0400
Received: from ms-smtp-05.texas.rr.com ([24.93.47.44]:47869 "EHLO
	ms-smtp-05-eri0.texas.rr.com") by vger.kernel.org with ESMTP
	id S261343AbVGDLvq (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 4 Jul 2005 07:51:46 -0400
Date: Mon, 4 Jul 2005 06:51:35 -0500
From: serge@hallyn.com
To: Tony Jones <tonyj@suse.de>
Cc: lkml <linux-kernel@vger.kernel.org>
Subject: Re: [patch 5/12] lsm stacking v0.2: actual stacker module
Message-ID: <20050704115135.GA27617@vino.hallyn.com>
References: <20050630194458.GA23439@serge.austin.ibm.com> <20050630195043.GE23538@serge.austin.ibm.com> <20050704031820.GA6871@immunix.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20050704031820.GA6871@immunix.com>
User-Agent: Mutt/1.5.8i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting Tony Jones (tonyj@suse.de):
> Hey Serge,
> 
> I don't think your symbol_get() is doing what you think it is ;-)

Hmm, I wonder whether something changed.  It shouldn't be possible to
rmmod module b if module a has done a symbol_get on it...  This may mean
more stringent locking will be required after all to support unloading.
That, or a rmmod lsm hook.

> > + * Add the stacked module (as specified by name and ops).
> > + * If the module is not compiled in, the symbol_get at the end will
> > + * prevent the the module from being unloaded.
> > +*/
> > +static int stacker_register (const char *name, struct security_operations *ops)
> > +{
>  ...
> > +	symbol_get(ops);
> > +
> > +out:
> > +	spin_unlock(&stacker_lock);
> > +	return ret;
> > +}
> 
> 
> Seemed useful to be able to view which modules had been unloaded.
> Easier to maintain them on their own list than to compute the difference
> of <stacked_modules> and <all_modules>.  Patch attached, not sure if you
> are cool with reusing the 'unload' file.

No, that's good, thanks.  Though I guess "unloading" of this type won't
be needed if true module deletion has to be supported.

> Apart from this, looks good.  I ran it against our regression tests using
> AppArmor (SubDomain) composed with Capability and everything was functionally
> as expected.   I still need to run it through our SMP stress tests.

Excellent :)

thanks,
-serge
