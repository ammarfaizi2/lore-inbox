Return-Path: <linux-kernel-owner+w=401wt.eu-S1752049AbXARRQV@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752049AbXARRQV (ORCPT <rfc822;w@1wt.eu>);
	Thu, 18 Jan 2007 12:16:21 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752068AbXARRQV
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 18 Jan 2007 12:16:21 -0500
Received: from nic.NetDirect.CA ([216.16.235.2]:41046 "EHLO
	rubicon.netdirect.ca" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752049AbXARRQU (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 18 Jan 2007 12:16:20 -0500
X-Originating-Ip: 74.109.98.130
Date: Thu, 18 Jan 2007 12:10:35 -0500 (EST)
From: "Robert P. J. Day" <rpjday@mindspring.com>
X-X-Sender: rpjday@CPE00045a9c397f-CM001225dbafb6
To: Tim Schmielau <tim@physik3.uni-rostock.de>
cc: Linux kernel mailing list <linux-kernel@vger.kernel.org>,
       Roman Zippel <zippel@linux-m68k.org>
Subject: Re: [PATCH]  Centralize the macro definition of "__packed".
In-Reply-To: <Pine.LNX.4.63.0701181803320.2210@gockel.physik3.uni-rostock.de>
Message-ID: <Pine.LNX.4.64.0701181208330.31997@CPE00045a9c397f-CM001225dbafb6>
References: <Pine.LNX.4.64.0701180959470.19826@CPE00045a9c397f-CM001225dbafb6>
 <Pine.LNX.4.63.0701181745550.2068@gockel.physik3.uni-rostock.de>
 <Pine.LNX.4.64.0701181147250.24824@CPE00045a9c397f-CM001225dbafb6>
 <Pine.LNX.4.63.0701181803320.2210@gockel.physik3.uni-rostock.de>
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

On Thu, 18 Jan 2007, Tim Schmielau wrote:

> On Thu, 18 Jan 2007, Robert P. J. Day wrote:
>
> > actually, it *appears* that the standard works this way.  the macro
> > "__deprecated" is defined in compiler-gcc.h with:
> >
> >     #define __deprecated __attribute__((deprecated))
> >
> > while the more generic compiler.h handles whether or not it was
> > defined:
> >
> >     #ifndef __deprecated
> >     # define __deprecated           /* unimplemented */
> >     #endif
> >
> > so i'm guessing that's how any new attribute shortcut macros should be
> > handled, yes?
>
> Well, since the definitions lived well in compiler-generic land for
> quite some time, I'd guess it should be ok not to #ifndef - guard
> them. likely() and unlikely() are currently handled like that. If
> the need ever arises to make them compiler specific, whoever does
> that can still add the #ifndef then.

as it is, i believe the only two compilers that are officially
supported for building the kernel are gcc and icc, and icc identifies
itself as a GNU compiler anyway, so adding to compiler-gcc.h should be
safe until the situation changes.

and, as you say, if the situation changes, fixing compiler.h would be
easy.

rday
