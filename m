Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262591AbTHZTz7 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 26 Aug 2003 15:55:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262667AbTHZTz6
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 26 Aug 2003 15:55:58 -0400
Received: from fw.osdl.org ([65.172.181.6]:50631 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S262591AbTHZTz4 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 26 Aug 2003 15:55:56 -0400
Date: Tue, 26 Aug 2003 11:55:53 -0700
From: Andrew Morton <akpm@osdl.org>
To: venkatesh.pallipadi@intel.com, vojtech@suse.cz, ak@suse.de,
       haveblue@us.ibm.com, mikpe@csd.uu.se, jun.nakajima@intel.com,
       suresh.b.siddha@intel.com, linux-kernel@vger.kernel.org
Subject: Re: [PATCH][2.6][2/5]Support for HPET based timer
Message-Id: <20030826115553.7f8b3285.akpm@osdl.org>
In-Reply-To: <20030826115129.509c4161.akpm@osdl.org>
References: <C8C38546F90ABF408A5961FC01FDBF1902C7D1F8@fmsmsx405.fm.intel.com>
	<20030826115129.509c4161.akpm@osdl.org>
X-Mailer: Sylpheed version 0.9.4 (GTK+ 1.2.10; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andrew Morton <akpm@osdl.org> wrote:
>
> I doubt if we really need the timer running that early, apart from for
>  calibrate_delay().
> 
>  You can probably move the time_init() and calibrate_delay() so they occur
>  after mem_init().  A close review would be needed to see if that is likely
>  to break anything.  If it is, then consider creating a new late_time_init()
>  thing, and call that and calibrate_delay() after mem_init().
> 

Actually, I think some platforms (ppc64) will explode if we do the
local_irq_enable() prior to time_init().

So I suggest you look at the latter option:

- change time_init() so that it doesn't actually touch the HPET hardware
  in the HPET timer case.

- add late_time_init() after mem_init().

- then do calibrate_delay().

Or whatever.  The bottom line is that init/main.c is fragile, but not
inviolable ;)


