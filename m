Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263767AbTJ0XgV (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 27 Oct 2003 18:36:21 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263769AbTJ0XgU
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 27 Oct 2003 18:36:20 -0500
Received: from mail-05.iinet.net.au ([203.59.3.37]:7657 "HELO
	mail.iinet.net.au") by vger.kernel.org with SMTP id S263767AbTJ0XgP
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 27 Oct 2003 18:36:15 -0500
Message-ID: <3F9DABE6.7050501@cyberone.com.au>
Date: Tue, 28 Oct 2003 10:36:06 +1100
From: Nick Piggin <piggin@cyberone.com.au>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.4) Gecko/20030827 Debian/1.4-3
X-Accept-Language: en
MIME-Version: 1.0
To: Mr Amit Patel <patelamitv@YAHOO.COM>
CC: Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org
Subject: Re: as_arq scheduler alloc with 2.6.0-test8-mm1
References: <20031027175935.15690.qmail@web13005.mail.yahoo.com>
In-Reply-To: <20031027175935.15690.qmail@web13005.mail.yahoo.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



Mr Amit Patel wrote:

>Hi Andrew,
>
>The qlogic driver is for Fibre Channel HBA QLA2342.
>This is a beta driver which is part of the mjb1 patch
>against 2.6.0-test8. As a part of driver insmod,
>driver tries to find fiber channel device and maps it
>to scsi block device. Actually I don't have any fibre
>channel target attached, so driver does not find any
>scsi devices and discovery finishes without adding any
>block device. 
>
>I am trying to go through driver scsi_scan process and
>see when does actual allocation from as_arq happens.
>But for some reason after going to kgdb I get SIGEMT
>and I cannot debug further. What is causing SIGEMT
>cause after doing some search looks like its actually
>SIGUSR but linux treats it as SIGEMT. Is there any way
>to prevent SIGEMT when I want to use kgdb ? 
>
>Thanks for your help,
>

Hi Amit,

I'm a little bit busy to look at this now, however someone
is looking into all these refcounting problems.

If you would like to narrow it down a bit, check that the
request queues that are allocated are all released when the
driver is unloaded (drivers/block/ll_rw_blk.c blk_alloc_queue
and blk_cleanup_queue). Just stick a couple of printks there
if your debugger isn't working.


