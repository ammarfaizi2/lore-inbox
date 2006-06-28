Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751790AbWF1X5R@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751790AbWF1X5R (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 28 Jun 2006 19:57:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751794AbWF1X5Q
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 28 Jun 2006 19:57:16 -0400
Received: from scrub.xs4all.nl ([194.109.195.176]:33941 "EHLO scrub.xs4all.nl")
	by vger.kernel.org with ESMTP id S1751790AbWF1X5Q (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 28 Jun 2006 19:57:16 -0400
Date: Thu, 29 Jun 2006 01:56:33 +0200 (CEST)
From: Roman Zippel <zippel@linux-m68k.org>
X-X-Sender: roman@scrub.home
To: Milton Miller <miltonm@bga.com>
cc: LKML <linux-kernel@vger.kernel.org>, "H. Peter Anvin" <hpa@zytor.com>
Subject: Re: klibc and what's the next step?
In-Reply-To: <f5e0f599448456bcbf2699994f0bbc76@bga.com>
Message-ID: <Pine.LNX.4.64.0606290117220.17704@scrub.home>
References: <Pine.LNX.4.64.0606271316220.17704@scrub.home>
 <f5e0f599448456bcbf2699994f0bbc76@bga.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Tue, 27 Jun 2006, Milton Miller wrote:

> > I could now repeat all the concerns I already mentioned, why it 
> > shouldn't
> > be merged as is (that doesn't mean it shouldn't be merged at all!), but
> > they have been pretty much ignored anyway...
> 
> I'm guessing these threads?
> 
> http://marc.theaimsgroup.com/?l=linux-kernel&m=114946240404001&w=2
> http://marc.theaimsgroup.com/?l=linux-kernel&m=114967046318388&w=2

Yes.

> Let me see if I can summarize:
> 
> * There is concern about how much is bloat, where do we draw the line 
> for in-kernel

That actually wouldn't be my initial concern. Otherwise I'm happy to point 
out kernel bloat, but here it's more important to prototype a mechanism. 
In this case bloat can still be fixed later, as it's rather isolated 
behind a standard API.

> * There is concern about duplicating user space utilities.  We moved 
> the kernel broken md assemble instead of getting the current one from 
> mdadm, and that should be part of mdadm package.

The problem here is twofold. First, duplication means extra maintenance 
overhead, various version of the copies have to be kept in sync. The 
temptation to fix only the kernel version without updating the normal 
version could be quite big, so that users might not realize they have 
broken tools until they e.g. try reconfigure the system.
Second, whatever we deliver with the kernel, might become part of kernel 
API (e.g. config files), which needs to be supported for a long time. 
Compatibility code can accumulate rather quickly.

> * Some distributions are already using klibc and have been.  They see 
> the reason to merge is to have the canonical api with the kernel to 
> avoid version mismatch.

klibc will continue as independent project anyway, so it should not be 
difficult to include from the kernel whatever the distribution provides. 
It would help avoiding possible problems with mixing binaries built from 
different libraries.

bye, Roman
