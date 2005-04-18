Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262002AbVDRJGX@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262002AbVDRJGX (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 18 Apr 2005 05:06:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262000AbVDRJF2
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 18 Apr 2005 05:05:28 -0400
Received: from anchor-post-35.mail.demon.net ([194.217.242.85]:17160 "EHLO
	anchor-post-35.mail.demon.net") by vger.kernel.org with ESMTP
	id S261993AbVDRJDP (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 18 Apr 2005 05:03:15 -0400
Message-ID: <426385FB.1080701@superbug.co.uk>
Date: Mon, 18 Apr 2005 11:03:39 +0100
From: James Courtier-Dutton <James@superbug.co.uk>
User-Agent: Mozilla Thunderbird 1.0.2 (X11/20050416)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Chris Friesen <cfriesen@nortel.com>
CC: Chris Wedgwood <cw@f00f.org>, Takashi Ikebe <ikebe.takashi@lab.ntt.co.jp>,
       linux-kernel@vger.kernel.org
Subject: Re: [PATCH x86_64] Live Patching Function on 2.6.11.7
References: <4263275A.2020405@lab.ntt.co.jp> <20050418040718.GA31163@taniwha.stupidest.org> <4263356D.9080007@lab.ntt.co.jp> <20050418061221.GA32315@taniwha.stupidest.org> <42635518.6040704@nortel.com>
In-Reply-To: <42635518.6040704@nortel.com>
X-Enigmail-Version: 0.86.1.0
X-Enigmail-Supports: pgp-inline, pgp-mime
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Chris Friesen wrote:
> Chris Wedgwood wrote:
> 
>> On Mon, Apr 18, 2005 at 01:19:57PM +0900, Takashi Ikebe wrote:
>>
>>
>>> From our experience, sometimes patches became to dozens to hundreds
>>> at one patching, and in this case GDB based approach cause target
>>> process's availability descent.
> 
> 
>> could you perhaps explain some *real* *world* applications/systems
>> where this is necessary and why existing APIs won't work with them
>> perhaps?
> 
> 
> In the telecom space it's quite common to want to modify multiple
> running binaries with as little downtime as possible.  (Beyond a
> threshold it becomes FCC-reportable in the US, and everyone wants to
> avoid that...)
> 
> Our old proprietary OS had explicit support for replacing running binary
> code on the fly, so customers have gotten used to the ability.  Now they
> want equivalent functionality with our linux-based stuff.
> 
> We've done some proprietary stuff (ie. pre-OSDL CGL) in this area, but
> it was apparently a real pain and was quite restrictive on the
> application writers. (I was not involved with that portion of the project.)
> 
> For general application support I suspect some kernel support will be
> required.  Whether this is the way to go or whether it can be done using
> existing mechanisms, I'm not knowledgeable enough to comment.
> 
> Chris
> -

I raised a thread like this about 1 year ago. I was asking for it from
the point of view of a Telco. After some discussions on this list, I
came to agree with the posts on the list by other people that the
feature is not needed. At least certainly not needed in the Telco space.
99.999% uptime is much better acheived with the use of clustering,
rather than trying to upgrade software in a Live situation. In a
clustered environment, one offloads all the tasks from machine A and
spread them across the cluster. Once the machine A is not doing any work
at all, you can upgrade, reboot, whatever you like, and then add it back
to the cluster. This approach is much less risky than live module updates.
If the equipment is not clustered, it will at least be 2 to 1 redundent,
so you just upgrade the redundent device, manually force a fail over,
and then upgrade the other device. Again, no live update required.

I can only think of one other system that might benefit from live
updates, and that is set top boxes, so bugs can be fixed without the
user knowing. This also can be worked around by downloading the bug
fixes and only installing the bugs fixes when the user is not viewing
the TV. E.g. When the box has been placed in standby by the user.

James
