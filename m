Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S273030AbTHFFXq (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 6 Aug 2003 01:23:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S274820AbTHFFXq
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 6 Aug 2003 01:23:46 -0400
Received: from fw.osdl.org ([65.172.181.6]:17120 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S273030AbTHFFXV (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 6 Aug 2003 01:23:21 -0400
Message-Id: <200308060523.h765NII31787@mail.osdl.org>
From: OSDL <torvalds@osdl.org>
Subject: Re: 2.6.0-test2 oops - NPTL triggered
To: Greg Schafer <gschafer@zip.com.au>, linux-kernel@vger.kernel.org
Reply-To: torvalds@osdl.org
Date: Tue, 05 Aug 2003 22:23:18 -0700
References: <20030806021316.GA408@tigers-lfs.nsw.bigpond.net.au>
Organization: OSDL
User-Agent: KNode/0.7.2
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7Bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Greg Schafer wrote:
> 
> An otherwise fine running kernel-2.6.0-test2 repeatably gives this when
> running the NPTL testsuite.
> 
> ksymoops output attached.
> 
>  - kernel compiled with gcc-2.95.4 (s'pose I should try 3.2.3)
>  - recent binutils
>  - board is Tyan S2466N-4M with pair of Athlon 2200's
> 
> This is a UP kernel (trying to narrow down the cause).

It looks like the list poisoning triggers:

        ecx: 00200200 edx: 00100100

those are the poison values for the prev/next fields of lists (see
<linux/list.h>).

So it looks like switch_exec_pids() is removing a list entry that was
already removed.

                Linus
