Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262345AbTIZPPP (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 26 Sep 2003 11:15:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262347AbTIZPPP
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 26 Sep 2003 11:15:15 -0400
Received: from zero.aec.at ([193.170.194.10]:48134 "EHLO zero.aec.at")
	by vger.kernel.org with ESMTP id S262345AbTIZPPM (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 26 Sep 2003 11:15:12 -0400
To: Manfred Spraul <manfred@colorfullife.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: NS83820 2.6.0-test5 driver seems unstable on IA64
From: Andi Kleen <ak@muc.de>
Date: Fri, 26 Sep 2003 17:14:57 +0200
In-Reply-To: <zU7D.2Ji.27@gated-at.bofh.it> (Manfred Spraul's message of
 "Fri, 26 Sep 2003 08:20:17 +0200")
Message-ID: <m3ad8rinta.fsf@averell.firstfloor.org>
User-Agent: Gnus/5.090013 (Oort Gnus v0.13) Emacs/21.2 (i586-suse-linux)
References: <zU7D.2Ji.27@gated-at.bofh.it>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Manfred Spraul <manfred@colorfullife.com> writes:

> David wrote:
>
>>Fine, then we should have something like an rx_copybreak scheme in
>>the ns83820 driver too.
>>
> Is that really the right solution? Add a full-packet copy to every driver?
> IMHO the fastest solution would be to copy only the ip & tcp headers,
> and keep the rest as it is. And preferable in the network core, to
> avoid having to copy&paste that into every driver.

One problem is that you still have an unaligned->aligned copy to user space
in recvmsg (the user buffer is usually aligned and the network payload 
will be unaligned). And that will be very slow.

-Andi
