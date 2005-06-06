Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261198AbVFFINy@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261198AbVFFINy (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 6 Jun 2005 04:13:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261208AbVFFINy
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 6 Jun 2005 04:13:54 -0400
Received: from static.labristeknoloji.com ([81.214.24.78]:64965 "EHLO
	yssyk.labristeknoloji.com") by vger.kernel.org with ESMTP
	id S261198AbVFFINu (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 6 Jun 2005 04:13:50 -0400
Message-ID: <42A42FDE.2040600@labristeknoloji.com>
Date: Mon, 06 Jun 2005 11:13:34 +0000
From: "M.Baris Demiray" <baris@labristeknoloji.com>
Organization: Labris Teknoloji
User-Agent: Mozilla Thunderbird 1.0RC1 (X11/20041201)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Nick Piggin <nickpiggin@yahoo.com.au>
CC: Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2.6.12-rc5-mm2] [sched] add allowed CPUs check into find_idlest_group()
References: <42A3381F.90801@labristeknoloji.com> <42A3AA63.7060201@yahoo.com.au>
In-Reply-To: <42A3AA63.7060201@yahoo.com.au>
Content-Type: multipart/mixed;
 boundary="------------090608000303020302050900"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------090608000303020302050900
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit


Hello Nick,

Nick Piggin wrote:
> M.Baris Demiray wrote:
> 
> [...]
> Close.
> 
> Probably it would be better to take the intersection of
> (group->cpumask, p->cpus_allowed), and skip the group if
> the intersection is empty.

But, isn't it required for us to be allowed to run on _every_
CPU in that group. If we take intersection and continue if
that's not empty, then there could be CPUs in group that are
not allowed. Since any CPU then can be the idlest in that
group we can be assigned to a CPU that is not allowed.
Missing something?

> In addition to that, do a patch for find_idlest_cpu that
> skips cpus that aren't allowed. You needn't do the cpumask
> check each time round the loop, again just take the
> intersection of the group->cpumask and p->cpus_allowed, and
> loop over that.

Will do it.

> Wanna do a patch for that?

Sure. But I'll wait EOT and do read something more to fill
the gaps.

 > [...]
> 
> I don't think it does anything ;)

LOL. Hope next one'll do.

Meanwhile, what is the problem with that patch? Not traversing
the CPUs correctly or continue;ing is wrong?

	for_each_cpu_mask(i, group->cpumask) {
		if (!cpu_isset(i, p->cpus_allowed))
			continue;
	}

Thanks for comments.

> 

-- 
"You have to understand, most of these people are not ready to be
unplugged. And many of them are no inert, so hopelessly dependent
on the system, that they will fight to protect it."
                                                         Morpheus

--------------090608000303020302050900
Content-Type: text/x-vcard; charset=utf-8;
 name="baris.vcf"
Content-Transfer-Encoding: base64
Content-Disposition: attachment;
 filename="baris.vcf"

YmVnaW46dmNhcmQNCmZuOk0uQmFyaXMgRGVtaXJheQ0KbjpEZW1pcmF5O00uQmFyaXMNCm9y
ZzpMYWJyaXMgVGVrbm9sb2ppDQphZHI6OztUZWtub2tlbnQgU2lsaWtvbiBCaW5hIE5vOjI0
IE9EVFU7QW5rYXJhOzswNjUzMTtUdXJrZXkNCmVtYWlsO2ludGVybmV0OmJhcmlzQGxhYnJp
c3Rla25vbG9qaS5jb20NCnRpdGxlOllhemlsaW0gR2VsaXN0aXJtZSBVem1hbmkNCnRlbDt3
b3JrOis5MDMxMjIxMDE0OTANCnRlbDtmYXg6KzkwMzEyMjEwMTQ5Mg0KeC1tb3ppbGxhLWh0
bWw6RkFMU0UNCnVybDpodHRwOi8vd3d3LmxhYnJpc3Rla25vbG9qaS5jb20NCnZlcnNpb246
Mi4xDQplbmQ6dmNhcmQNCg0K
--------------090608000303020302050900--
