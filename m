Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261270AbVAaRZi@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261270AbVAaRZi (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 31 Jan 2005 12:25:38 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261271AbVAaRZh
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 31 Jan 2005 12:25:37 -0500
Received: from dgate2.fujitsu-siemens.com ([217.115.66.36]:29987 "EHLO
	dgate2.fujitsu-siemens.com") by vger.kernel.org with ESMTP
	id S261270AbVAaRZ0 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 31 Jan 2005 12:25:26 -0500
X-SBRSScore: None
X-IronPort-AV: i="3.88,167,1102287600"; 
   d="scan'208"; a="2812416:sNHT22390292"
Message-ID: <41FE6A03.6010402@fujitsu-siemens.com>
Date: Mon, 31 Jan 2005 18:25:23 +0100
From: Martin Wilck <martin.wilck@fujitsu-siemens.com>
Organization: Fujitsu Siemens Computers
User-Agent: Mozilla Thunderbird 0.5 (X11/20040208)
X-Accept-Language: de, en-us, en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: Re: [Discuss][i386] Platform SMIs and their interferance with tsc
 based delay calibration
References: <3rR0g-3aR-11@gated-at.bofh.it>
In-Reply-To: <3rR0g-3aR-11@gated-at.bofh.it>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Venkatesh Pallipadi wrote:

> (0) Estimate a value for loops_per_jiffy
> (1) While (loops_per_jiffy estimate is accurate enough)
> (2)   wait for jiffy transition (jiffy1)
> (3)   Note down current tsc (tsc1)
> (4)   loop until tsc becomes tsc1 + loops_per_jiffy
> (5)   check whether jiffy changed since jiffy1 or not 
 > and refine loops_per_jiffy estimate

> 
> Case 2: If SMIs happen between (3) and (4) above, then we can end up
> with a loops_per_jiffy value that is too high.

I don't think this can really happen (at least not on the bootstrap CPU) 
because even if an SMI occurs, the CPU must first serve the timer 
interrupt and increment jiffies before it continues looping.

However "LPJ too short" is what needs to be avoided at all cost.

Regards and thanks for working on this problem,
Martin
