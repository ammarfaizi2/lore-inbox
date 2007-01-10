Return-Path: <linux-kernel-owner+w=401wt.eu-S964798AbXAJNvp@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964798AbXAJNvp (ORCPT <rfc822;w@1wt.eu>);
	Wed, 10 Jan 2007 08:51:45 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964840AbXAJNvp
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 10 Jan 2007 08:51:45 -0500
Received: from nic.NetDirect.CA ([216.16.235.2]:41929 "EHLO
	rubicon.netdirect.ca" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S964798AbXAJNvo (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 10 Jan 2007 08:51:44 -0500
X-Originating-Ip: 74.109.98.130
Date: Wed, 10 Jan 2007 08:46:26 -0500 (EST)
From: "Robert P. J. Day" <rpjday@mindspring.com>
X-X-Sender: rpjday@CPE00045a9c397f-CM001225dbafb6
To: "linux-os (Dick Johnson)" <linux-os@analogic.com>
cc: Stefan Richter <stefanr@s5r6.in-berlin.de>,
       Linux kernel mailing list <linux-kernel@vger.kernel.org>
Subject: Re: macros:  "do-while" versus "({ })" and a compile-time error
In-Reply-To: <Pine.LNX.4.61.0701100715330.16104@chaos.analogic.com>
Message-ID: <Pine.LNX.4.64.0701100841150.3216@CPE00045a9c397f-CM001225dbafb6>
References: <Pine.LNX.4.64.0701081347410.32420@localhost.localdomain>
 <45A3D1DF.4020205@s5r6.in-berlin.de> <Pine.LNX.4.61.0701091415200.12545@chaos.analogic.com>
 <Pine.LNX.4.64.0701100116420.10133@localhost.localdomain>
 <Pine.LNX.4.61.0701100715330.16104@chaos.analogic.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
X-Net-Direct-Inc-MailScanner-Information: Please contact the ISP for more information
X-Net-Direct-Inc-MailScanner: Found to be clean
X-Net-Direct-Inc-MailScanner-SpamCheck: not spam, SpamAssassin (not cached,
	score=-16.8, required 5, autolearn=not spam, ALL_TRUSTED -1.80,
	BAYES_00 -15.00)
X-Net-Direct-Inc-MailScanner-From: rpjday@mindspring.com
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 10 Jan 2007, linux-os (Dick Johnson) wrote:

>
> On Wed, 10 Jan 2007, Robert P. J. Day wrote:

> > just FYI, the reason i brought this up in the first place is that
> > i noticed that the ALIGN() macro in kernel.h didn't verify that
> > the alignment value was a power of 2, so i thought -- hmmm, i
> > wonder if there are any invocations where that's not true, so i
> > (temporarily) rewrote ALIGN to incorporate that check, and the
> > build blew up including include/net/neighbour.h, which contains
> > the out-of-function declaration:
> >
> > struct neighbour
> > {
> >        ...
> >        unsigned char           ha[ALIGN(MAX_ADDR_LEN, sizeof(unsigned long))];
> >        ...
> >
> > so it's not a big deal, it was just me goofing around and breaking
> > things.
> >
> > rday
>
>
> Hmmm, in that case you would be trying to put code inside a
> structure! Neat --if you could do it!

well, yes, but it does raise a potential issue.  currently, that
ALIGN() macro is being used to define one of the members of that
structure.  since it's a "simple" macro, there's no problem.

but there are *plenty* of macros in the source tree that incorporate
either the "do-while" or "({ })" notation.  what the above implies is
that the ALIGN() macro can *never* be extended in that way because of
the way it's being used in the struct definition above, outside of a
function.

doesn't that place an unnecessarily limit on what might be done with
ALIGN() in the future?  because of how it's being used in that single
structure definition, it is forever restricted from being extended.
isn't that perhaps a dangerous restriction for any macro?

rday
