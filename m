Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932517AbWF0LQp@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932517AbWF0LQp (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 27 Jun 2006 07:16:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S933405AbWF0LQp
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 27 Jun 2006 07:16:45 -0400
Received: from hp3.statik.TU-Cottbus.De ([141.43.120.68]:38017 "EHLO
	hp3.statik.tu-cottbus.de") by vger.kernel.org with ESMTP
	id S932517AbWF0LQo (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 27 Jun 2006 07:16:44 -0400
Message-ID: <44A112F8.50104@s5r6.in-berlin.de>
Date: Tue, 27 Jun 2006 13:14:00 +0200
From: Stefan Richter <stefanr@s5r6.in-berlin.de>
User-Agent: Mozilla/5.0 (Windows; U; Windows NT 5.0; en-US; rv:1.7.12) Gecko/20050915
X-Accept-Language: de, en
MIME-Version: 1.0
To: Andi Kleen <ak@suse.de>
CC: Andrew Morton <akpm@osdl.org>, linux1394-devel@lists.sourceforge.net,
       linux-kernel@vger.kernel.org
Subject: x86_64-mm-ieee1394-early.patch  (was Re: 2.6.17-mm3)
References: <20060627015211.ce480da6.akpm@osdl.org>
In-Reply-To: <20060627015211.ce480da6.akpm@osdl.org>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andrew Morton wrote:
> +x86_64-mm-ieee1394-early.patch
> 
>  x86_64 tree update

>From the patch:
|| Initialize ieee1394 early when built in
||
|| This makes debugging with firescope easier.
||
|| Cc: linux1394-devel@lists.sourceforge.net
||
|| Signed-off-by: Andi Kleen <ak@suse.de>
...
|| +++ linux/drivers/ieee1394/ieee1394_core.c
...
|| +#ifndef MODULE
|| +fs_initcall(ieee1394_init);
|| +#else
||  module_init(ieee1394_init);
|| +#endif
...
|| +++ linux/drivers/ieee1394/ohci1394.c
...
|| +/* Try to register 1394 early to get the DMA engine running for
debugging purposes */
|| +#ifndef MODULE
|| +fs_initcall(ohci1394_init);
|| +#else
||  module_init(ohci1394_init);
|| +#endif
...

Perhaps it doesn't matter, but shouldn't it rather be a
subsys_initcall(ieee1394_init)?

[fs_initcall(ohci1394_init) instead of device_initcall(ohci1394_init) is
certainly appropriate if you want to have it up and running before other
device drivers.]

Also, I suggest an 80 columns friendly comment:
/* Register early.  Useful for remote debugging via physical DMA */
-- 
Stefan Richter
-=====-=-==- -==- ==-=-
http://arcgraph.de/sr/
