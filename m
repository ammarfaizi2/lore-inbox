Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030243AbVHPRBA@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030243AbVHPRBA (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 16 Aug 2005 13:01:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030244AbVHPRA7
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 16 Aug 2005 13:00:59 -0400
Received: from smtp.osdl.org ([65.172.181.4]:65426 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S1030243AbVHPRA7 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 16 Aug 2005 13:00:59 -0400
Date: Tue, 16 Aug 2005 10:00:50 -0700 (PDT)
From: Linus Torvalds <torvalds@osdl.org>
To: Helge Hafting <helgehaf@aitel.hist.no>
cc: Dave Airlie <airlied@gmail.com>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, akpm@osdl.org
Subject: Re: rc6 keeps hanging and blanking displays
In-Reply-To: <20050816165242.GA10024@aitel.hist.no>
Message-ID: <Pine.LNX.4.58.0508160955270.3553@g5.osdl.org>
References: <20050805104025.GA14688@aitel.hist.no> <21d7e99705080503515e3045d5@mail.gmail.com>
 <42F89F79.1060103@aitel.hist.no> <42FC7372.7040607@aitel.hist.no>
 <Pine.LNX.4.58.0508120937140.3295@g5.osdl.org> <43008C9C.60806@aitel.hist.no>
 <Pine.LNX.4.58.0508150843380.3553@g5.osdl.org> <20050815221109.GA21279@aitel.hist.no>
 <21d7e99705081516182e97b8a1@mail.gmail.com> <21d7e99705081516241197164a@mail.gmail.com>
 <20050816165242.GA10024@aitel.hist.no>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Tue, 16 Aug 2005, Helge Hafting wrote:
>
> I tried rc6 with DRM turned off.  That kernel consistently _died_ when 
> trying to start xdm. Xorg logs for both cards ended like this:
> 
> (II) LoadModule: "pcidata"
> (II) Loading /usr/X11R6/lib/modules/libpcidata.a

Ok, it does sound like your X server is doing something nasty on the PCI 
bus. 

> I can retry this with a syncronously mounted /var, if the last lines
> of the Xorg logs might be interesting.

It would be even more interesting if you have a serial console, but if
this is the X server stomping on the PCI bus, you might just have a total
lockup - no oops, no nothing.

One thing that might be interesting is to see if the old working kernel
has a different IO-map than the broken ones. A simple

	cat /proc/ioports /proc/iomem > iomaps.kernel-version

and diffing the two might be an interesting thing to try. X has been known
to sometimes just try to re-configure things on its own without telling
(or asking) the kernel.

			Linus
