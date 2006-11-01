Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1946577AbWKAKTv@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1946577AbWKAKTv (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 1 Nov 2006 05:19:51 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1946579AbWKAKTv
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 1 Nov 2006 05:19:51 -0500
Received: from sp604005mt.neufgp.fr ([84.96.92.11]:56998 "EHLO smtp.Neuf.fr")
	by vger.kernel.org with ESMTP id S1946577AbWKAKTu (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 1 Nov 2006 05:19:50 -0500
Date: Wed, 01 Nov 2006 11:19:25 +0100
From: Eric Dumazet <dada1@cosmosbay.com>
Subject: Re: [patch 1/1] schedule removal of FUTEX_FD
In-reply-to: <1162343945.14769.16.camel@localhost.localdomain>
To: Rusty Russell <rusty@rustcorp.com.au>
Cc: akpm@osdl.org, linux-kernel@vger.kernel.org, drepper@redhat.com,
       mingo@elte.hu, tglx@linutronix.de
Message-id: <454874AD.2070607@cosmosbay.com>
MIME-version: 1.0
Content-type: text/plain; charset=ISO-8859-1; format=flowed
Content-transfer-encoding: 8BIT
References: <200610312309.k9VN9mco015260@shell0.pdx.osdl.net>
 <1162343945.14769.16.camel@localhost.localdomain>
User-Agent: Thunderbird 1.5.0.7 (Windows/20060909)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Rusty Russell a écrit :
> On Tue, 2006-10-31 at 15:09 -0800, akpm@osdl.org wrote:
>> From: Andrew Morton <akpm@osdl.org>
>>
>> Apparently FUTEX_FD is unfixably racy and nothing uses it (or if it does, it
>> shouldn't).
>>
>> Add a warning printk, give any remaining users six months to migrate off it.
> 
> This makes sense.  FUTEX_FD was for the NGPT project which did userspace
> threading, and hence couldn't block.  It was always kind of a hack
> (although unfixably racy isn't quite right, it depends on usage).
> 
> However, the existence of FUTEX_FD is what made Ingo complain that we
> couldn't simply pin the futex page in memory, because now a process
> could pin one page per fd.  Removing it would seem to indicate that we
> can return to a much simpler scheme of (1) pinning a page when someone
> does futex_wait, and (2) simply comparing futexes by physical address.
> 
> Now, I realize with some dismay that simplicity is no longer a futex
> feature, but it might be worth considering?

Hum... I am not sure playing MM games is good... really...

This discussion reminds me I posted a patch some time ago that got no comments 
from the community.

http://lkml.org/lkml/2006/8/9/26

Eric

