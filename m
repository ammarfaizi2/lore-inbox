Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268008AbUHEWbh@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268008AbUHEWbh (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 5 Aug 2004 18:31:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268004AbUHEWaI
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 5 Aug 2004 18:30:08 -0400
Received: from zero.aec.at ([193.170.194.10]:26628 "EHLO zero.aec.at")
	by vger.kernel.org with ESMTP id S268000AbUHEW3A (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 5 Aug 2004 18:29:00 -0400
To: "Michael Chan" <mchan@broadcom.com>
cc: linux-kernel@vger.kernel.org
Subject: Re: MMCONFIG violates pci power mgmt spec
References: <2pYrs-17y-31@gated-at.bofh.it>
From: Andi Kleen <ak@muc.de>
Date: Fri, 06 Aug 2004 00:28:55 +0200
In-Reply-To: <2pYrs-17y-31@gated-at.bofh.it> (Michael Chan's message of
 "Fri, 06 Aug 2004 00:00:14 +0200")
Message-ID: <m3brhp8biw.fsf@averell.firstfloor.org>
User-Agent: Gnus/5.110003 (No Gnus v0.3) Emacs/21.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

"Michael Chan" <mchan@broadcom.com> writes:

> For example, if the device is transitioning into or out of D3hot, the
> spec requires a delay of 10 msec before any accesses can be made to the
> device. The dummy read in pci_mmcfg_write violates the delay
> requirements even though pci_set_power_state has all the necessary
> delays.

Interesting. What happens? Hangs? 

>
> I have contacted "Durairaj, Sundarapandian
> <sundarapandian.durairaj@intel.com>" but did not get a response, and so
> I'm posting to this list. One question I wanted to ask him was whether
> the dummy read was necessary. If the Intel chipset treats the mmconfig
> write as a non-posted write, the dummy read becomes unnecessary and
> removing it will solve the problem. If it is treated as a posted write,

This was added to keep the new access method to be as compatible
as possible to the old method (which never posts). 

If someone cites the spec that says that it is not allowed I guess
it could be removed.

In the worst case we could add a new pci_read_config_*_relaxed() 
or somesuch.

> I wonder if there is another way to flush it other than reading from the
> target device.

Reading is the official way to flush.

-Andi

