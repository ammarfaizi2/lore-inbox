Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965051AbWIKVSf@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965051AbWIKVSf (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 11 Sep 2006 17:18:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965052AbWIKVSf
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 11 Sep 2006 17:18:35 -0400
Received: from mx2.suse.de ([195.135.220.15]:26325 "EHLO mx2.suse.de")
	by vger.kernel.org with ESMTP id S965051AbWIKVSd (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 11 Sep 2006 17:18:33 -0400
From: Andi Kleen <ak@suse.de>
To: "Jan Beulich" <jbeulich@novell.com>
Subject: Re: [development-gcc] Re: do_exit stuck
Date: Mon, 11 Sep 2006 22:17:16 +0200
User-Agent: KMail/1.9.1
Cc: "Michael Matz" <matz@suse.de>, "Richard Guenther" <rguenther@suse.de>,
       linux-kernel@vger.kernel.org
References: <200608291332.18499.ak@suse.de> <200608301740.41729.ak@suse.de> <45059EEB.76E4.0078.0@novell.com>
In-Reply-To: <45059EEB.76E4.0078.0@novell.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200609112217.16811.ak@suse.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Monday 11 September 2006 17:37, Jan Beulich wrote:
> >>> Andi Kleen <ak@suse.de> 30.08.06 17:40 >>>
> >
> >On Wednesday 30 August 2006 17:28, Jan Beulich wrote:
> >> >Hmm, yes.  Sigh, so it's either gcc changes or binutils changes, and
> >> > none of that can be relied upon, except someone has a better idea to
> >> > identify signal frames with high enough assurance to be sensible for
> >> > debugging.
> >>
> >> The only alternative idea I have is to take into consideration the
> >> location of the return address: if it's at the default location (top of
> >> call frame), then assume this is a normal frame, in all other cases
> >> assume it's an interrupt/exception one. This will probably get a few
> >> cases wrong (where the return address is being played with), but it
> >> might be better than the current situation. Andi?
> >
> >Fine by me.
> >
> >At least it will likely be less controversal than changing all the
> > noreturns :)
>
> Here's a patch, including all that I think is necessary once we selectively
> enable (auto-detect) CONFIG_AS_CFI_SIGNAL_FRAME for newer binutils.
> It doesn't include adjustment of the printed address (i.e. for the original
> example, it'd still be kernel_math_error+0 that gets displayed, but the
> unwinder wouldn't get confused anymore.

Thanks.

Isn't a Kconfig patch missing? I don't see any place that defines 
CONFIG_AS_CFI_SIGNAL_FRAME. Actually Kconfig wouldn't 
be very good for this, so auto testing would be preferable
(like the cfi test is doing) 

BTW the tree you generated it against doesn't seem to match the latest
tree. I had to fix some rejects.

Also it would be nice if you could give a full description that could
be used as a commit message.

Other than that it looks good.

Ok maybe a one liner comment on why UNW_DEFAULT_RA does this magic.

-Andi
