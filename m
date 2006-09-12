Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964958AbWILHkK@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964958AbWILHkK (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 12 Sep 2006 03:40:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964959AbWILHkK
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 12 Sep 2006 03:40:10 -0400
Received: from mail.dsa-ac.de ([62.112.80.99]:779 "EHLO mail.dsa-ac.de")
	by vger.kernel.org with ESMTP id S964958AbWILHkI (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 12 Sep 2006 03:40:08 -0400
Date: Tue, 12 Sep 2006 09:40:03 +0200 (CEST)
From: Guennadi Liakhovetski <gl@dsa-ac.de>
To: Nick Piggin <nickpiggin@yahoo.com.au>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [2.6.17.4] slabinfo.buffer_head increases
In-Reply-To: <45061FCB.1000402@yahoo.com.au>
Message-ID: <Pine.LNX.4.63.0609120933450.1700@pcgl.dsa-ac.de>
References: <Pine.LNX.4.63.0607101023450.27628@pcgl.dsa-ac.de>
 <Pine.LNX.4.63.0607101412250.27628@pcgl.dsa-ac.de>
 <Pine.LNX.4.63.0609061341150.1700@pcgl.dsa-ac.de> <45061FCB.1000402@yahoo.com.au>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII; format=flowed
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 12 Sep 2006, Nick Piggin wrote:

> Guennadi Liakhovetski wrote:
>
>>> On Mon, 10 Jul 2006, Guennadi Liakhovetski wrote:
>>> 
>>>> I am obsering a steadily increasing buffer_head value in slabinfo under
>>>> 2.6.17.4. I searched the net / archives and didn't find anything
>>>> directly relevant. Does anyone have an idea or how shall we debug it?
>>> 
>> 
>> The problem is still there under 2.6.18-rc2. I narrowed it down to ext3 
>> journal. To reproduce one just has to mount an ext3 partition and perform 
>> (write) accesses to it. A loop { touch /mnt/foo; sleep 1; } suffices - just 
>> let it run for a couple of minutes and monitor buffer_head in 
>> /proc/slabinfo. If you mount it as ext2 the problem is gone.
>
>
> What data mode is ext3 mounted with?

Default, i.e., ordered, I guess.

> Is the memory reclaimable? If yes, is it a problem?

Yes, that's why I later wrote that the problem is not real. It was hard to 
see as we had a lot of free RAM on the system, the system was idle apart 
from one script that only did "touch x" periodically with the same "x" 
and the buffer_head slab was growing very steadily. Unlike with ext2 / 
reiserfs. That's why I decided it was not ok. But the memory is 
reclaimable, so, seems like not a problem. Just a bit odd that such a 
"harmless" operation causes a steady growth of buffer_heads...

Thanks
Guennadi
---------------------------------
Guennadi Liakhovetski, Ph.D.
DSA Daten- und Systemtechnik GmbH
Pascalstr. 28
D-52076 Aachen
Germany
