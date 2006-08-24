Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030459AbWHXTFq@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030459AbWHXTFq (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 24 Aug 2006 15:05:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030461AbWHXTFq
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 24 Aug 2006 15:05:46 -0400
Received: from e4.ny.us.ibm.com ([32.97.182.144]:26560 "EHLO e4.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id S1030459AbWHXTFq (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 24 Aug 2006 15:05:46 -0400
Message-ID: <44EDF887.20906@watson.ibm.com>
Date: Thu, 24 Aug 2006 15:05:43 -0400
From: Shailabh Nagar <nagar@watson.ibm.com>
User-Agent: Debian Thunderbird 1.0.2 (X11/20051002)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Olaf Hering <olaf@aepfle.de>
CC: linux-kernel@vger.kernel.org, Balbir Singh <balbir@in.ibm.com>
Subject: Re: oops in __delayacct_blkio_ticks with 2.6.18-rc4
References: <20060821112405.GA28356@aepfle.de> <44EB5684.60002@watson.ibm.com> <20060823111815.GA11270@aepfle.de>
In-Reply-To: <20060823111815.GA11270@aepfle.de>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Olaf Hering wrote:
> On Tue, Aug 22, Shailabh Nagar wrote:
> 
> 
>>Olaf Hering wrote:
>>
>>>https://bugzilla.novell.com/show_bug.cgi?id=200526
>>>
>>
>>Thanks for detecting this.
>>
>>I suspect the oops is caused by a reading of /proc/<tgid>/stat for some task
>>that is late in exit. Currently tsk->delays is being freed up too early (before
>>the tsk is removed from the tasklist).
>>
>>Could you try the patch below ? It was unclear from the bug what userspace
>>actions were being done to reproduce the oops - I suspect some kind of
>>reading of /proc/.../stat for all processes ?
> 
> 
> I dont have a way to trigger it. The commands were 'w' and 'pstree'.

Ok. Using the following two commands allowed the original oops to be
triggered on an 8-way pretty quickly:

while : ; do usleep 10 > /dev/null ; done

while : ; do cat /proc/[0-9]???*/stat ; done

(where the regex for catching the newly forking/exiting tasks
can be adjusted to the right range of ids being spawned by the
first command)

Applying the patch I sent solves the problem. I'm doing some more
testing and will submit the patch formally shortly.

Thanks,
Shailabh




