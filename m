Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030819AbWKOSam@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030819AbWKOSam (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 15 Nov 2006 13:30:42 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030821AbWKOSam
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 15 Nov 2006 13:30:42 -0500
Received: from srv5.dvmed.net ([207.36.208.214]:40079 "EHLO mail.dvmed.net")
	by vger.kernel.org with ESMTP id S1030819AbWKOSal (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 15 Nov 2006 13:30:41 -0500
Message-ID: <455B5CCA.6040209@garzik.org>
Date: Wed, 15 Nov 2006 13:30:34 -0500
From: Jeff Garzik <jeff@garzik.org>
User-Agent: Thunderbird 1.5.0.8 (X11/20061107)
MIME-Version: 1.0
To: Linus Torvalds <torvalds@osdl.org>
CC: Roland Dreier <rdreier@cisco.com>, David Miller <davem@davemloft.net>,
       linux-kernel@vger.kernel.org, Takashi Iwai <tiwai@suse.de>
Subject: Re: [PATCH] ALSA: hda-intel - Disable MSI support by default
References: <Pine.LNX.4.64.0611141846190.3349@woody.osdl.org> <20061114.190036.30187059.davem@davemloft.net> <Pine.LNX.4.64.0611141909370.3349@woody.osdl.org> <20061114.192117.112621278.davem@davemloft.net> <Pine.LNX.4.64.0611141935390.3349@woody.osdl.org> <455A938A.4060002@garzik.org> <ada8xidz5zn.fsf@cisco.com> <Pine.LNX.4.64.0611150739110.3349@woody.osdl.org>
In-Reply-To: <Pine.LNX.4.64.0611150739110.3349@woody.osdl.org>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Score: -4.3 (----)
X-Spam-Report: SpamAssassin version 3.1.7 on srv5.dvmed.net summary:
	Content analysis details:   (-4.3 points, 5.0 required)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Linus Torvalds wrote:
> The spec is just so much toilet paper. The ONLY thing that matters is what 
> real hardware does. So please please please PLEASE don't start quoting 
> specs as a way to "prove your point". It is totally meaningless.

Amen.


> End result: I think that at least for 2.6.19, and at least for the HDA 
> sound driver, keeping it disabled by default is the right choice. We 
> should probably _also_ make "pci_msi_supported()" just return an error 
> (probably by just clearing "pci_msi_enable") for any non-intel host bridge 
> for now.

If you update, pci_msi_{enable,supported} then you can -- and should -- 
revert the HD-audio driver change.  Just reviewed the driver, and it 
properly checks all the return values from PCI MSI API functions.

(though, HD-audio shouldn't be using IRQF_DISABLED at all, and shouldn't 
be using IRQF_SHARED for PCI MSI interrupts)

Though maybe for 2.6.19 the current state of things is at least a stable 
state.

	Jeff


