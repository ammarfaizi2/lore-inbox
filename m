Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265646AbUBFS2r (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 6 Feb 2004 13:28:47 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265677AbUBFS2r
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 6 Feb 2004 13:28:47 -0500
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:10210 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id S265646AbUBFS2p
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 6 Feb 2004 13:28:45 -0500
Date: Fri, 6 Feb 2004 18:28:44 +0000
From: viro@parcelfarce.linux.theplanet.co.uk
To: walt <wa1ter@myrealbox.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [2.6.1] Kernel panic with ppa driver updates
Message-ID: <20040206182844.GJ21151@parcelfarce.linux.theplanet.co.uk>
References: <4023D098.1000904@myrealbox.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <4023D098.1000904@myrealbox.com>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Feb 06, 2004 at 09:36:24AM -0800, walt wrote:
> This panic started with the bk changesets applied by Linus yesterday.
> 
> The ppa driver works fine when compiled as a module, but when compiled in
> I get this during boot:

> ppa_pb_claim+0x7b/0x80
> __ppa_attach+0x137/0x350
> ppa_wakeup+0x0/0x70
> autoremove_wake_function+0x0/0x50 [this line appears twice]
> parport_register_driver+0x36/0x70
> ppa_driver_init+0x23/0x30
> do_initcalls+0x2c/0xa0
> init_workquese+0xf/0x30
> init+0x32/0x140
> init+0x0/0x140
> kernel_thread_helper+0x5/0xc
> 
> Code: c7 80 24 01 00 00 01 00 00 c3 8b 42 50 b9 01 00 00 00 ba
> <0>Kernel panic: attempted to kill init!

Very interesting.  So it works as a module (== finds disks and handles them
OK) and dies when it's built-in?

Could you post the actual oops?  The fun thing being, we are obviously past
the initialization of parport layer (otherwise ->attach() would not be called
at all), so init order problems should not be an issue.  And seeing that
there's no module-specific code in ppa...
