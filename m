Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S292511AbSCDRBp>; Mon, 4 Mar 2002 12:01:45 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S292529AbSCDRBf>; Mon, 4 Mar 2002 12:01:35 -0500
Received: from e21.nc.us.ibm.com ([32.97.136.227]:49912 "EHLO
	e21.nc.us.ibm.com") by vger.kernel.org with ESMTP
	id <S292511AbSCDRBS>; Mon, 4 Mar 2002 12:01:18 -0500
Date: Mon, 04 Mar 2002 08:59:10 -0800
From: "Martin J. Bligh" <Martin.Bligh@us.ibm.com>
To: Rik van Riel <riel@conectiva.com.br>, Andrea Arcangeli <andrea@suse.de>
cc: Daniel Phillips <phillips@bonn-fries.net>,
        Bill Davidsen <davidsen@tmr.com>, Mike Fedyk <mfedyk@matchmail.com>,
        linux-kernel@vger.kernel.org
Subject: Re: 2.4.19pre1aa1
Message-ID: <190330000.1015261149@flay>
In-Reply-To: <Pine.LNX.4.44L.0203041116120.2181-100000@imladris.surriel.com>
In-Reply-To: <Pine.LNX.4.44L.0203041116120.2181-100000@imladris.surriel.com>
X-Mailer: Mulberry/2.1.2 (Linux/x86)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> Not stability per se, but you have to admit the VM tends to
> behave badly when there's a shortage in just one memory zone.
> I believe NUMA will only make this situation worse.

rmap would seem to buy us (at least) two major things for NUMA:

1) We can balance between zones easier by "swapping out"
pages to another zone.

2) We can do local per-node scanning - no need to bounce
information to and fro across the interconnect just to see what's
worth swapping out.

I suspect that the performance of NUMA under memory pressure
without the rmap stuff will be truly horrific, as we decend into 
a cache-trashing page transfer war. 

I can't see any way to fix this without some sort of rmap - any
other suggestions as to how this might be done?

Thanks,

Martin.

