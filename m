Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262965AbVG3Nuy@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262965AbVG3Nuy (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 30 Jul 2005 09:50:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262966AbVG3Nux
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 30 Jul 2005 09:50:53 -0400
Received: from dvhart.com ([64.146.134.43]:37306 "EHLO localhost.localdomain")
	by vger.kernel.org with ESMTP id S262965AbVG3Ntn (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 30 Jul 2005 09:49:43 -0400
Date: Sat, 30 Jul 2005 06:49:44 -0700
From: "Martin J. Bligh" <mbligh@mbligh.org>
Reply-To: "Martin J. Bligh" <mbligh@mbligh.org>
To: Andrew Morton <akpm@osdl.org>
Cc: linux-kernel@vger.kernel.org, colpatch@us.ibm.com
Subject: Re: [PATCH] Fix NUMA node sizing in nr_free_zone_pages
Message-ID: <259590000.1122731383@[10.10.2.4]>
In-Reply-To: <20050729224043.7ce56d4e.akpm@osdl.org>
References: <240970000.1122661910@[10.10.2.4]> <20050729224043.7ce56d4e.akpm@osdl.org>
X-Mailer: Mulberry/2.2.1 (Linux/x86)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>> We are iterating over all nodes in nr_free_zone_pages(). Because the 
>>  fallback zonelists contain all nodes in the system, and we walk all
>>  the zonelists, we're counting memory multiple times (once for each
>>  node). This caused us to make a size estimate of 32GB for an 8GB
>>  AMD64 box, which makes all the dirty ratio calculations, etc incorrect.
>> 
>>  There's still a further bug to fix from e820 holes causing overestimation
>>  as well, but this fix is separate, and good as is, and fixes one class
>>  of problems. Problem found by Badari, and tested by Ram Pai - thanks!
> 
> Alas my non-NUMA EMT64 box still gets it wrong.
> 
> nr_free_pagecache_pages() is still returning 1572864 on a 4G box.

Yeah, it will do - is the e820 bug I mentioned above. Patch is half-written,
will finish it off ASAP, but I'll be out today ;-(

M.

