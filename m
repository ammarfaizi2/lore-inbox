Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267860AbUH1VLz@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267860AbUH1VLz (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 28 Aug 2004 17:11:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267926AbUH1VLz
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 28 Aug 2004 17:11:55 -0400
Received: from viper.oldcity.dca.net ([216.158.38.4]:27828 "HELO
	viper.oldcity.dca.net") by vger.kernel.org with SMTP
	id S267860AbUH1VKr (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 28 Aug 2004 17:10:47 -0400
Subject: Re: [patch] voluntary-preempt-2.6.9-rc1-bk4-Q3
From: Lee Revell <rlrevell@joe-job.com>
To: Ingo Molnar <mingo@elte.hu>
Cc: Daniel Schmitt <pnambic@unu.nu>, "K.R. Foley" <kr@cybsft.com>,
       Felipe Alfaro Solana <lkml@felipe-alfaro.com>,
       linux-kernel <linux-kernel@vger.kernel.org>,
       Mark_H_Johnson@raytheon.com
In-Reply-To: <20040828203116.GA29686@elte.hu>
References: <20040823221816.GA31671@yoda.timesys>
	 <1093715573.8611.38.camel@krustophenia.net>
	 <20040828194449.GA25732@elte.hu> <200408282210.03568.pnambic@unu.nu>
	 <20040828203116.GA29686@elte.hu>
Content-Type: text/plain
Message-Id: <1093727453.8611.71.camel@krustophenia.net>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6 
Date: Sat, 28 Aug 2004 17:10:53 -0400
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 2004-08-28 at 16:31, Ingo Molnar wrote:
>   http://redhat.com/~mingo/voluntary-preempt/voluntary-preempt-2.6.9-rc1-bk4-Q3
> 

I get this error: 

WARNING: /lib/modules/2.6.9-rc1-Q3/kernel/fs/ntfs/ntfs.ko needs unknown symbol unlock_kernel
WARNING: /lib/modules/2.6.9-rc1-Q3/kernel/fs/ntfs/ntfs.ko needs unknown symbol lock_kernel

I believe this is the correct fix:

--- fs/ntfs/super.c~	2004-08-28 16:31:33.000000000 -0400
+++ fs/ntfs/super.c	2004-08-28 17:08:11.000000000 -0400
@@ -29,6 +29,7 @@
 #include <linux/buffer_head.h>
 #include <linux/vfs.h>
 #include <linux/moduleparam.h>
+#include <linux/smp_lock.h>
 
 #include "ntfs.h"
 #include "sysctl.h"

Lee

