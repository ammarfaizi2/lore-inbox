Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263025AbTDRLec (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 18 Apr 2003 07:34:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263026AbTDRLec
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 18 Apr 2003 07:34:32 -0400
Received: from nat-pool-rdu.redhat.com ([66.187.233.200]:49130 "EHLO
	devserv.devel.redhat.com") by vger.kernel.org with ESMTP
	id S263025AbTDRLeb (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 18 Apr 2003 07:34:31 -0400
From: Alan Cox <alan@redhat.com>
Message-Id: <200304181146.h3IBkOx06987@devserv.devel.redhat.com>
Subject: Re: Linux 2.5.67-ac2: ide reset issue
To: rain.wang@mic.com.tw (rain.wang)
Date: Fri, 18 Apr 2003 07:46:24 -0400 (EDT)
Cc: alan@redhat.com (Alan Cox), axboe@suse.de (Jens Axboe),
       linux-kernel@vger.kernel.org
In-Reply-To: <3E9F9440.7F7CBDC8@mic.com.tw> from "rain.wang" at Ebr 18, 2003 01:59:28 
X-Mailer: ELM [version 2.5 PL6]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>     I don't know if there's enough reason to change reset semantics
> now to wait for completion, so that the next call be free of race.
> and  I once had a simpler fix to let it delay another 50ms, that works
> on my box but seems not a thorough one. does it help?

BWGROUP(drive)->busy should never reach zero until the reset is
done. The 50mS miught be enough that this occurs, as might waiting
for HWGROUP(drive)->busy hitting 0. I don't yet understand why it
matters, and to fix it properly I have to figure that out.

If you need reliable reset for something like a test harness, or
IDE drive tester its a usable workaround, but I need to fix it
properly (eventually)

> +			/* wait for another 50ms */
> +			mdelay(50);

In your test set is HWGROUP(drive)->busy always zero after the
mdelay ?

