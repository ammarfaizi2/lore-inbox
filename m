Return-Path: <linux-kernel-owner+willy=40w.ods.org-S269470AbUIRNGS@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S269470AbUIRNGS (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 18 Sep 2004 09:06:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S269464AbUIRNFu
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 18 Sep 2004 09:05:50 -0400
Received: from colo.khms.westfalen.de ([213.239.196.208]:42390 "EHLO
	colo.khms.westfalen.de") by vger.kernel.org with ESMTP
	id S269470AbUIRNFq (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 18 Sep 2004 09:05:46 -0400
Date: 18 Sep 2004 11:46:00 +0200
From: kaih@khms.westfalen.de (Kai Henningsen)
To: linux-kernel@vger.kernel.org
Message-ID: <9H7p12YXw-B@khms.westfalen.de>
In-Reply-To: <Pine.LNX.4.58.0409160652460.2333@ppc970.osdl.org>
Subject: Re: Being more careful about iospace accesses..
X-Mailer: CrossPoint v3.12d.kh14 R/C435
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Organization: Organisation? Me?! Are you kidding?
References: <Pine.LNX.4.58.0409081543320.5912@ppc970.osdl.org> <Pine.LNX.4.58.0409151546400.2333@ppc970.osdl.org> <1095337514.9144.2344.camel@imladris.demon.co.uk> <1095337514.9144.2344.camel@imladris.demon.co.uk> <Pine.LNX.4.58.0409160652460.2333@ppc9
X-No-Junk-Mail: I do not want to get *any* junk mail.
Comment: Unsolicited commercial mail will incur an US$100 handling fee per received mail.
X-Fix-Your-Modem: +++ATS2=255&WO1
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

torvalds@osdl.org (Linus Torvalds)  wrote on 16.09.04 in <Pine.LNX.4.58.0409160652460.2333@ppc970.osdl.org>:

> On Thu, 16 Sep 2004, David Woodhouse wrote:
>
> > On Wed, 2004-09-15 at 16:26 -0700, Linus Torvalds wrote:
> > >  - if you want to go outside that bitwise type, you have to convert it
> > >    properly first. For example, if you want to add a constant to a
> > >    __le16 type, you can do so, but you have to use the proper sequence:
> > >
> > > 	__le16 sum, a, b;
> > >
> > > 	sum = a + b;	/* INVALID! "warning: incompatible types for operation
> > > (+)" */ 	sum = cpu_to_le16(le16_to_cpu(a) + le16_to_cpu(b));	/* Ok */
> > >
> > > See?
> >
> > Yeah right, that latter case is _so_ much more readable
>
> It's not about readability.
>
> It's about the first case being WRONG!

... in general.

And on the machines where it works (le machines), I'd certainly expect  
those conversion functions to be trivially eliminated by the compiler (ie,  
they're either trivial macros or trivial inline functions).

> > I'd really quite like to see the real compiler know about endianness,
> > too.

Well, these day, optimizers often can recognize the usual endianness  
conversion idioms, so the compiler still gets a chance at inserting your  
load-with-swap or whatever.

MfG Kai
