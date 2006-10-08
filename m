Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932076AbWJHWpP@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932076AbWJHWpP (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 8 Oct 2006 18:45:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932077AbWJHWpP
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 8 Oct 2006 18:45:15 -0400
Received: from 1wt.eu ([62.212.114.60]:24324 "EHLO 1wt.eu")
	by vger.kernel.org with ESMTP id S932076AbWJHWpN (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 8 Oct 2006 18:45:13 -0400
Date: Mon, 9 Oct 2006 00:44:40 +0200
From: Willy Tarreau <w@1wt.eu>
To: Jan Kiszka <jan.kiszka@web.de>
Cc: linux-kernel@vger.kernel.org, Willy Tarreau <wtarreau@hera.kernel.org>
Subject: Re: 2.4.x: i386/x86_64 bitops clobberings
Message-ID: <20061008224440.GA30172@1wt.eu>
References: <452970AF.8020605@web.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <452970AF.8020605@web.de>
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Jan,

On Sun, Oct 08, 2006 at 11:42:07PM +0200, Jan Kiszka wrote:
> Hi,
> 
> after going through debugging hell with some out-of-tree code, I
> realised that this patch
> 
> http://www.kernel.org/git/?p=linux/kernel/git/torvalds/linux-2.6.git;a=commit;h=92934bcbf96bc9dc931c40ca5f1a57685b7b813b
> 
> makes a difference: current 2.6 works with the following code sequence
> as expected (printk is executed), 2.4 fails.
> 
> 
> #include <asm/bitops.h>
> #include <linux/module.h>
> 
> unsigned long a = 1;
> 
> int module_init(void)
> {
> 	unsigned long b = 0;
> 	int x;
> 
> 	x = __test_and_set_bit(0, &b);
> 	if (__test_and_set_bit(0, &a))
> 		printk("x = %d\n", x);
> 
> 	return -1;
> }
> 
> 
> There will likely be a way to work around my issue. Nevertheless, I
> wondered if that patch was already considered for 2.4 inclusion. Or is
> there no risk that in-tree code is affected?

While I remember some discussion on the subject for 2.6, I don't
recall anything similiar in 2.4. Wouldn't you happen to build with
gcc-3.4 ? IIRC, the clobbering changed around this version. Could
you confirm that the patch you pointed above fixes the problem for
your case ?

Thanks in advance,
Willy

