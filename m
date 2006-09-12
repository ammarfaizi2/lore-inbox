Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751377AbWILG4f@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751377AbWILG4f (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 12 Sep 2006 02:56:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751378AbWILG4f
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 12 Sep 2006 02:56:35 -0400
Received: from public.id2-vpn.continvity.gns.novell.com ([195.33.99.129]:8286
	"EHLO emea1-mh.id2.novell.com") by vger.kernel.org with ESMTP
	id S1751377AbWILG4e (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 12 Sep 2006 02:56:34 -0400
Message-Id: <4506767D.76E4.0078.0@novell.com>
X-Mailer: Novell GroupWise Internet Agent 7.0.1 
Date: Tue, 12 Sep 2006 07:57:33 +0100
From: "Jan Beulich" <jbeulich@novell.com>
To: "Andi Kleen" <ak@suse.de>
Cc: "Michael Matz" <matz@suse.de>, "Richard Guenther" <rguenther@suse.de>,
       <linux-kernel@vger.kernel.org>
Subject: Re: [development-gcc] Re: do_exit stuck
References: <200608291332.18499.ak@suse.de> <200608301740.41729.ak@suse.de>
 <45059EEB.76E4.0078.0@novell.com> <200609112217.16811.ak@suse.de>
In-Reply-To: <200609112217.16811.ak@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>Isn't a Kconfig patch missing? I don't see any place that defines 
>CONFIG_AS_CFI_SIGNAL_FRAME. Actually Kconfig wouldn't 
>be very good for this, so auto testing would be preferable
>(like the cfi test is doing) 

Using that framework was the intention (you used a CONFIG_
prefix there, and so did I), but as I wasn't sure about its status,
and as I also was doing this against plain 2.6.18-rc6, I didn't add
the actual detection logic. Actually I also think that should be
done a little differently to allow for better future extension, i.e.
instead of adding to CFLAGS store the auto-detected results in
a header and forcibly -include it.

>BTW the tree you generated it against doesn't seem to match the latest
>tree. I had to fix some rejects.

I didn't create it against your quilt tree, that's true.

>Also it would be nice if you could give a full description that could
>be used as a commit message.

Below.

>Other than that it looks good.
>
>Ok maybe a one liner comment on why UNW_DEFAULT_RA does this magic.

In order to deal with gcc's somewhat broken handling of noreturn
functions (the call instruction in which may be immediately followed
by a subsequent function, thus leading to the call's return address
pointing into that [wrong] function), add heuristics to the unwinder
to distinguish standard call frames from syscall, exception, or
interruption ones. Also provide for utilizing newer gas'
.cfi_signal_frame for non-heuristic based detection, pending
addition of the respective assembler feature detection logic.

Jan
