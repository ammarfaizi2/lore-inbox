Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S319831AbSIMXsF>; Fri, 13 Sep 2002 19:48:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S319832AbSIMXsF>; Fri, 13 Sep 2002 19:48:05 -0400
Received: from holomorphy.com ([66.224.33.161]:39893 "EHLO holomorphy")
	by vger.kernel.org with ESMTP id <S319831AbSIMXsE>;
	Fri, 13 Sep 2002 19:48:04 -0400
Date: Fri, 13 Sep 2002 16:46:53 -0700
From: William Lee Irwin III <wli@holomorphy.com>
To: Dave Hansen <haveblue@us.ibm.com>
Cc: Andrew Morton <akpm@digeo.com>, colpatch@us.ibm.com,
       "Martin J. Bligh" <mbligh@aracnet.com>,
       Michael Hohnbaum <hohnbaum@us.ibm.com>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] per-zone^Wnode kswapd process
Message-ID: <20020913234653.GF3530@holomorphy.com>
Mail-Followup-To: William Lee Irwin III <wli@holomorphy.com>,
	Dave Hansen <haveblue@us.ibm.com>, Andrew Morton <akpm@digeo.com>,
	colpatch@us.ibm.com, "Martin J. Bligh" <mbligh@aracnet.com>,
	Michael Hohnbaum <hohnbaum@us.ibm.com>,
	linux-kernel@vger.kernel.org
References: <20020913045938.GG2179@holomorphy.com> <617478427.1031868636@[10.10.2.3]> <3D8232DE.9090000@us.ibm.com> <3D823702.8E29AB4F@digeo.com> <3D8251D6.3060704@us.ibm.com> <3D82566B.EB2939D5@digeo.com> <3D826C25.5050609@us.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Description: brief message
Content-Disposition: inline
In-Reply-To: <3D826C25.5050609@us.ibm.com>
User-Agent: Mutt/1.3.25i
Organization: The Domain of Holomorphy
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Sep 13, 2002 at 03:52:21PM -0700, Dave Hansen wrote:
> Here's a per-node kswapd.  It's actually per-pg_data_t, but I guess that 
> they're equivalent.  Matt is going to follow up his topology API with 
> something to bind these to their respective nodes.

>From 64 parallel tiobench 64's (higher counts livelock in fork() etc.):

   38 root      15   0     0    0     0 RW   23.0  0.0   1:11 kswapd0
 4779 wli       22   0  4460 3588  1648 R    17.9  0.0   0:16 top

...

 4779 wli       25   0  4460 3592  1648 R    14.1  0.0   0:27 top
   38 root      15   0     0    0     0 DW    3.5  0.0   1:31 kswapd0

...

OTOH, with such a small task count, ZONE_NORMAL is the only thing
feeling pressure anyway. There's also very little cpu pressure:
CPU states:   0.2% user,   6.4% system,   0.0% nice,  93.4% idle

Cheers,
Bill
