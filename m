Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265437AbSLJTd7>; Tue, 10 Dec 2002 14:33:59 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265587AbSLJTd7>; Tue, 10 Dec 2002 14:33:59 -0500
Received: from packet.digeo.com ([12.110.80.53]:5558 "EHLO packet.digeo.com")
	by vger.kernel.org with ESMTP id <S265437AbSLJTd6>;
	Tue, 10 Dec 2002 14:33:58 -0500
Message-ID: <3DF64369.81F288FE@digeo.com>
Date: Tue, 10 Dec 2002 11:41:29 -0800
From: Andrew Morton <akpm@digeo.com>
X-Mailer: Mozilla 4.79 [en] (X11; U; Linux 2.5.46 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: "Randy.Dunlap" <rddunlap@osdl.org>
CC: linux-kernel@vger.kernel.org
Subject: Re: move LOG_BUF_SIZE to header file
References: <Pine.LNX.4.33L2.0212101108550.12283-100000@dragon.pdx.osdl.net>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-OriginalArrivalTime: 10 Dec 2002 19:41:36.0530 (UTC) FILETIME=[26B4B720:01C2A084]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

"Randy.Dunlap" wrote:
> 
> Hi,
> 
> I'd like to see LOG_BUF_LEN from kernel/printk.c moved to a header file
> so that some non-kernel (kernel-mode) tools can know the value being
> used (tools like kmsgdump or lkcd etc.).
> 
> This patch moves LOG_BUF_LEN to include/linux/kernel.h .
> Or it could go to a separate (new) header file...
> 
> ...
> -#if defined(CONFIG_X86_NUMAQ) || defined(CONFIG_IA64)
> -#define LOG_BUF_LEN    (65536)
> -#elif defined(CONFIG_ARCH_S390)
> -#define LOG_BUF_LEN    (131072)
> -#elif defined(CONFIG_SMP)
> -#define LOG_BUF_LEN    (32768)
> -#else
> -#define LOG_BUF_LEN    (16384)                 /* This must be a power of two */
> -#endif
> -
> -#define LOG_BUF_MASK   (LOG_BUF_LEN-1)

It's probably better to move all this gunk into the config
system.  Then your app can use CONFIG_LOG_BUF_LEN, too.
