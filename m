Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932584AbVISTEg@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932584AbVISTEg (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 19 Sep 2005 15:04:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932586AbVISTEg
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 19 Sep 2005 15:04:36 -0400
Received: from ns1.coraid.com ([65.14.39.133]:27114 "EHLO coraid.com")
	by vger.kernel.org with ESMTP id S932584AbVISTEf (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 19 Sep 2005 15:04:35 -0400
To: "David S. Miller" <davem@davemloft.net>
Cc: linux-kernel@vger.kernel.org, jmacbaine@gmail.com
Subject: Re: aoe fails on sparc64
References: <87u0glxhfw.fsf@coraid.com>
	<20050916.163554.79765706.davem@davemloft.net>
	<87slw1b0fz.fsf@coraid.com>
	<20050919.112159.55767801.davem@davemloft.net>
From: Ed L Cashin <ecashin@coraid.com>
Date: Mon, 19 Sep 2005 14:38:26 -0400
In-Reply-To: <20050919.112159.55767801.davem@davemloft.net> (David S.
 Miller's message of "Mon, 19 Sep 2005 11:21:59 -0700 (PDT)")
Message-ID: <877jdc2999.fsf@coraid.com>
User-Agent: Gnus/5.110002 (No Gnus v0.2) Emacs/21.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

"David S. Miller" <davem@davemloft.net> writes:

> From: Ed L Cashin <ecashin@coraid.com>
> Date: Mon, 19 Sep 2005 10:24:00 -0400
>
>>   1) Passing le64_to_cpup an unaligned pointer is "OK" and within the
>>      intended use of the function.  I'm having trouble finding whether
>>      this is documented somewhere.
>> 
>>   2) These new changes to the sparc64 unaligned access fault handling
>>      will make it OK to leave the aoe driver the way it is in the
>>      mainline kernel.
>
> Both #1 and #2 are true.

That's interesting.  I think I'll send a patch documenting #1.

> Although it's very much discouraged to dereference unaligned pointers,
> especially in performance critical code (which this AOE case is not,
> thankfully), because performance will be really bad as the trap
> handler has to fix up the access on RISC platforms.

Yes, this only happens when per AoE device when the AoE device is
discovered.  Still, I might submit a patch that reverts the aoe driver
to getting the ATA identify values byte by byte as it used to do.

-- 
  Ed L Cashin <ecashin@coraid.com>

