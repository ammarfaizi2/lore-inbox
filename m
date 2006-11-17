Return-Path: <linux-kernel-owner+willy=40w.ods.org-S933570AbWKQM5e@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933570AbWKQM5e (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 17 Nov 2006 07:57:34 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S933574AbWKQM5e
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 17 Nov 2006 07:57:34 -0500
Received: from mailhub.sw.ru ([195.214.233.200]:54612 "EHLO relay.sw.ru")
	by vger.kernel.org with ESMTP id S933570AbWKQM5d (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 17 Nov 2006 07:57:33 -0500
Message-ID: <455DB113.4000309@sw.ru>
Date: Fri, 17 Nov 2006 15:54:43 +0300
From: Vasily Averin <vvs@sw.ru>
User-Agent: Thunderbird 1.5.0.7 (X11/20060911)
MIME-Version: 1.0
To: devel@openvz.org
CC: Tejun Heo <htejun@gmail.com>, Jens Axboe <axboe@kernel.dk>,
       linux-kernel@vger.kernel.org,
       Bartlomiej Zolnierkiewicz <B.Zolnierkiewicz@elka.pw.edu.pl>,
       linux-ide@vger.kernel.org, Jeff Garzik <jgarzik@pobox.com>,
       Alan Cox <alan@lxorguk.ukuu.org.uk>
Subject: Re: [Q] workaround for ide (native) leads to irq storm?
References: <453DC2A9.8000507@sw.ru> <453DC65C.8000408@sw.ru>		<454206EE.9080206@sw.ru>	<1161958862.16839.26.camel@localhost.localdomain>	<4559879D.8090105@sw.ru> <455AF01C.5090307@gmail.com> <455C2510.5000002@sw.ru>
In-Reply-To: <455C2510.5000002@sw.ru>
X-Enigmail-Version: 0.94.1.0
Content-Type: text/plain; charset=KOI8-R
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Vasily Averin wrote:
> Tejun Heo wrote:
>> Vasily Averin wrote:
>>> I've reproduced this issue on linux 2.6.19-rc5 kernel.
>>>
>>> Please see http://bugzilla.kernel.org/show_bug.cgi?id=7518 for details
>>
>> Fortunately, libata is immune to the problem because it does 
>> ap->ops->irq_clear(ap) in ata_host_intr() regardless of command type in 
>> flight.  So, not loading IDE piix and using libata to drive all piix 
>> ports solves the problem.
> 
> I've disabled IDE support in the config and recompiled the kernel.
> It seems you are right, problem go away, new kernel was booted without any
> problems and works well.
> 
> As a linux support engeneer I've seen this issue several times on the user-nodes
> and it was very hard to understand what's happened and how to prevent this issue
> in the future. First question is resolved now but from support point of view it
> is very important to find some workaround against this issue on existing
> distributions. Right now I see only one way: if this issue is detected on the
> user node, we can add something like "ide=disable" into kernel commandline.

I've tried to find the some work around for this issue. "hda=noprobe" helps, CD
is not detected on the node and all other devices on the node works well...

However if I have additional device who uses the same irq the issue returns
back. When I enable USB support on my testnode, one of USB controllers requests
the same IRQ line. And IRQ storm occurs again when I load uhci_hcd driver on the
node. It is very strange for me: we do not have any IDE devices in this case.

I would note, that I've seen the same behaviour when I detach the CDROM manually.

I've updated the bug.

Thank you,
	Vasily Averin
