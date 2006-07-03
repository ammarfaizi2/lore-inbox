Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932082AbWGCXYm@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932082AbWGCXYm (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 3 Jul 2006 19:24:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932091AbWGCXYl
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 3 Jul 2006 19:24:41 -0400
Received: from mail.suse.de ([195.135.220.2]:2958 "EHLO mx1.suse.de")
	by vger.kernel.org with ESMTP id S932082AbWGCXYl (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 3 Jul 2006 19:24:41 -0400
Date: Mon, 3 Jul 2006 16:21:09 -0700
From: Greg KH <gregkh@suse.de>
To: Lukas Hejtmanek <xhejtman@mail.muni.cz>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Linux kernel 2.6.17-git14 and PCI suspend/resume
Message-ID: <20060703232109.GA18605@suse.de>
References: <20060703231121.GB2752@mail.muni.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060703231121.GB2752@mail.muni.cz>
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jul 04, 2006 at 01:11:21AM +0200, Lukas Hejtmanek wrote:
> Hello,
> 
> in this kernel I'm seeing these messages after S3 resume:
> kernel: PM: Writing back config space on device 0000:01:01.1 at offset f (was 4020205, writing ffffffff)
> kernel: PM: Writing back config space on device 0000:01:01.1 at offset e (was 0, writing ffffffff)
> kernel: PM: Writing back config space on device 0000:01:01.1 at offset d (was dc, writing ffffffff)
> kernel: PM: Writing back config space on device 0000:01:01.1 at offset c (was 0, writing ffffffff)
> kernel: PM: Writing back config space on device 0000:01:01.1 at offset b (was 19671043, writing ffffffff)
> kernel: PM: Writing back config space on device 0000:01:01.1 at offset a (was 0, writing ffffffff)
> kernel: PM: Writing back config space on device 0000:01:01.1 at offset 9 (was 0, writing ffffffff)
> kernel: PM: Writing back config space on device 0000:01:01.1 at offset 8 (was 0, writing ffffffff)
> kernel: PM: Writing back config space on device 0000:01:01.1 at offset 7 (was 0, writing ffffffff)
> kernel: PM: Writing back config space on device 0000:01:01.1 at offset 6 (was 0, writing ffffffff)
> kernel: PM: Writing back config space on device 0000:01:01.1 at offset 5 (was 0, writing ffffffff)
> kernel: PM: Writing back config space on device 0000:01:01.1 at offset 4 (was fe8fd800, writing ffffffff)
> kernel: PM: Writing back config space on device 0000:01:01.1 at offset 3 (was 804000, writing ffffffff)
> kernel: PM: Writing back config space on device 0000:01:01.1 at offset 2 (was c001008, writing ffffffff)
> kernel: PM: Writing back config space on device 0000:01:01.1 at offset 1 (was 2100006, writing ffffffff)
> kernel: PM: Writing back config space on device 0000:01:01.1 at offset 0 (was 5521180, writing ffffffff)
> 
> Which actually mess up PCI config space (and sdhci driver is unable to set up
> MMC device correctly). Do you have any idea what to try?

When suspending, pci_save_state() would have saved off those values (all
1s) which is what it is restoring.  That function gets called if there
is no driver specific suspend function to call.  On suspend, is there
any driver loaded for the device?

And what type of PCI device is this?

> These messages appear for devices that are not handled by any loaded module.

Ick.

Any chance you can test -mm and see if that helps with suspend/resume?
Linus's new suspend framework is in there, and that's the way forward
for these kinds of issues.

thanks,

greg k-h
