Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268771AbUJKKx3@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268771AbUJKKx3 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 11 Oct 2004 06:53:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268775AbUJKKx3
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 11 Oct 2004 06:53:29 -0400
Received: from a26.t1.student.liu.se ([130.236.221.26]:55231 "EHLO
	mail.drzeus.cx") by vger.kernel.org with ESMTP id S268771AbUJKKx1
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 11 Oct 2004 06:53:27 -0400
Message-ID: <416A6623.9000105@drzeus.cx>
Date: Mon, 11 Oct 2004 12:53:23 +0200
From: Pierre Ossman <drzeus-list@drzeus.cx>
User-Agent: Mozilla Thunderbird 0.8 (X11/20040919)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: LKML <linux-kernel@vger.kernel.org>
Subject: Choosing scatter/gather limits
X-Enigmail-Version: 0.84.2.0
X-Enigmail-Supports: pgp-inline, pgp-mime
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I've been adding scatter/gather support for the MMC host driver I'm 
writing. I cannot find any documentation on how to chose the limits though.

The device is an ISA device capable of DMA and PIO transfers. The 
scatter/gather system seems to be designed for PCI but I figured it 
could be used here aswell. Should save the time needed to shuffle stuff 
into a common buffer (or doing a lot of requests).

When in DMA mode the maximum segment size is 64kB (since ISA DMA cannot 
transfer larger blocks). The maximum sector limit should perhaps be 128 
then. I don't know if 512 bytes per sector is something you can rely on. 
The MMC cards can (in theory) choose any sector size they want.

In PIO mode the segment size and sector count doesn't have an upper 
limit. I just traverse the scatter list as I read data.

The segment counts are also unlimited since these parts are handled in 
software.

So how do I choose these values? The segment counts affect memory usage 
(since I have to allocate the scatterlist) but the others are just a 
matter of how much data can be stuffed into one request. Should they be 
set to 0xffffffff then?

Rgds
Pierre Ossman
