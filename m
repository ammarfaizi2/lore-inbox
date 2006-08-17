Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964964AbWHQNdk@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964964AbWHQNdk (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 17 Aug 2006 09:33:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964942AbWHQNbd
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 17 Aug 2006 09:31:33 -0400
Received: from 125.14.cm.sunflower.com ([24.124.14.125]:30494 "EHLO
	mail.atipa.com") by vger.kernel.org with ESMTP id S964939AbWHQN3W
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 17 Aug 2006 09:29:22 -0400
Message-ID: <44E46F3A.9000608@atipa.com>
Date: Thu, 17 Aug 2006 08:29:30 -0500
From: Roger Heflin <rheflin@atipa.com>
User-Agent: Thunderbird 1.5 (X11/20060313)
MIME-Version: 1.0
To: Neil Brown <neilb@suse.de>
CC: Willy Tarreau <w@1wt.eu>, Xin Zhao <uszhaoxin@gmail.com>,
       linux-kernel <linux-kernel@vger.kernel.org>,
       linux-fsdevel@vger.kernel.org
Subject: Re: What's the NFS OOM problem?
References: <4ae3c140608081524u4666fb7x741734908c35cfe6@mail.gmail.com>	<20060810045711.GI8776@1wt.eu>	<17627.53340.43470.60811@cse.unsw.edu.au>	<44E21166.60308@atipa.com> <17635.63709.848914.895135@cse.unsw.edu.au>
In-Reply-To: <17635.63709.848914.895135@cse.unsw.edu.au>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
X-OriginalArrivalTime: 17 Aug 2006 13:29:42.0453 (UTC) FILETIME=[327E4650:01C6C201]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Neil Brown wrote:
> On Tuesday August 15, rheflin@atipa.com wrote:
>> I have noticed on SLES kernels that when the dirty_*ratios turned down it
>> still uses alot more memory than it should work writeback buffers, it makes
>> me think that with the default setting of 40% that it for some reason
>> may be using all of memory and deadlocking.   It does not seem like an
>> NFS only issue, as I believe I have duplicated it with a fast lock
>> setup.
> 
> We seem to have a little patch in SuSE kernels that might be making
> the problem worse .... though I presume it was introduced for a
> reason.  I haven't managed to track what that reason was yet.
> 
> What is "a fast lock setup"??  I don't understand.
> 
> NeilBrown
> 

I am not sure what I ment, I may have ment a fast disk setup, and
thought or typed the wrong thing.  The machine I duplicated it with
had disks that would sustain 175MB/second (3 striped), 4cpus with local
ram of 32GB.   The 2 cpu/4GB/100MB/second machine does not seem
to have the issue.   Both machines are opterons, I believe I duplicated
it under SP2, I know I duplicated it SP3 and one of the
post-SP3 kernels.   It did not occur under SP1.

Turning down the dirty*ratios seems to make it go away.   When I
get a chance I will retest on SP2 and see if it happens there.

I do know (and this may be related) that if on a 32GB machine I
pagelock a large portion of ram (say 28GB) that machine will deadlock
under high IO.  The basic symptoms are similar to the writeback
issue the machine responds to ping/sysrq, but logins fail, and any
new process creation fails.

                                  Roger
