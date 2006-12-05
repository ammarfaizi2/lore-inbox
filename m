Return-Path: <linux-kernel-owner+willy=40w.ods.org-S968611AbWLESu0@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S968611AbWLESu0 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 5 Dec 2006 13:50:26 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S968622AbWLESu0
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 5 Dec 2006 13:50:26 -0500
Received: from einhorn.in-berlin.de ([192.109.42.8]:52639 "EHLO
	einhorn.in-berlin.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S968623AbWLESuZ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 5 Dec 2006 13:50:25 -0500
X-Envelope-From: stefanr@s5r6.in-berlin.de
Message-ID: <4575BF51.1070109@s5r6.in-berlin.de>
Date: Tue, 05 Dec 2006 19:49:53 +0100
From: Stefan Richter <stefanr@s5r6.in-berlin.de>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.8.0.6) Gecko/20060730 SeaMonkey/1.0.4
MIME-Version: 1.0
To: =?UTF-8?B?S3Jpc3RpYW4gSMO4Z3NiZXJn?= <krh@redhat.com>
CC: David Miller <davem@davemloft.net>, benh@kernel.crashing.org,
       linux-kernel@vger.kernel.org, linux1394-devel@lists.sourceforge.net
Subject: Re: [PATCH 0/3] New firewire stack
References: <20061205052229.7213.38194.stgit@dinky.boston.redhat.com>	<1165297363.29784.54.camel@localhost.localdomain> <20061204.230502.35014139.davem@davemloft.net> <4575A170.2030805@redhat.com>
In-Reply-To: <4575A170.2030805@redhat.com>
X-Enigmail-Version: 0.94.1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Kristian Høgsberg wrote:
> David Miller wrote:
>> From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
>>>  DO NOT USE BITFIELDS FOR DATA ON THE WIRE !!!

Actually we do so in some places of the existing FireWire drivers.
Didn't go wrong so far. :-)

>>>  Where do you handle endianness ? (no need to shout for
>>>  that one).
>>>
>>> (Or in general, do not use bitfields period ....)
>>
>> Yes, this is a show stopper, the endianness and
>> word-size/endian testing should have been done before
>> submission.
> 
> I guess my mistake here was to present it as a patch submission.  I
> acknowledged in my cover letter that it wasn't feature complete and I'm
> not pushing for inclusion just yet.  I'm very much aware of the point
> that when replacing a subsystem like this, the new code has to be as
> good as the old code.  In that respect, the patches I posted are lacking
> in other areas (isochronous streaming is the big one) that will take
> more work to fix than just making it work on big-endian and 64-bit
> architectures.  It's still a work in progress.
[...]

That's right; there are a few in-kernel features and, much more
importantly, userspace ABIs missing before Kristian's stack could
replace the old one.

The good news is that the ABIs are either hidden behind userspace
libraries or are deprecated and to be phased out next year anyway.

The bad news is that the old stack is internally not as cleanly modular
as it was initially targeted to be. This makes it difficult to replace
the stack in parts, particularly where isochronous protocols are
concerned. Maybe this becomes a non-issue once the old ABIs were
removed; although I suppose that Kristian would like to see his stack in
wider use much earlier than that. The asynchronous stuff (what's left of
it besides sbp2) should be easy to move over.
-- 
Stefan Richter
-=====-=-==- ==-- --=-=
http://arcgraph.de/sr/
