Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263670AbUCUQXS (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 21 Mar 2004 11:23:18 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263672AbUCUQXS
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 21 Mar 2004 11:23:18 -0500
Received: from citrine.spiritone.com ([216.99.193.133]:56454 "EHLO
	citrine.spiritone.com") by vger.kernel.org with ESMTP
	id S263670AbUCUQXQ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 21 Mar 2004 11:23:16 -0500
Date: Sun, 21 Mar 2004 08:23:20 -0800
From: "Martin J. Bligh" <mbligh@aracnet.com>
To: Andrea Arcangeli <andrea@suse.de>
cc: linux-kernel@vger.kernel.org, Jens Axboe <axboe@suse.de>
Subject: Re: 2.6.5-rc1-aa3
Message-ID: <2923100000.1079886200@[10.10.2.4]>
In-Reply-To: <20040321132630.GO10787@dualathlon.random>
References: <20040320210306.GA11680@dualathlon.random> <2910700000.1079849836@[10.10.2.4]> <20040321132630.GO10787@dualathlon.random>
X-Mailer: Mulberry/2.2.1 (Linux/x86)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

--Andrea Arcangeli <andrea@suse.de> wrote (on Sunday, March 21, 2004 14:26:30 +0100):

> On Sat, Mar 20, 2004 at 10:17:16PM -0800, Martin J. Bligh wrote:
>> > Fixed the sigbus in nopage and improved the page_t layout per Hugh's
>> > suggestion. BUG() with discontigmem disabled if somebody returns non-ram
>> > via do_no_page, that cannot work right on numa anyways.
>> 
>> OK, well it doesn't oops any more. But sshd still dies as soon as it starts,
>> so accessing the box is tricky ;-) And now I have no obvious diagnostics
>> either ...
> 
> Jens sent me the perfect strace log, after his help it has not been
> difficult to spot the bug. this incremental should fix it
> MAP_SHARED|MAP_ANONYMOUS isn't very common and my userspace never
> triggered it. I placed the pgoff anon setting in the path of the shared
> memory too, that generated the sigbus. Leaving the setting only in the
> MAP_PRIVATE should fix it, the anonymous memory is only MAP_PRIVATE.
> 
> patch is untested at the moment, as soon as I get confirmation I'll
> upload an update.

Yup, that fixes mine up too - runs fine now.

M.

