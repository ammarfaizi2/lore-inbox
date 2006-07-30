Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964786AbWG3XMm@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964786AbWG3XMm (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 30 Jul 2006 19:12:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964787AbWG3XMm
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 30 Jul 2006 19:12:42 -0400
Received: from mailer.gwdg.de ([134.76.10.26]:7092 "EHLO mailer.gwdg.de")
	by vger.kernel.org with ESMTP id S964786AbWG3XMl (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 30 Jul 2006 19:12:41 -0400
Date: Mon, 31 Jul 2006 01:11:51 +0200 (MEST)
From: Jan Engelhardt <jengelh@linux01.gwdg.de>
To: Avi Kivity <avi@argo.co.il>
cc: Jiri Slaby <jirislaby@gmail.com>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: FP in kernelspace
In-Reply-To: <44CCFA5A.2030605@argo.co.il>
Message-ID: <Pine.LNX.4.61.0607310110180.11084@yvahk01.tjqt.qr>
References: <Pine.LNX.4.61.0607302018110.25626@yvahk01.tjqt.qr>
 <44CCFA5A.2030605@argo.co.il>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
X-Spam-Report: Content analysis: 0.0 points, 6.0 required
	_SUMMARY_
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>> > kernel_fpu_begin();
>> > c = d * 3.14;
>> > kernel_fpu_end();
>> 
>> static inline void kernel_fpu_begin() {
>> ...
>> preempt_disable();
>> ...
>> }
>> 
> Is the kernel allowed to clobber userspace's sse registers?

As long as you save and restore it properly, and make it look like to all 
other threads that nothing happened, you are (I hope) free to do anything.

> What about interrupt code?

You do not want to go there...

> xor.h at least appears to save the sse state before use.
>
> -- 
> Do not meddle in the internals of kernels, for they are subtle and quick to
> panic.

Follow that advice, don't do FP. But OTOH......<long dots> there is already 
an SSE player in the kernel: drivers/md/raid6sse*.c


Jan Engelhardt
-- 
