Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S272362AbTHEAMR (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 4 Aug 2003 20:12:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S272363AbTHEAMR
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 4 Aug 2003 20:12:17 -0400
Received: from zero.aec.at ([193.170.194.10]:15377 "EHLO zero.aec.at")
	by vger.kernel.org with ESMTP id S272362AbTHEAML (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 4 Aug 2003 20:12:11 -0400
To: "Simon Garner" <sgarner@expio.co.nz>
Cc: linux-kernel@vger.kernel.org
Subject: Re: MSI K8D-Master - GART error 3
From: Andi Kleen <ak@muc.de>
Date: Tue, 05 Aug 2003 02:11:39 +0200
In-Reply-To: <gC1o.2gU.5@gated-at.bofh.it> ("Simon Garner"'s message of
 "Mon, 04 Aug 2003 03:10:06 +0200")
Message-ID: <m3k79t7ykk.fsf@averell.firstfloor.org>
User-Agent: Gnus/5.090013 (Oort Gnus v0.13) Emacs/21.2 (i586-suse-linux)
References: <gC1o.2gU.5@gated-at.bofh.it>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

"Simon Garner" <sgarner@expio.co.nz> writes:

> Aug  4 12:52:41 terra kernel: Northbridge status 9405c00000000a13
> Aug  4 12:52:41 terra kernel: GART error 3

There is nothing in any of my trees that generates such a message.
If it was GART related  it would be either "GART TLB error ..." or 
"extended error gart error". But even that should not happen anymore, 
see below.

I don't know what the RedHat kernel does, they may have changed the MCE
handler over the reference port.

> The system also has an Adaptec 2120S scsi raid card.

Probably the driver is doing something bad with the pci_dma API
(which uses the GART on x86-64)

You can always disable it with mce=off or better mce=0 
as the message seems to be caused by the periodic non fatal MCE check timer.

However there was a bug in the MCE handler where it managed to turn on
an GART related MCE event through the backdoor that doesn't work
correctly and is sometimes raised spuriously. But at least in the SuSE
beta9 kernel or recent x86-64.org kernels this should have been
fixed. But it doesn't generate such a error message anyways,
so it's hard to know what the exact cause is.

I would suggest to retry with a recent x86-64.org CVS kernel and see
if it still happens there.

-Andi
