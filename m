Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262344AbUKVVxA@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262344AbUKVVxA (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 22 Nov 2004 16:53:00 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262399AbUKVVvN
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 22 Nov 2004 16:51:13 -0500
Received: from pop5-1.us4.outblaze.com ([205.158.62.125]:62941 "HELO
	pop5-1.us4.outblaze.com") by vger.kernel.org with SMTP
	id S262344AbUKVVtr (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 22 Nov 2004 16:49:47 -0500
Subject: Re: [PATCH]time run too fast after S3
From: Nigel Cunningham <ncunningham@linuxmail.org>
Reply-To: ncunningham@linuxmail.org
To: john stultz <johnstul@us.ibm.com>
Cc: Li Shaohua <shaohua.li@intel.com>, lkml <linux-kernel@vger.kernel.org>,
       Andrew Morton <akpm@osdl.org>, Pavel Machek <pavel@suse.cz>
In-Reply-To: <1101148405.6735.107.camel@cog.beaverton.ibm.com>
References: <1101114923.14572.8.camel@sli10-desk.sh.intel.com>
	 <1101148405.6735.107.camel@cog.beaverton.ibm.com>
Content-Type: text/plain
Message-Id: <1101159901.7962.49.camel@desktop.cunninghams>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6-1mdk 
Date: Tue, 23 Nov 2004 08:45:02 +1100
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi.

On Tue, 2004-11-23 at 05:33, john stultz wrote:
> I'm not all that familiar w/ the suspend code, but yea, this looks like
> an improvement.  The previous code was wrong because they are setting
> xtime themselves, and then updating only jiffies. At the next timer
> interrupt, the difference between jiffies and wall_jiffies would then be
> added to xtime again. 

That makes a lot of sense to me :> 

It also happens with suspend to disk now that Pavel and I have added
sysdev support to our implementations.

I was doing some looking in this area last week, but ran out of time. I
was seeing the clock being out - sometimes - by 1 hour+.

That section of code could also be improved by reusing the value of the
first call to get_cmos_time(). The way that function works, two
consecutive calls will cause a one second delay for the second call. A
__get_cmos_time function that doesn't wait for the start of a second was
suggested for where we only care about consistency and not about getting
the start of the second. I'll send a patch shortly.

> Why they don't just use do_settimeofday() for all of this is a mystery
> to me. Are we wanting to pretend timer ticks arrived while we were
> suspended?

I think that was Pavel's idea; something about getting process times
right. Speaking for myself, I might be being short sighted, but I just
want to save the user having to run /sbin/hwclock --hctosys afterwards.

Regards,

Nigel
-- 
Nigel Cunningham
Pastoral Worker
Christian Reformed Church of Tuggeranong
PO Box 1004, Tuggeranong, ACT 2901

You see, at just the right time, when we were still powerless, Christ
died for the ungodly.		-- Romans 5:6

