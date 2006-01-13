Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1161534AbWAMKLH@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161534AbWAMKLH (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 13 Jan 2006 05:11:07 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161535AbWAMKLH
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 13 Jan 2006 05:11:07 -0500
Received: from uproxy.gmail.com ([66.249.92.206]:39842 "EHLO uproxy.gmail.com")
	by vger.kernel.org with ESMTP id S1161529AbWAMKLG (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 13 Jan 2006 05:11:06 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:date:from:to:cc:subject:message-id:references:mime-version:content-type:content-disposition:in-reply-to:user-agent;
        b=kBgjtPUAxb0ipNWWWzwiv7+GNalsgRTKxRIWjUN5iTgMTj2872NBi7qZWIvGRl4VU+JMwk/z+72TDrs/15bItzKwZvwC/rxUL7RysfhOWBm1hufzeyJUb3sJZo75EYRy4nFAn+VV97oPw3V2syUiTy++iEwNhzyYdq4Sijrla+E=
Date: Fri, 13 Jan 2006 13:21:36 +0300
From: Alexey Dobriyan <adobriyan@gmail.com>
To: Linus Torvalds <torvalds@osdl.org>
Cc: linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org
Subject: Re: Oops in ufs_fill_super at mount time
Message-ID: <20060113102136.GA7868@mipter.zuzino.mipt.ru>
References: <20060113005450.GA7971@mipter.zuzino.mipt.ru> <Pine.LNX.4.64.0601121700041.3535@g5.osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.64.0601121700041.3535@g5.osdl.org>
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jan 12, 2006 at 05:14:25PM -0800, Linus Torvalds wrote:
> On Fri, 13 Jan 2006, Alexey Dobriyan wrote:
> >
> > Version 2.6.15-43ecb9a33ba8c93ebbda81d48ca05f0d1bbf9056
> >
> > Actually more or less latest -git is affected too, but
> > I'm sick of recompiling right now so please wait for bisecting results.
>
> Hmm.. I don't see any recent changes that could affect this. Not after
> 2.6.15, but in fact not even after 2.6.14.
>
> Your oops is also interesting in another way...
>
> > Unable to handle kernel paging request at virtual address d734c158
> >  printing eip:
> > c019f138
> > *pde = 0005c067
> > *pte = 1734c000
> > Oops: 0000 [#1]
> > PREEMPT DEBUG_PAGEALLOC
>
> This is a free'd page fault, so it's due to DEBUG_PAGEALLOC rather than a
> wild pointer.

That's true. Turning it off makes mounting reliable again.

> Is that something new for you? Maybe the bug is older, but you've enabled
> PAGEALLOC only recently?

Yup. In response to hangs re disk activity.

> Also, out of interest, have you enabled slab
> debugging?

Yup.

> That said, the whole ubh_get_usb_second() and ubh_get_usb_third() thing is
> pretty damn scary. There's no testing of the values passed in at all and
> comparing them to the allocated buffer heads. But from what I can tell,
> ubh_bread_uspi() will zero out any unallocated bh's, and it certainly
> _looks_ like the calculations to calculate "usb2" should fit within the
> sectors that were read..
>
> Very strange.

