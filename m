Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261608AbULTSsm@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261608AbULTSsm (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 20 Dec 2004 13:48:42 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261610AbULTSsl
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 20 Dec 2004 13:48:41 -0500
Received: from e32.co.us.ibm.com ([32.97.110.130]:65518 "EHLO
	e32.co.us.ibm.com") by vger.kernel.org with ESMTP id S261608AbULTSsj
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 20 Dec 2004 13:48:39 -0500
Date: Mon, 20 Dec 2004 10:48:14 -0800
From: Greg KH <greg@kroah.com>
To: Lukas Hejtmanek <xhejtman@mail.muni.cz>,
       David Brownell <david-b@pacbell.net>
Cc: linux-kernel@vger.kernel.org, linux-usb-devel@lists.sourceforge.net
Subject: Re: Scheduling while atomic (2.6.10-rc3-bk13)
Message-ID: <20041220184814.GA21215@kroah.com>
References: <20041219231015.GB4166@mail.muni.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20041219231015.GB4166@mail.muni.cz>
User-Agent: Mutt/1.5.6i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Dec 20, 2004 at 12:10:15AM +0100, Lukas Hejtmanek wrote:
> Hello,
> 
> when suspending to disk I got:
> scheduling while atomic: suspenddisk.sh/0x00000001/1452
> [<c031dc81>] schedule+0x4b3/0x563
> [<c031e170>] schedule_timeout+0x5d/0xab
> [<c011e9e5>] process_timeout+0x0/0x9
> [<c011edbd>] msleep+0x2c/0x34
> [<df8303cb>] ehci_hub_resume+0xed/0x1de [ehci_hcd]
> [<c025885f>] usb_resume_device+0x80/0xc7
> [<c021dc2e>] dpm_resume+0xa2/0xa4
> [<c021dc41>] device_resume+0x11/0x1e
> [<c0130485>] finish+0x8/0x3a
> [<c013058e>] pm_suspend_disk+0x3e/0x73
> [<c012ecfa>] enter_state+0x6e/0x72
> [<c012ee18>] state_store+0xa4/0xb7
> [<c0184441>] subsys_attr_store+0x34/0x3d
> [<c01846c0>] flush_write_buffer+0x3e/0x4a
> [<c018473b>] sysfs_write_file+0x6f/0x7e
> [<c01846cc>] sysfs_write_file+0x0/0x7e
> [<c01504ec>] vfs_write+0xf4/0x12f
> [<c014fa31>] filp_close+0x52/0x96
> [<c01505f8>] sys_write+0x51/0x80
> [<c010306f>] syscall_call+0x7/0xb

David, it looks like you grab a spinlock, and then call msleep(20);
which causes this warning.

Care to fix it?

thanks,

greg k-h
