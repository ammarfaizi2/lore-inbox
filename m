Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S266854AbTAIUJw>; Thu, 9 Jan 2003 15:09:52 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S266982AbTAIUJv>; Thu, 9 Jan 2003 15:09:51 -0500
Received: from packet.digeo.com ([12.110.80.53]:16091 "EHLO packet.digeo.com")
	by vger.kernel.org with ESMTP id <S266854AbTAIUJv>;
	Thu, 9 Jan 2003 15:09:51 -0500
Message-ID: <3E1DD913.2571469F@digeo.com>
Date: Thu, 09 Jan 2003 12:18:27 -0800
From: Andrew Morton <akpm@digeo.com>
X-Mailer: Mozilla 4.79 [en] (X11; U; Linux 2.5.51 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Chris Wood <cwood@xmission.com>,
       William Lee Irwin III <wli@holomorphy.com>
CC: linux-kernel@vger.kernel.org
Subject: Re: 2.4.20, .text.lock.swap cpu usage? (ibm x440)
References: <3E1A12B5.4020505@xmission.com> <3E1A16C5.87EDE35A@digeo.com> <3E1DAEAC.4060904@xmission.com>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-OriginalArrivalTime: 09 Jan 2003 20:18:27.0845 (UTC) FILETIME=[45251B50:01C2B81C]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Chris Wood wrote:
> 
> ..
> The server ran fine for 3 days, so it took a bit to get this info.

Is appreciated, thanks.
 
> Is there a list of which patches I can apply if I don't want to apply
> the entire 2.4.20aa1?  I'm nervous about breaking other things, but may
> give it a try anyway.

http://www.kernel.org/pub/linux/kernel/people/andrea/kernels/v2.4/2.4.20aa1/05_vm_16_active_free_zone_bhs-1
http://www.kernel.org/pub/linux/kernel/people/andrea/kernels/v2.4/2.4.20aa1/10_inode-highmem-2

The former is the most important and, alas, has dependencies on
earlier patches.

hm, OK.  I've pulled all Andrea's VM changes and the inode-highmem fix
into a standalone diff.  I'll beat on that a bit tonight before unleashing
it.

> Thanks for the help!
> 
> Here is a /proc/meminfo when it is running fine:

These numbers are a little odd.  You seem to have only lost 200M of
lowmem to buffer_heads.  Bill, what's your take on this?

Maybe we're looking at the wrong thing.  Are any of your applications
using mlock(), mlockall(), etc?
