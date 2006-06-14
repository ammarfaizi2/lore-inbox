Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964791AbWFNJ2z@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964791AbWFNJ2z (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 14 Jun 2006 05:28:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932212AbWFNJ2x
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 14 Jun 2006 05:28:53 -0400
Received: from gw.openss7.com ([142.179.199.224]:60855 "EHLO gw.openss7.com")
	by vger.kernel.org with ESMTP id S932210AbWFNJ2v (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 14 Jun 2006 05:28:51 -0400
Date: Wed, 14 Jun 2006 03:28:50 -0600
From: "Brian F. G. Bidulock" <bidulock@openss7.org>
To: Chase Venters <chase.venters@clientec.com>
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [RFC/PATCH 1/2] in-kernel sockets API
Message-ID: <20060614032850.C14829@openss7.org>
Reply-To: bidulock@openss7.org
Mail-Followup-To: Chase Venters <chase.venters@clientec.com>,
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org
References: <1150156562.19929.32.camel@w-sridhar2.beaverton.ibm.com> <200606131953.42002.chase.venters@clientec.com> <20060614000710.C7232@openss7.org> <200606140258.30302.chase.venters@clientec.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <200606140258.30302.chase.venters@clientec.com>; from chase.venters@clientec.com on Wed, Jun 14, 2006 at 02:58:08AM -0500
Organization: http://www.openss7.org/
Dsn-Notification-To: <bidulock@openss7.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Chase,

On Wed, 14 Jun 2006, Chase Venters wrote:
> 
> One point I remember coming up in the discussion was that the 
> EXPORT_SYMBOL()/EXPORT_SYMBOL_GPL() split was a compromise of sorts. 
> Interfaces that were needed to support users would reasonably be placed under 
> EXPORT_SYMBOL(). By contrast, EXPORT_SYMBOL_GPL() would indicate 
> functionality that would only seem to be used by derived works. It implies 
> that any code using it should probably be GPL as well.

The difficulty with EXPORT_SYMBOL_GPL() as I see it that it reached farther
than the GPL.  GPL does not impact non-derived works, which can be licensed
under any terms their authors see fit.  Whereas, EXPORT_SYMBOL_GPL() requires
a non-derived work to declare a GPL license to even use it.  If you subscribe
to the FSF view of derived work (just linking is a derivation) then I suppose
you would support the EXPORT_SYMBOL_GPL().  IANAL, but I don't believe that
TRIPS nor Berne Convention case law supports the FSF view.  Linus' statements
in the COPYING file take a different view: that simple use of a technical
interface is not necessarily (in itself) derivation.

Now, I understand the use of EXPORT_SYMBOL() vs. EXPORT_SYMBOL_GPL() to allow
authors to differ on this idea.  But, in the case in point, the function
pointers can be accessed by merely including the appropriate header files.
Changing a the wrapper access to them to EXPORT_SYMBOL_GPL() strikes me as
similar to changing kmalloc() from EXPORT_SYMBOL() to EXPORT_SYMBOL_GPL().

Understand that all exported symbols, regardless of licensing or modversions
or whatever, are available in the kernel boot image and can be linked to by
any module at any time.  That is, those that would abuse the concept of
derivation will not be impeded by EXPORT_SYMBOL_GPL().  (Rip the symbol from
the kernel image, write a thin GPL'ed module that aliases the symbol and the
exports it again as EXPORT_SYMBOL() without module versioning, copy the lines
of code into the proprietary module, reversing the order of arbitrary lines,
etc.)

In any case, all it serves to do is to punish honest non-derivative works not
published compatible with the GPL.

What I resist is the apparent attempt to change these symbols to _GPL as some
matter of general policy in this case contrary to the author's original
intentions as expressed in the original patch submission, and without the
author of the interface being wrappered jumping up an screaming that his code
was under strict FSF linking-is-derivation GPL (in which case we could have
had a good discussion on whether Linux NET4 is actually a derivative work of
BSD 4.4 Lite which was licensed under the "old" BSD license, incompatible with
the GPL ;)

As a general policy I would say make it EXPORT_SYMBOL() unless the author of
the patch (derivation) or author of the original (derived) code dictates that
it be EXPORT_SYMBOL_GPL().

Ok, I'll shut up now... ...really.
