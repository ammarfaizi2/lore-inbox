Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1422949AbWJFUu2@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1422949AbWJFUu2 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 6 Oct 2006 16:50:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1422947AbWJFUu2
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 6 Oct 2006 16:50:28 -0400
Received: from mx1.redhat.com ([66.187.233.31]:38306 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S932629AbWJFUu1 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 6 Oct 2006 16:50:27 -0400
Message-ID: <4526C184.7070507@sandeen.net>
Date: Fri, 06 Oct 2006 15:50:12 -0500
From: Eric Sandeen <sandeen@sandeen.net>
User-Agent: Thunderbird 1.5.0.7 (X11/20060913)
MIME-Version: 1.0
To: Ingo Molnar <mingo@elte.hu>
CC: Srinivasa Ds <srinivasa@in.ibm.com>, dm-devel@redhat.com,
       linux-lvm@redhat.com, linux-kernel@vger.kernel.org, agk@redhat.com
Subject: Re: [RFC] Reverting "bd_mount_mutex" to "bd_mount_sem"
References: <451A78DF.1060901@in.ibm.com> <20060927135705.GA30311@elte.hu>
In-Reply-To: <20060927135705.GA30311@elte.hu>
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Ingo Molnar wrote:
> * Srinivasa Ds <srinivasa@in.ibm.com> wrote:
> 
>>   On debugging I found out that,"dmsetup suspend <device name>" calls 
>> "freeze_bdev()",which locks "bd_mount_mutex" to make sure that no new 
>> mounts happen on bdev until thaw_bdev() is called.
>>   This "thaw_bdev()" is getting called when we resume the device 
>> through "dmsetup resume <device-name>".
>>   Hence we have 2 processes,one of which locks 
>> "bd_mount_mutex"(dmsetup suspend) and Another(dmsetup resume) unlocks 
>> it.
> 
> hm, to me this seems quite a fragile construct - even if the 
> mutex-debugging warning is worked around by reverting to a semaphore.
> 
> 	Ingo

Ingo, what do you feel is fragile about this?  It seems like this is a
reasonable way to go, except that maybe a down_trylock would be good if
a 2nd process tries to freeze while it's already frozen...

Thanks,

-Eric
