Return-Path: <linux-kernel-owner+willy=40w.ods.org-S265817AbUGMU2v@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265817AbUGMU2v (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 13 Jul 2004 16:28:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265820AbUGMU2v
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 13 Jul 2004 16:28:51 -0400
Received: from ylpvm29-ext.prodigy.net ([207.115.57.60]:20640 "EHLO
	ylpvm29.prodigy.net") by vger.kernel.org with ESMTP id S265817AbUGMU2t
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 13 Jul 2004 16:28:49 -0400
Message-ID: <40F4457F.2010005@pacbell.net>
Date: Tue, 13 Jul 2004 13:26:39 -0700
From: David Brownell <david-b@pacbell.net>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.2.1) Gecko/20030225
X-Accept-Language: en-us, en, fr
MIME-Version: 1.0
To: Olaf Hering <olh@suse.de>
CC: Gary_Lerhaupt@Dell.com, linux-usb-devel@lists.sourceforge.net,
       linux-kernel@vger.kernel.org, Stuart_Hayes@Dell.com
Subject: Re: [linux-usb-devel] [PATCH] proper bios handoff in ehci-hcd
References: <FD3BA83843210C4BA9E414B0C56A5E5C07DD91@ausx2kmpc104.aus.amer.dell.com> <40CF0049.2010307@pacbell.net> <20040713180727.GA11583@suse.de>
In-Reply-To: <20040713180727.GA11583@suse.de>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Olaf,

Olaf Hering wrote:
> 
> there are 2 reports about breakage by this patch. One is on lkml, and
> another one is in my bugzilla inbox. How can we fix that one? I assume
> that handoff patch is correct.

The only question I have about it right now is whether
it might not be more correct to use a _byte_ access to
set the "Host OS wants controller" flag.  It looks to me
like it does the right thing, per EHCI 1.0 section 5.1,
though maybe 500 msec is too short a period to wait.
See if 5000 msec helps.

The 0x01010001 flag is pretty clearly trouble, and
says that the BIOS hasn't reacted to the request.
Maybe it's polling at some rate slower than 2x/second
on those machines ... or maybe this is just a bios bug.

In this case, one could just look at byte 106 (104 + 2)
of pci config space later to see if it changed after
the 500 msec passed.

- Dave


>   <6>NET: Registered protocol family 17
>   <3>ehci_hcd 0000:00:1d.7: BIOS handoff failed (104, 1010001)
>   <3>ehci_hcd 0000:00:1d.7: can't reset
>   <3>ehci_hcd 0000:00:1d.7: init 0000:00:1d.7 fail, -95
>   <4>ehci_hcd: probe of 0000:00:1d.7 failed with error -95
> 
> this is a FSC Amilo D7830 notebook, the guy on lkml has a  Asus P4P800 board.
> 


