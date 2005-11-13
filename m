Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750920AbVKMThG@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750920AbVKMThG (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 13 Nov 2005 14:37:06 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750977AbVKMThG
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 13 Nov 2005 14:37:06 -0500
Received: from smtp.osdl.org ([65.172.181.4]:35985 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S1750969AbVKMThE (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 13 Nov 2005 14:37:04 -0500
Date: Sun, 13 Nov 2005 11:36:42 -0800 (PST)
From: Linus Torvalds <torvalds@osdl.org>
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
cc: Andi Kleen <ak@suse.de>, Dave Jones <davej@redhat.com>,
       Zachary Amsden <zach@vmware.com>, Pavel Machek <pavel@ucw.cz>,
       Andrew Morton <akpm@osdl.org>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       "H. Peter Anvin" <hpa@zytor.com>,
       Zwane Mwaikambo <zwane@arm.linux.org.uk>,
       Pratap Subrahmanyam <pratap@vmware.com>,
       Christopher Li <chrisl@vmware.com>,
       "Eric W. Biederman" <ebiederm@xmission.com>,
       Ingo Molnar <mingo@elte.hu>
Subject: Re: [PATCH 1/10] Cr4 is valid on some 486s
In-Reply-To: <1131910902.25311.21.camel@localhost.localdomain>
Message-ID: <Pine.LNX.4.64.0511131130370.3263@g5.osdl.org>
References: <200511100032.jAA0WgUq027712@zach-dev.vmware.com> 
 <p734q6g4xuc.fsf@verdi.suse.de>  <1131902775.25311.16.camel@localhost.localdomain>
  <200511132000.45836.ak@suse.de> <1131910902.25311.21.camel@localhost.localdomain>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Sun, 13 Nov 2005, Alan Cox wrote:
>
> On Sul, 2005-11-13 at 20:00 +0100, Andi Kleen wrote:
> > It's a bad hack anyways. Better would be probably to use a uncached WC write.
> > I would rather use that.
> 
> I'm not clear that anything but lock operations have the required
> guarantee of atomicity relative to bus masters which are not processors.
> Especially so on intel.

The thing is, we wouldn't ever remove _all_ lock prefixes. Only the ones 
that already depend on SMP.

So the memory barriers etc that have lock prefixes even on UP would be 
totally untouched.

		Linus
