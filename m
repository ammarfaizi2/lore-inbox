Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267357AbUHMU1y@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267357AbUHMU1y (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 13 Aug 2004 16:27:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267411AbUHMUZj
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 13 Aug 2004 16:25:39 -0400
Received: from [66.45.74.15] ([66.45.74.15]:30170 "EHLO sluggardy.net")
	by vger.kernel.org with ESMTP id S267477AbUHMUVD (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 13 Aug 2004 16:21:03 -0400
Message-ID: <411D2227.2060500@sluggardy.net>
Date: Fri, 13 Aug 2004 13:18:47 -0700
From: Nick Palmer <nick@sluggardy.net>
User-Agent: Mozilla Thunderbird 0.5 (X11/20040405)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Manfred Spraul <manfred@colorfullife.com>
CC: linux-kernel@vger.kernel.org
Subject: Re: select implementation not POSIX compliant?
References: <411A8646.1030205@colorfullife.com>
In-Reply-To: <411A8646.1030205@colorfullife.com>
X-Enigmail-Version: 0.83.2.0
X-Enigmail-Supports: pgp-inline, pgp-mime
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Manfred Spraul wrote:

 > Could you post the test case for this behavior: I assume your test app
 > is buggy: a select call that is executed after close returned must
 > return EBADF, everything else would be a bug.

Actually Solaris and Linux are consistent in terms of the behavior of
select in this respect. I suspect that the first select is blocking the
socket from being used at all, so the second select can't tell that it
is closed.

 > Regarding your main point: The return result from select/poll is
 > undefined in Linux if you close a descriptor while another thread polls
 > or selects it.
 > This is consistent with the behavior of other Unices - for example HP UX
 > kills the process if you replace a descriptor that is being polled with
 > dup2.

Right, hence my feeling that select is over all fairly broken. The big
difference between Solaris and Linux though is that close will call
recv* calls to return on Solaris, and close doesn't do that on Linux.
The work around is to use shutdown on Linux before calling close. This
also works on Solaris, though it makes the recv set errno differently.

Thanks for looking at this issue,
-Nick
