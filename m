Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264082AbTEaALw (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 30 May 2003 20:11:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264083AbTEaALv
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 30 May 2003 20:11:51 -0400
Received: from franka.aracnet.com ([216.99.193.44]:45254 "EHLO
	franka.aracnet.com") by vger.kernel.org with ESMTP id S264082AbTEaALv
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 30 May 2003 20:11:51 -0400
Date: Fri, 30 May 2003 16:51:25 -0700
From: "Martin J. Bligh" <mbligh@aracnet.com>
To: Andrew Morton <akpm@digeo.com>
cc: linux-kernel@vger.kernel.org, linux-mm@kvack.org
Subject: Re: 2.5.70-mm1
Message-ID: <32370000.1054338684@[10.10.2.4]>
In-Reply-To: <20030530094344.74a0e617.akpm@digeo.com>
References: <20030527004255.5e32297b.akpm@digeo.com><1980000.1054189401@[10.10.2.4]><18080000.1054233607@[10.10.2.4]><20030529115237.33c9c09a.akpm@digeo.com><39810000.1054240214@[10.10.2.4]><20030529141405.4578b72c.akpm@digeo.com><12430000.1054309916@[10.10.2.4]> <20030530094344.74a0e617.akpm@digeo.com>
X-Mailer: Mulberry/2.2.1 (Linux/x86)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>> Well, that just seems to make the box hang in SDET (actually, moving it
>>  outside lock_kernel makes it hang in a similar way). Not sure it's 
>>  *caused* by this ... it might just change timing enough to trigger it.
> 
> Yes, sorry.  Looks like you hit the filemap.c screwup.  The below should
> fix it.

OK, seems to work now, but it's still no faster:

SDET 128  (see disclaimer)
                           Throughput    Std. Dev
          2.5.70-mm1-ext2       100.0%         0.1%
          2.5.70-mm1-ext3        22.7%         2.0%
          2.5.70-mm1-noxa        21.4%         4.6%
          2.5.70-mm2-ext3        20.5%         2.4%

(last one has both your patches in).

I had the sem tracing one in there too, but got no output. I might have
another look at that later on ...

M.

