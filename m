Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1163536AbWLGWof@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1163536AbWLGWof (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 7 Dec 2006 17:44:35 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1163548AbWLGWof
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 7 Dec 2006 17:44:35 -0500
Received: from smtp.osdl.org ([65.172.181.25]:49084 "EHLO smtp.osdl.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1163536AbWLGWoe (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 7 Dec 2006 17:44:34 -0500
Date: Thu, 7 Dec 2006 14:44:23 -0800 (PST)
From: Linus Torvalds <torvalds@osdl.org>
To: Daniel Barkalow <barkalow@iabervon.org>
cc: gregkh@suse.de, Jeff Garzik <jeff@garzik.org>,
       linux-kernel@vger.kernel.org
Subject: Re: Disable INTx when enabling MSI
In-Reply-To: <Pine.LNX.4.64.0612071659010.20138@iabervon.org>
Message-ID: <Pine.LNX.4.64.0612071440480.3615@woody.osdl.org>
References: <Pine.LNX.4.64.0612071659010.20138@iabervon.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Thu, 7 Dec 2006, Daniel Barkalow wrote:
>
> Jeff proposed a patch in http://lkml.org/lkml/2006/11/21/332 when Linus 
> wanted to do it in the PCI layer, but nobody seems to have told the actual 
> PCI maintainer.

I got a patch from Jeff, but it was marked as totally untested, and wasn't 
even signed-off, so I asked for that to be fixed, and never heard back.

If somebody sends me the patch that disables INTx when MSI is enabled, 
with testing, and saying "I verified that this fixed it for me", I will 
happily apply it.

NOTE: _I_ want the one that is PCI-wide. No per-driver stuff, please. I'm 
of the opinion that any hardware that supports MSI but doesn't support 
INTx_DISABLE from PCI-2.3 (or at least do it automatically and ignore the 
bit in the config word) should just not use MSI at all. Such hardware is 
simply broken (and nobody has actually pointed to an example of that 
existing in the real world, so we really most likely will never care about 
the theoretical situation about something that might react badly to 
having MSI enable automatically disable INTx).

		Linus
