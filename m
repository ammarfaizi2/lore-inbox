Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267176AbTAFV2f>; Mon, 6 Jan 2003 16:28:35 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267178AbTAFV2f>; Mon, 6 Jan 2003 16:28:35 -0500
Received: from packet.digeo.com ([12.110.80.53]:53480 "EHLO packet.digeo.com")
	by vger.kernel.org with ESMTP id <S267176AbTAFV23>;
	Mon, 6 Jan 2003 16:28:29 -0500
Message-ID: <3E19F667.30043A97@digeo.com>
Date: Mon, 06 Jan 2003 13:34:31 -0800
From: Andrew Morton <akpm@digeo.com>
X-Mailer: Mozilla 4.79 [en] (X11; U; Linux 2.5.51 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Dominik Brodowski <linux@brodo.de>
CC: torvalds@transmeta.com, linux-kernel@vger.kernel.org,
       cpufreq@www.linux.org.uk
Subject: Re: [PATCH 2.5.54] cpufreq: update timer notifier
References: <20030106135521.GC1307@brodo.de>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-OriginalArrivalTime: 06 Jan 2003 21:34:31.0942 (UTC) FILETIME=[6651CA60:01C2B5CB]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Dominik Brodowski wrote:
> 
> +#else
> +#define adjust_jiffies(...)
> +#endif

This will fail to compile on gcc-2.91.66.  It's OK on 2.95.3.

sparc64 requires a compiler of similar vintage (2.92.11), so
I am trying to keep 2.91.66-on-x86 limping along so that breakage
can be detected more easily.

Please use

	#define adjust_jiffies(x...) do {} while (0)

here.   Or an empty inline, which tends to be nicer, because you
still get argument type checking.
