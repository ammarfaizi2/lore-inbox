Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S274887AbTHPRS6 (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 16 Aug 2003 13:18:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S274888AbTHPRS6
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 16 Aug 2003 13:18:58 -0400
Received: from fw.osdl.org ([65.172.181.6]:9956 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S274887AbTHPRS5 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 16 Aug 2003 13:18:57 -0400
Message-ID: <32828.4.4.25.4.1061054335.squirrel@www.osdl.org>
Date: Sat, 16 Aug 2003 10:18:55 -0700 (PDT)
Subject: Re: increased verbosity in dmesg
From: "Randy.Dunlap" <rddunlap@osdl.org>
To: <gene.heskett@verizon.net>
In-Reply-To: <200308160438.59489.gene.heskett@verizon.net>
References: <200308160438.59489.gene.heskett@verizon.net>
X-Priority: 3
Importance: Normal
Cc: <linux-kernel@vger.kernel.org>
X-Mailer: SquirrelMail (version 1.2.11)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> Greetings;
>
> The recently increased verbosity in the dmesg file is causeing the  "ring
> buffer" to overflow, and I am not now seeing the first few
> pages of the reboot in the dmesg file.
>
> I understand this 'ring' buffer has been expanded to about 16k but  that was
> way back in 2.1 days when that occured according to the
> Documentation.
>
> Is there any quick and dirty way to increase this to at least 32k, or  maybe
> even to 64k?  With half a gig of memory, this shouldn't be a  problem should
> it?
>
> I've done some grepping, but it appears I'm not grepping for the right  var
> name, so I'm coming up blank and need some help.

It's a config option in 2.6 and recent 2.5 kernels if DEBUG_KERNEL
is enabled:

config LOG_BUF_SHIFT
  int "Kernel log buffer size (16 => 64KB, 17 => 128KB)" if DEBUG_KERNEL

In 2.4, edit kernel/printk.c and change the appropriate line:

#if defined(CONFIG_MULTIQUAD) || defined(CONFIG_IA64)
#define LOG_BUF_LEN     (65536)
#elif defined(CONFIG_ARCH_S390)
#define LOG_BUF_LEN     (131072)
#elif defined(CONFIG_SMP)
#define LOG_BUF_LEN     (32768)
#else
#define LOG_BUF_LEN     (16384)                 /* This must be a power of two */
#endif

~Randy



