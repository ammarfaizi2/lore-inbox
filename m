Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261410AbTHYDGF (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 24 Aug 2003 23:06:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261413AbTHYDGF
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 24 Aug 2003 23:06:05 -0400
Received: from dyn-ctb-210-9-243-120.webone.com.au ([210.9.243.120]:6916 "EHLO
	chimp.local.net") by vger.kernel.org with ESMTP id S261410AbTHYDGC
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 24 Aug 2003 23:06:02 -0400
Message-ID: <3F497CEC.3030507@cyberone.com.au>
Date: Mon, 25 Aug 2003 13:05:16 +1000
From: Nick Piggin <piggin@cyberone.com.au>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.4) Gecko/20030714 Debian/1.4-2
X-Accept-Language: en
MIME-Version: 1.0
To: Felipe Alfaro Solana <felipe_alfaro@linuxmail.org>
CC: linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] Nick's scheduler policy
References: <3F48B12F.4070001@cyberone.com.au> <1061735355.1034.2.camel@teapot.felipe-alfaro.com>
In-Reply-To: <1061735355.1034.2.camel@teapot.felipe-alfaro.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



Felipe Alfaro Solana wrote:

>On Sun, 2003-08-24 at 14:35, Nick Piggin wrote:
>
>>Hi,
>>Patch against 2.6.0-test4. It fixes a lot of problems here vs
>>previous versions. There aren't really any open issues for me, so
>>testers would be welcome.
>>
>>The big change is more dynamic timeslices, which allows "interactive"
>>tasks to get very small timeslices while more compute intensive loads
>>can be given bigger timeslices than usual. This works properly with
>>nice (niced processes will tend to get bigger timeslices).
>>
>>I think I have cured test-starve too.
>>
>
>I haven't still found any starvation cases, but forking time when the
>system is under heavy load has increased considerable with respect to
>vanilla or Con's O18.1int:
>
>1. On a Konsole session, run "while true; do a=2; done"
>2. Now, try forming a new Konsole session and you'll see it takes
>approximately twice the time it takes when the system is under no load.
>

Yeah, it probably penalises parents and children too much on fork, and
doesn't penalise parents of exiting cpu hogs enough. I have noticed
this too.

>
>Also, renicing X to -20 helps X interactivity, while with Con's patches,
>renicing X to -20 makes it feel worse.
>

renicing IMO is a lot more sane in my patches, although others might
disagree. In Con's patches, when you make X -20, it gets huge timeslices.
In my version, it will get lots of smaller timeslices.

Thanks again for testing.

Nick

