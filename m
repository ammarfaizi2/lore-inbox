Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S266702AbSL3FN2>; Mon, 30 Dec 2002 00:13:28 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S266708AbSL3FN2>; Mon, 30 Dec 2002 00:13:28 -0500
Received: from packet.digeo.com ([12.110.80.53]:25595 "EHLO packet.digeo.com")
	by vger.kernel.org with ESMTP id <S266702AbSL3FN2>;
	Mon, 30 Dec 2002 00:13:28 -0500
Message-ID: <3E0FD7E4.A3EB612D@digeo.com>
Date: Sun, 29 Dec 2002 21:21:40 -0800
From: Andrew Morton <akpm@digeo.com>
X-Mailer: Mozilla 4.79 [en] (X11; U; Linux 2.5.52 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: khromy <khromy@lnuxlab.ath.cx>
CC: linux-kernel@vger.kernel.org
Subject: Re: 2.5.53-mm2 timing problems
References: <20021230045335.GA26066@lnuxlab.ath.cx>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-OriginalArrivalTime: 30 Dec 2002 05:21:43.0706 (UTC) FILETIME=[573F87A0:01C2AFC3]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

khromy wrote:
> 
> When playing netris, the shapes fall a lot faster in 2.5.53-mm2 than in
> 2.4.20 and in 2.5.53.  Also, the login prompt says "login timed out
> after 60 seconds" when only about 10-15 have passed.

Seems that this is because different parts of the kernel are using
different values of HZ (!).

In include/asm-i386/param.h, please add:

 #ifdef __KERNEL__

+#include <linux/config.h>

 #ifdef CONFIG_1000HZ
