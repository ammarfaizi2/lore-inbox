Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262339AbVBVPrN@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262339AbVBVPrN (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 22 Feb 2005 10:47:13 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262341AbVBVPrN
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 22 Feb 2005 10:47:13 -0500
Received: from zcars04e.nortelnetworks.com ([47.129.242.56]:41646 "EHLO
	zcars04e.nortelnetworks.com") by vger.kernel.org with ESMTP
	id S262336AbVBVPrC (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 22 Feb 2005 10:47:02 -0500
Message-ID: <421B53D4.3020006@nortel.com>
Date: Tue, 22 Feb 2005 09:46:28 -0600
X-Sybari-Space: 00000000 00000000 00000000 00000000
From: Chris Friesen <cfriesen@nortel.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.6) Gecko/20040115
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Puneet Kaushik <puneet_kaushik@persistent.co.in>
CC: george@mvista.com, kernel-stuff@comcast.net, linux-kernel@vger.kernel.org
Subject: Re: Needed faster implementation of do_gettimeofday()
References: <34373.203.199.147.2.1108897097.squirrel@webmail.persistent.co.in>	 <200502201048.01424.kernel-stuff@comcast.net> <421AA1BD.7020706@mvista.com> <1109080575.21544.264.camel@ps2335.persistent.co.in>
In-Reply-To: <1109080575.21544.264.camel@ps2335.persistent.co.in>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Puneet Kaushik wrote:
> Hello Parag and George,
> 
> Thanks for immediate reply.
> The main problem is I am working on a SMP system. I have written a small
> program that just calls the gettimeofday(), one billion times. I have
> run it with time utility and it takes almost double time on SMP then a
> UP.

If the hardware is known in advance, can you use some arch-specific 
thing (like rdtsc on intel) to get a timestamp that can then be 
calibrated by calling gettimeofday() at a lower frequency?

There will be issues (may have to use cpu affinity if the two don't run 
at the same rate, may need to disable any frequency stepping), but it 
might be possible to work around them.

Chris
