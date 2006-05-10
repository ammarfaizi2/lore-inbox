Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965076AbWEJXR6@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965076AbWEJXR6 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 10 May 2006 19:17:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965077AbWEJXR5
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 10 May 2006 19:17:57 -0400
Received: from mail-in-03.arcor-online.net ([151.189.21.43]:51426 "EHLO
	mail-in-03.arcor-online.net") by vger.kernel.org with ESMTP
	id S965076AbWEJXR5 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 10 May 2006 19:17:57 -0400
In-Reply-To: <17506.21908.857189.645889@cargo.ozlabs.ibm.com>
References: <17505.26159.807484.477212@cargo.ozlabs.ibm.com> <20060510154702.GA28938@twiddle.net> <20060510.124003.04457042.davem@davemloft.net> <17506.21908.857189.645889@cargo.ozlabs.ibm.com>
Mime-Version: 1.0 (Apple Message framework v749.3)
Content-Type: text/plain; charset=US-ASCII; format=flowed
Message-Id: <49BB818F-DF88-43A3-8B6A-7F9F5C7A2C3C@kernel.crashing.org>
Cc: "David S. Miller" <davem@davemloft.net>, linux-arch@vger.kernel.org,
       linuxppc-dev@ozlabs.org, linux-kernel@vger.kernel.org, rth@twiddle.net
Content-Transfer-Encoding: 7bit
From: Segher Boessenkool <segher@kernel.crashing.org>
Subject: Re: [RFC/PATCH] Make powerpc64 use __thread for per-cpu variables
Date: Thu, 11 May 2006 01:17:50 +0200
To: Paul Mackerras <paulus@samba.org>
X-Mailer: Apple Mail (2.749.3)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>>> How do you plan to address the compiler optimizing
>>  ...
>>> Across the schedule, we may have changed cpus, making the cached
>>> address invalid.
>>
>> Per-cpu variables need to be accessed only with preemption
>> disabled.  And the preemption enable/disable operations
>> provide a compiler memory barrier.
>
> No, Richard has a point, it's not the value that is the concern, it's
> the address, which gcc could assume is still valid after a barrier.
> Drat.

Would an asm clobber of GPR13 in the schedule routines (or a wrapper
for them, or whatever) work?


Segher

