Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S281318AbRKQKcy>; Sat, 17 Nov 2001 05:32:54 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S281319AbRKQKcp>; Sat, 17 Nov 2001 05:32:45 -0500
Received: from gw.chygwyn.com ([62.172.158.50]:61453 "EHLO gw.chygwyn.com")
	by vger.kernel.org with ESMTP id <S281318AbRKQKcc>;
	Sat, 17 Nov 2001 05:32:32 -0500
From: Steven Whitehouse <steve@gw.chygwyn.com>
Message-Id: <200111171027.KAA18835@gw.chygwyn.com>
Subject: Re: The memory usage of the network block device
To: chen_xiangping@emc.com (chen, xiangping)
Date: Sat, 17 Nov 2001 10:27:30 +0000 (GMT)
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <FA2F59D0E55B4B4892EA076FF8704F553D1891@srgraham.eng.emc.com> from "chen, xiangping" at Nov 16, 2001 03:44:48 PM
Organization: ChyGywn Limited
X-RegisteredOffice: 7, New Yatt Road, Witney, Oxfordshire. OX28 1NU England
X-RegisteredNumber: 03887683
Reply-To: Steve Whitehouse <Steve@ChyGwyn.com>
X-Mailer: ELM [version 2.5 PL1]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

> 
> Hi,
> 
> I changed a setup to make the server response quicker, and the 
> client slower. Looks OK now. So the problem seems like too many
> pending tcp requests stucks the client system. Is there any good
> way to control the flow or pending requests of the system? I 
> tried to set some threshold in do_nbd_requests, only blocks the
> processes in _get_request_wait() which is not I wanted.
> 
> Thanks,
> 
> Xiangping
> 
> 

I did wonder about that whih was why I asked the question about the tcp_*mem
settings. I guess that if that is the case either you can increase the tcp_*mem
settings or make the maximum number of blocks merged into a single request
lower. Personally I'd go for the former solution, all you need to do is select
suitable numbers to set for these files (see 
linux/Documentation/networking/ip-sysctl.txt for their exact meaning). If
this does turn out to be the problem, then you'll need to make the config
changes on both server and client as they can both send maximum sized requests
(128 (MAX_SEGMENTS) sectors plus the size of the header).

To reduce the request size you can alter MAX_SEGMENTS in blkdev.h but this
isn't really a very good solution as it reduces the ability to merge I/O
for local disks.

Steve.

