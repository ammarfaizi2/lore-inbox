Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263682AbTIBIo6 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 2 Sep 2003 04:44:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263649AbTIBIo6
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 2 Sep 2003 04:44:58 -0400
Received: from dyn-ctb-203-221-73-133.webone.com.au ([203.221.73.133]:16646
	"EHLO chimp.local.net") by vger.kernel.org with ESMTP
	id S263682AbTIBIo5 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 2 Sep 2003 04:44:57 -0400
Message-ID: <3F545883.8090800@cyberone.com.au>
Date: Tue, 02 Sep 2003 18:44:51 +1000
From: Nick Piggin <piggin@cyberone.com.au>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.4) Gecko/20030827 Debian/1.4-3
X-Accept-Language: en
MIME-Version: 1.0
To: torvalds@osdl.org
CC: linux-kernel@vger.kernel.org
Subject: Re: [PATCH] might_sleep() improvements
References: <20030902075145.GA12817@sfgoth.com> <3F545175.1080505@cyberone.com.au> <bj1kr3$a2g$1@build.pdx.osdl.net>
In-Reply-To: <bj1kr3$a2g$1@build.pdx.osdl.net>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



Linus Torvalds wrote:

>Nick Piggin wrote:
>
>>I think these should be pushed down to where the sleeping
>>actually happens if possible.
>>
>
>No, that ends up doing the wrong thing for most of the really common cases.
>
>In particular, most of the memory allocation functions very seldom actually
>sleep. After all, they'll find plenty of free memory (or easily freeable
>memory) without having to wait for any pageouts or anything like that.
>
>Yet the bug is there - the call _could_ have slept.
>
>So "might_sleep()" really does what the name suggests: it is used to say
>that a particular case _may_ sleep, even if it ends up being unlikely.
>
>Because what we're after is not a bug actually happening, but a latent bug
>that has been hidden by the fact that it happens so rarely in practice.
>
>This is why "might_sleep()" should happen as early as possible, and not
>get pushed down.
>
>

Yes I see. I agree. I thought some could be pushed down further without
losing info. I was mainly worried about adding the might_sleep_if
function.


