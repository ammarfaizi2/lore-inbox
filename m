Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262345AbTHZStP (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 26 Aug 2003 14:49:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262316AbTHZStP
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 26 Aug 2003 14:49:15 -0400
Received: from fw.osdl.org ([65.172.181.6]:59036 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S262785AbTHZStM (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 26 Aug 2003 14:49:12 -0400
Date: Tue, 26 Aug 2003 11:51:29 -0700
From: Andrew Morton <akpm@osdl.org>
To: "Pallipadi, Venkatesh" <venkatesh.pallipadi@intel.com>
Cc: vojtech@suse.cz, ak@suse.de, haveblue@us.ibm.com, mikpe@csd.uu.se,
       jun.nakajima@intel.com, suresh.b.siddha@intel.com,
       linux-kernel@vger.kernel.org
Subject: Re: [PATCH][2.6][2/5]Support for HPET based timer
Message-Id: <20030826115129.509c4161.akpm@osdl.org>
In-Reply-To: <C8C38546F90ABF408A5961FC01FDBF1902C7D1F8@fmsmsx405.fm.intel.com>
References: <C8C38546F90ABF408A5961FC01FDBF1902C7D1F8@fmsmsx405.fm.intel.com>
X-Mailer: Sylpheed version 0.9.4 (GTK+ 1.2.10; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

"Pallipadi, Venkatesh" <venkatesh.pallipadi@intel.com> wrote:
>
> Problem Description:
>    The requirement from HPET side is, we need to map HPET physical
>  address during timer_init() 
>  routine and also during any read/write HPET addresses. We need to have
>  this mapping kind of
>  permanently, as  we will do HPET reads/writes during every timer
>  interrupt and also during 
>  every gettimeofday (if we don't use tsc timer).
>    And the timer_init() happens before mem_init() (but after paging
>  init()), so we cannot 
>  directly use ioremap(). Current implementation is using a separate
>  fixmap region for HPET.

I doubt if we really need the timer running that early, apart from for
calibrate_delay().

You can probably move the time_init() and calibrate_delay() so they occur
after mem_init().  A close review would be needed to see if that is likely
to break anything.  If it is, then consider creating a new late_time_init()
thing, and call that and calibrate_delay() after mem_init().



