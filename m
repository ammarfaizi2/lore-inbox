Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268405AbUIPXlZ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268405AbUIPXlZ (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 16 Sep 2004 19:41:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268357AbUIPXku
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 16 Sep 2004 19:40:50 -0400
Received: from omx2-ext.sgi.com ([192.48.171.19]:18135 "EHLO omx2.sgi.com")
	by vger.kernel.org with ESMTP id S268301AbUIPXiM (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 16 Sep 2004 19:38:12 -0400
Message-ID: <414A240B.5050105@sgi.com>
Date: Thu, 16 Sep 2004 18:38:51 -0500
From: Ray Bryant <raybry@sgi.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.4) Gecko/20030624 Netscape/7.1
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Zwane Mwaikambo <zwane@linuxpower.ca>
CC: Ray Bryant <raybry@austin.rr.com>, Andrew Morton <akpm@osdl.org>,
       lse-tech@lists.sourceforge.net, "Martin J. Bligh" <mbligh@aracnet.com>,
       linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/3] lockmeter: lockmeter fix for generic_read_trylock
References: <20040916230344.23023.79384.49263@tomahawk.engr.sgi.com> <20040916230402.23023.89478.83475@tomahawk.engr.sgi.com> <Pine.LNX.4.53.0409161918520.2897@musoma.fsmlabs.com>
In-Reply-To: <Pine.LNX.4.53.0409161918520.2897@musoma.fsmlabs.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Zwane Mwaikambo wrote:
> On Thu, 16 Sep 2004, Ray Bryant wrote:
> 
> 
>>Update lockmeter.c with generic_raw_read_trylock fix.
>>
>>+ * Generic declaration of the raw read_trylock() function,
>>+ * architectures are supposed to optimize this:
>>+ */
>>+int __lockfunc generic_raw_read_trylock(rwlock_t *lock)
>>+{
>>+	_metered_read_lock(lock, __builtin_return_address(0));
>>+	return 1;
>>+}
> 
> 
> What's really going on here? I'm slightly confused by the 
> _metered_read_lock usage.
> 
> Thanks,
> 	Zwane
> 
> 

Yeah, I think overly patterned matched on this one.  I just
grabbed the code from spinlock.c and do what I normally do to
make it lockmetered, but in this case since its a _raw_ routine, I
should have left it alone.  It just needs to be duplicated in
lockmeter.c, not lockmeter'd.

So that middle line there should be:

	_raw_read_lock(lock);

instead.  I'll get this straightend out with Andrew shortly.
-- 
Best Regards,
Ray
-----------------------------------------------
                   Ray Bryant
512-453-9679 (work)         512-507-7807 (cell)
raybry@sgi.com             raybry@austin.rr.com
The box said: "Requires Windows 98 or better",
            so I installed Linux.
-----------------------------------------------

