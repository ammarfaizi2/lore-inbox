Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265279AbTLMXNO (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 13 Dec 2003 18:13:14 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265304AbTLMXNO
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 13 Dec 2003 18:13:14 -0500
Received: from secure.comcen.com.au ([203.23.236.73]:13586 "EHLO
	xavier.etalk.net.au") by vger.kernel.org with ESMTP id S265279AbTLMXNJ convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 13 Dec 2003 18:13:09 -0500
From: Ross Dickson <ross@datscreative.com.au>
Reply-To: ross@datscreative.com.au
Organization: Dat's Creative Pty Ltd
To: Ian Kumlien <pomac@vapor.com>
Subject: Re: Fixes for nforce2 hard lockup, apic, io-apic, udma133 covered
Date: Sun, 14 Dec 2003 09:16:26 +1000
User-Agent: KMail/1.5.1
References: <200312140407.28580.ross@datscreative.com.au> <1071354516.2634.3.camel@big.pomac.com>
In-Reply-To: <1071354516.2634.3.camel@big.pomac.com>
Cc: linux-kernel@vger.kernel.org
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Content-Disposition: inline
Message-Id: <200312140916.26005.ross@datscreative.com.au>
X-MailScanner-Information: Please contact the ISP for more information
X-MailScanner: Found to be clean
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sunday 14 December 2003 08:28, you wrote:
> On Sat, 2003-12-13 at 19:07, Ross Dickson wrote:
> > ..APIC TIMER ack delay, reload:16701, safe:16691
> 
> calibrating APIC timer ...
> ..... CPU clock speed is 2079.0146 MHz.
> ..... host bus clock speed is 332.0663 MHz.
> NET: Registered protocol family 16
> ..APIC TIMER ack delay, reload:20791, safe:20779
> ..APIC TIMER ack delay, predelay count: 20769
> ..APIC TIMER ack delay, predelay count: 20786
> ..APIC TIMER ack delay, predelay count: 20716
> ..APIC TIMER ack delay, predelay count: 20731
> ..APIC TIMER ack delay, predelay count: 20747
> ..APIC TIMER ack delay, predelay count: 20762
> ..APIC TIMER ack delay, predelay count: 20780
> ..APIC TIMER ack delay, predelay count: 20729
> ..APIC TIMER ack delay, predelay count: 20740
> ..APIC TIMER ack delay, predelay count: 20757

Thanks Ian.
>From this we see your local apic is indeed counting 1.2 times faster than mine
ratio of 333/266 fsb. So the reload:20791 - safe:20779 gives 12 counts time.
Given 20791 is 1ms on your system then your 12 counts is 577ns
But more importantly from the ack delay theory as your machine like mine is
prone to lockups then a lockup could likely have occured at count:20786 having
only 240ns time expired. Next worst case was less likely to lockup at count:20780.

The only ones any delay would have been added to by the patch would be the
count:20786 and count:20780 and it would have been just enough to wait until 
the counter got below the safe:20779 so the patch contributes little overhead.
 
> ---
> 
> Survived my greptest which no non patched kernel has ever done on this
> machine.
> 
> Has anyone got that extended ringbuffer to work? I haven't been able to
> get a complete "boot" dmesg in ages because of all the output all the
> drivers make... Does it need a updated dmesg?

This may be what you have already tried:
I am not sure where it is in the 2.6 config or indeed if it is different but it is
CONFIG_LOG_BUF_SHIFT under kernel hacking on 2.4.23 maybe try 16 for 64K.
To match dmesg output try 

dmesg -s65536

(unless dmesg can automatically pick up the expanded ring buffer size on 2.6?)


> (I mean, is this like the non updated gnome-terminal in mdk 9.1 that
> deadlocks on 2.6 if you run some ncurces apps in a "larger than usual"
> window?)
> 
> -- 
> Ian Kumlien <pomac () vapor ! com> -- http://pomac.netswarm.net
> 

