Return-Path: <linux-kernel-owner+willy=40w.ods.org-S265354AbUGMPcR@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265354AbUGMPcR (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 13 Jul 2004 11:32:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265356AbUGMPcR
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 13 Jul 2004 11:32:17 -0400
Received: from tristate.vision.ee ([194.204.30.144]:30632 "HELO mail.city.ee")
	by vger.kernel.org with SMTP id S265354AbUGMPcP (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 13 Jul 2004 11:32:15 -0400
Message-ID: <40F40080.8010801@vision.ee>
Date: Tue, 13 Jul 2004 18:32:16 +0300
From: =?ISO-8859-1?Q?Lenar_L=F5hmus?= <lenar@vision.ee>
Organization: Vision
User-Agent: Mozilla Thunderbird 0.7.1 (X11/20040705)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: William Lee Irwin III <wli@holomorphy.com>, linux-kernel@vger.kernel.org
Subject: Re: preempt-timing-2.6.8-rc1
References: <20040713122805.GZ21066@holomorphy.com> <40F3F0A0.9080100@vision.ee> <20040713143947.GG21066@holomorphy.com>
In-Reply-To: <20040713143947.GG21066@holomorphy.com>
X-Enigmail-Version: 0.84.2.0
X-Enigmail-Supports: pgp-inline, pgp-mime
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

William Lee Irwin III wrote:

>Wild guess is that you took an IRQ in dec_preempt_count() and that threw
>your results off. Let me know if the patch below helps at all. My guess
>is it'll cause more apparent problems than it solves.
>
Machine in question is XP2500+@1.84GHz (it was overlocked@2.25GHz during 
last test, now running at
official speed). Is this really slow for 1ms?

Applied your patch. Booted.

With preempt_thresh=1 I still got tons of those violations at schedule().

With preempt_thresh=2 I do not get those anymore. Apart from sys_ioctl() 
violation, getting now these:

16ms non-preemptible critical section violated 2 ms preempt threshold 
starting at exit_notify+0x1d/0x7b0 and ending at schedule+0x291/0x480
7ms non-preemptible critical section violated 2 ms preempt threshold 
starting at kmap_atomic+0x13/0x70 and ending at kunmap_atomic+0x5/0x20
6ms non-preemptible critical section violated 2 ms preempt threshold 
starting at fget+0x28/0x70 and ending at fget+0x41/0x70

No apparent side-effects noticed.

As before, when running mplayer I'm getting many sys_ioctl() things 
coupled with messages:
rtc: lost some interrupts at 1024Hz.
It happens when madly seeking around in video.

Lenar

