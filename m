Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750775AbWGVOCk@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750775AbWGVOCk (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 22 Jul 2006 10:02:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750782AbWGVOCk
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 22 Jul 2006 10:02:40 -0400
Received: from adsl-70-250-156-241.dsl.austtx.swbell.net ([70.250.156.241]:36768
	"EHLO gw.microgate.com") by vger.kernel.org with ESMTP
	id S1750775AbWGVOCk (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 22 Jul 2006 10:02:40 -0400
Message-ID: <44C22FFA.9050704@microgate.com>
Date: Sat, 22 Jul 2006 09:02:34 -0500
From: Paul Fulghum <paulkf@microgate.com>
User-Agent: Mozilla Thunderbird 1.0.7 (Windows/20050923)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Chuck Ebbert <76306.1226@compuserve.com>
CC: linux-kernel <linux-kernel@vger.kernel.org>,
       Alan Cox <alan@lxorguk.ukuu.org.uk>
Subject: Re: Success: tty_io flush_to_ldisc() error message triggered
References: <200607212301_MC3-1-C5B7-9F6C@compuserve.com>
In-Reply-To: <200607212301_MC3-1-C5B7-9F6C@compuserve.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Chuck Ebbert wrote:
> Using the patch below that you sent me, this message printed today on
> my SMP system when terminating pppd:
> 
>         flush_to_ldisc - TTY_FLUSHING set, low_latency=0
> 
> And this bug is also in 2.6.17.4 - I forgot to reboot into 2.6.16.x
> and the system locked up the same way 2.6.16 used to.  That was made
> even more fun by the 'SysRq broken on SMP' bug fixed by a pending
> 2.6.17.7 patch...

That confirms my thoughts on what went wrong:
multiple copies of the queued work (flush_to_ldisc)
running in parallel and corrupting the free buffer list.

A cleaner fix for this is already
in the 2.6.18 rc series.

Thanks,
Paul

--
Paul Fulghum
Microgate Systems, Ltd.


