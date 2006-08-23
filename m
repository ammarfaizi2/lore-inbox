Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964847AbWHWKze@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964847AbWHWKze (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 23 Aug 2006 06:55:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964854AbWHWKze
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 23 Aug 2006 06:55:34 -0400
Received: from gundega.hpl.hp.com ([192.6.19.190]:40938 "EHLO
	gundega.hpl.hp.com") by vger.kernel.org with ESMTP id S964847AbWHWKzd
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 23 Aug 2006 06:55:33 -0400
Date: Wed, 23 Aug 2006 03:45:25 -0700
From: Stephane Eranian <eranian@hpl.hp.com>
To: Andi Kleen <ak@suse.de>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [PATCH 6/18] 2.6.17.9 perfmon2 patch for review: sampling format support
Message-ID: <20060823104525.GC697@frankl.hpl.hp.com>
Reply-To: eranian@hpl.hp.com
References: <200608230805.k7N85v1s000408@frankl.hpl.hp.com> <p737j0z7nh2.fsf@verdi.suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <p737j0z7nh2.fsf@verdi.suse.de>
User-Agent: Mutt/1.4.1i
Organisation: HP Labs Palo Alto
Address: HP Labs, 1U-17, 1501 Page Mill road, Palo Alto, CA 94304, USA.
E-mail: eranian@hpl.hp.com
X-HPL-MailScanner: Found to be clean
X-HPL-MailScanner-From: eranian@frankl.hpl.hp.com
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andi,

On Wed, Aug 23, 2006 at 12:31:05PM +0200, Andi Kleen wrote:
> Stephane Eranian <eranian@frankl.hpl.hp.com> writes:
> 
> > This files contains the sampling format support.
> > 
> > Perfmon2 supports an in-kernel sampling buffer for performance
> > reasons. Yet to ensure maximum flexibility to applications,
> > the formats is which infmration is recorded into the kernel
> > buffer is not specified by the interface. Instead it is
> > delegated to a kernel plug-in modules called sampling formats.
> 
> This seems quote complicated. Who are the users of different sampling formats?
> 
The best example I have is PEBS. With PEBS the sampling buffer
format is dictated by HW not software. Lots of people are using
PEBS, this is a really useful feature, that has been very hard to
get to so far.

Without the sampling format mechanism, I could certainly hardcode
the default format and be done. But then I would have to hack
something in just for PEBS on P4.

One day, someone would come along and ask for another type of
format, that would add more complexity. Instead of this, I designed
some flexible and fairly simple that provides enough flexibility
to support lots of different formats (including Oprofile).
I have already received requests for a format that does double-buffering
for instance.

> I assume the code would be considerable simpler if you hardcoded 
> the perfmon2 format, right?

Maybe at the beginning, but it would quickly becomes complicated as
new HW features emerge.

-- 
-Stephane
