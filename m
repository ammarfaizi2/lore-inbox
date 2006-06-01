Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030231AbWFAQec@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030231AbWFAQec (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 1 Jun 2006 12:34:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030233AbWFAQec
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 1 Jun 2006 12:34:32 -0400
Received: from hellhawk.shadowen.org ([80.68.90.175]:17425 "EHLO
	hellhawk.shadowen.org") by vger.kernel.org with ESMTP
	id S1030231AbWFAQec (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 1 Jun 2006 12:34:32 -0400
Message-ID: <447F1702.3090405@shadowen.org>
Date: Thu, 01 Jun 2006 17:34:10 +0100
From: Andy Whitcroft <apw@shadowen.org>
User-Agent: Debian Thunderbird 1.0.7 (X11/20051017)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: "Martin J. Bligh" <mbligh@mbligh.org>
CC: Andrew Morton <akpm@osdl.org>, mbligh@google.com,
       linux-kernel@vger.kernel.org, ak@suse.de
Subject: Re: 2.6.17-rc5-mm1
References: <447DEF49.9070401@google.com>	<20060531140652.054e2e45.akpm@osdl.org>	<447E093B.7020107@mbligh.org> <20060531144310.7aa0e0ff.akpm@osdl.org> <447E104B.6040007@mbligh.org>
In-Reply-To: <447E104B.6040007@mbligh.org>
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Martin J. Bligh wrote:
> Andrew Morton wrote:
> 
>> "Martin J. Bligh" <mbligh@mbligh.org> wrote:
>>
>>> Andrew Morton wrote:
>>>
>>>> Martin Bligh <mbligh@google.com> wrote:
>>>>
>>>>
>>>>> The x86_65 panic in LTP has changed a bit. Looks more useful now.
>>>>> Possibly just unrelated new stuff. Possibly we got lucky.
>>>>
>>>>
>>>> What are you doing to make this happen?
>>>
>>>
>>> runalltests on LTP

Ok, I think this could well be the same problem I got half way through
tracking last time round.  We are still handing off threads with
non-initialised stacks.

APW: schedule: ffffffff805f0cd8 bad rsp flags=00000000
Kernel panic - not syncing: BAD STACK POINTER

Interestingly this has remained unchanged for dispite the major churn
-mm takes so this could well be the underlying issue as we almost always
blow up randomly when we do this, in a mess with no stack to work with.

Last time I tried to split search -mm1 and she was being a hideous pig,
I just couldn't get any bit of it to compile without the rest.  Will try
and track this down with the new -mm.

-apw
