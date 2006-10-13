Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750727AbWJMNYh@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750727AbWJMNYh (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 13 Oct 2006 09:24:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750730AbWJMNYh
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 13 Oct 2006 09:24:37 -0400
Received: from rosi.naasa.net ([212.8.0.13]:12985 "EHLO rosi.naasa.net")
	by vger.kernel.org with ESMTP id S1750727AbWJMNYg (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 13 Oct 2006 09:24:36 -0400
From: Joerg Platte <lists@naasa.net>
Reply-To: jplatte@naasa.net
To: "=?utf-8?q?G=C3=BCnther?= Starnberger" <gst@sysfrog.org>
Subject: Re: Userspace process may be able to DoS kernel
Date: Fri, 13 Oct 2006 15:24:31 +0200
User-Agent: KMail/1.9.5
Cc: "Pekka Enberg" <penberg@cs.helsinki.fi>, linux-kernel@vger.kernel.org
References: <474c7c2f0610110954y46b68a14q17b88a5e28ffe8d9@mail.gmail.com> <200610122211.16202.lists@naasa.net> <474c7c2f0610121325j23320d36i20c71ccaa04645d9@mail.gmail.com>
In-Reply-To: <474c7c2f0610121325j23320d36i20c71ccaa04645d9@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="utf-8"
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Message-Id: <200610131524.31772.lists@naasa.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Am Donnerstag, 12. Oktober 2006 22:25 schrieb Günther Starnberger:
Hi,

> According to [1] there are several anti-debugging techniques used in
> Skype. I.e. if it notices some sort of debugger it will crash (on
> purpose).

I know. I just wanted to know if I'm able to catch a blocking system call...

> [1]
> www.blackhat.com/presentations/bh-europe-06/bh-eu-06-biondi/bh-eu-06-biondi
>-up.pdf -

Here is my output from a longer lockup today. I can confirm, that pings and 
system time are not affected by the lockup. I didn't try to log in via ssh 
but I think that will not work, too.

Oct 13 15:11:08 localhost kernel: BUG: soft lockup detected on CPU#0!
Oct 13 15:11:08 localhost kernel:  [<c012f9d5>] softlockup_tick+0x89/0xa4
Oct 13 15:11:08 localhost kernel:  [<c011b458>] update_process_times+0x35/0x57
Oct 13 15:11:08 localhost kernel:  [<c01052c9>] timer_interrupt+0x35/0x64
Oct 13 15:11:08 localhost kernel:  [<c012fc13>] handle_IRQ_event+0x23/0x49
Oct 13 15:11:08 localhost kernel:  [<c012fe45>] __do_IRQ+0x7b/0xde
Oct 13 15:11:08 localhost kernel:  [<c010438a>] do_IRQ+0x40/0x4d
Oct 13 15:11:08 localhost kernel:  [<c0102d82>] common_interrupt+0x1a/0x20
Oct 13 15:11:08 localhost kernel:  [<c01e3f0e>] acpi_pm_read+0x7/0xf
Oct 13 15:11:09 localhost kernel:  [<c011a53d>] getnstimeofday+0x2b/0xac
Oct 13 15:11:09 localhost kernel:  [<c01226f4>] sys_clock_gettime+0x42/0x7e
Oct 13 15:11:09 localhost kernel:  [<c0102bfb>] syscall_call+0x7/0xb
Oct 13 15:11:09 localhost kernel: BUG: soft lockup detected on CPU#0!
Oct 13 15:11:09 localhost kernel:  [<c012f9d5>] softlockup_tick+0x89/0xa4
Oct 13 15:11:09 localhost kernel:  [<c011b458>] update_process_times+0x35/0x57
Oct 13 15:11:09 localhost kernel:  [<c01052c9>] timer_interrupt+0x35/0x64
Oct 13 15:11:09 localhost kernel:  [<c012fc13>] handle_IRQ_event+0x23/0x49
Oct 13 15:11:09 localhost kernel:  [<c012fe45>] __do_IRQ+0x7b/0xde
Oct 13 15:11:09 localhost kernel:  [<c010438a>] do_IRQ+0x40/0x4d
Oct 13 15:11:09 localhost kernel:  [<c0102d82>] common_interrupt+0x1a/0x20
Oct 13 15:11:09 localhost kernel:  [<c01e3f0e>] acpi_pm_read+0x7/0xf
Oct 13 15:11:09 localhost kernel:  [<c011a53d>] getnstimeofday+0x2b/0xac
Oct 13 15:11:09 localhost kernel:  [<c01226f4>] sys_clock_gettime+0x42/0x7e
Oct 13 15:11:09 localhost kernel:  [<c0102bfb>] syscall_call+0x7/0xb

Typically I have two lockups, a first longer one and then a shorter one. Then 
everything runs without any problems. 

regards,
Jörg

-- 
PGP Key: send mail with subject 'SEND PGP-KEY' PGP Key-ID: FD 4E 21 1D
PGP Fingerprint: 388A872AFC5649D3 BCEC65778BE0C605
