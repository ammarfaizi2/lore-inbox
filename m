Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261699AbUKGWlK@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261699AbUKGWlK (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 7 Nov 2004 17:41:10 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261701AbUKGWlK
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 7 Nov 2004 17:41:10 -0500
Received: from fw.osdl.org ([65.172.181.6]:37255 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S261699AbUKGWlG (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 7 Nov 2004 17:41:06 -0500
Date: Sun, 7 Nov 2004 14:41:02 -0800 (PST)
From: Linus Torvalds <torvalds@osdl.org>
To: Matt Domsch <Matt_Domsch@dell.com>
cc: greg@kroah.com, linux-kernel@vger.kernel.org
Subject: Re: EFI partition code broken..
In-Reply-To: <20041107215204.GB3169@lists.us.dell.com>
Message-ID: <Pine.LNX.4.58.0411071434240.24286@ppc970.osdl.org>
References: <Pine.LNX.4.58.0411070959560.2223@ppc970.osdl.org>
 <Pine.LNX.4.58.0411071128240.24286@ppc970.osdl.org> <20041107215204.GB3169@lists.us.dell.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Sun, 7 Nov 2004, Matt Domsch wrote:
>
> Another train of thought, and copying gregkh for inspiration.  Is there
> any way to know which devices lie about their size, and fix that with
> quirk code in the device discovery routines?

The USB layer actually has some quirks like this, but I think that's a 
bug waiting to happen.

The thing is, if you start doing quirks, you _are_ screwed in the end.  
Don't do it. It's not just a maintenance nightmare, it's fundamentally
wrong. It fundamentally takes the approach of "you have to have a kernel
that is two years newer than the hardware you have", which is an approach 
that I just find incredibly broken.

Quirks work slightly better in practice for stuff that seldom changes,
and/or where we have fairly good vendor support. So CPU's, for example,
are largely ok with quirks (aka "errata"). But random regular devices?  
Please no.

Side note: the USB storage stuff has historically had tons of quirks,
largely because the SCSI layer used to do crap-all to try to be sane. The
SCSI layer historically only cared about high-end devices, and then the
USB storage model clashed pretty hard with the old SCSI layer belief that
standards are something that people follow etc.

Happily, most of those quirks are hopefully stale these days, because the
SCSI layer has been slowly converted to the idea that you don't use every
documented feature under the sun just because it exists.

So I'm trying to make for _fewer_ quirks rather than more of them.

		Linus
