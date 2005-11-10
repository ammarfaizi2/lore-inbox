Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932255AbVKJXS7@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932255AbVKJXS7 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 10 Nov 2005 18:18:59 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932254AbVKJXS7
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 10 Nov 2005 18:18:59 -0500
Received: from mail.kroah.org ([69.55.234.183]:53671 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S932253AbVKJXS6 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 10 Nov 2005 18:18:58 -0500
Date: Thu, 10 Nov 2005 15:01:26 -0800
From: Greg KH <greg@kroah.com>
To: Jan Beulich <JBeulich@novell.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [PATCH 3/39] NLKD - early/late CPU up/down notification
Message-ID: <20051110230126.GA5381@kroah.com>
References: <43720DAE.76F0.0078.0@novell.com> <43720E2E.76F0.0078.0@novell.com> <43720E72.76F0.0078.0@novell.com> <43720EAF.76F0.0078.0@novell.com> <20051109164544.GB32068@kroah.com> <43723B57.76F0.0078.0@novell.com> <20051109171919.GA32761@kroah.com> <437307BC.76F0.0078.0@novell.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <437307BC.76F0.0078.0@novell.com>
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Nov 10, 2005 at 08:41:32AM +0100, Jan Beulich wrote:
> >>> Greg KH <greg@kroah.com> 09.11.05 18:19:19 >>>
> >On Wed, Nov 09, 2005 at 06:09:27PM +0100, Jan Beulich wrote:
> >> >>> Greg KH <greg@kroah.com> 09.11.05 17:45:44 >>>
> >> >#ifdef in the .h file is not needed.  Please fix your email client
> to
> >> >send patches properly.
> >> 
> >> It's not needed, sure, but by having it there I just wanted to make
> >> clear that this is something that never can be called from a module
> >> (after all, why should one find out at modpost time (and maybe even
> miss
> >> the message since there are so many past eventual symbol resolution
> >> warnings) when one can already at compile time.
> >
> >If it isn't present, and you do a build, you will still get the error
> at
> >build time, just during a different part of it.  Adding #ifdef just
> to
> >move the error to a different part of the build isn't needed. 
> Remember,
> >we want to not use #ifdef at all if we can ever help it.
> 
> I understand that. But you don't see my point, so I'll try to explain
> the background: When discovering the reason for the kallsyms change
> (also posted with the other NLKD patches) not functioning with
> CONFIG_MODVERSIONS and binutils between 2.16.90 and 2.16.91.0.3 I
> realized that the warning messages from the modpost build stage are very
> easy to overlook (in fact, all reporters of the problem overlooked them
> as well as I did on the first build attempting to reproduce the
> problem).

When you try to load the module, you will get the error again, right in
your kernel/system log, which explicitly shows that you had a problem.

> This basically means these messages are almost useless, and
> detection of the problem will likely be deferred to the first attempt to
> load an offending module (which, as in the case named, may lead to an
> unusable kernel). Hence, at least until this build problem gets
> addressed I continue to believe that adding the preprocessor conditional
> is the better way of dealing with potential issues. Sure I know that
> hundreds of other symbols possibly causing the same problem aren't
> protected...

Don't try to do things to fix your prior problems in your patch, with
changes today so that you don't do it again in the future :)

The build process properly notifies the builder of the problem, if they
ignore it, there's really nothing more we can do about it, right?

thanks,

greg k-h
