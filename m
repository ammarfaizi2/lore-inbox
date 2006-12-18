Return-Path: <linux-kernel-owner+w=401wt.eu-S1754550AbWLRUbp@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754550AbWLRUbp (ORCPT <rfc822;w@1wt.eu>);
	Mon, 18 Dec 2006 15:31:45 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754552AbWLRUbp
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 18 Dec 2006 15:31:45 -0500
Received: from tirith.ics.muni.cz ([147.251.4.36]:48519 "EHLO
	tirith.ics.muni.cz" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754550AbWLRUbo (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 18 Dec 2006 15:31:44 -0500
Message-ID: <4586FAA1.8080904@gmail.com>
Date: Mon, 18 Dec 2006 21:31:29 +0100
From: Jiri Slaby <jirislaby@gmail.com>
User-Agent: Thunderbird 2.0a1 (X11/20060724)
MIME-Version: 1.0
To: Ingo Molnar <mingo@elte.hu>
CC: linux-kernel@vger.kernel.org
Subject: Re: bug: isicom: kobject_add failed for ttyM0 with -EEXIST
References: <20061218155714.GA21823@elte.hu> <4586C882.6090906@gmail.com> <20061218200050.GB339@elte.hu>
In-Reply-To: <20061218200050.GB339@elte.hu>
X-Enigmail-Version: 0.94.1.1
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Muni-Spam-TestIP: 147.251.48.3
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Ingo Molnar wrote:
> * Jiri Slaby <jirislaby@gmail.com> wrote:
> 
>> Ingo Molnar wrote:
>>> allyesconfig bzImage bootup produced 33 warning messages, of which the 
>>> first couple are attached below.
>> With which kernel? mxser had ttyM for a long time, it should be fixed 
>> in 2.6.20-rc1.
> 
> current -git.

It's rather impossible. Aren't you seeked somewhere (I'm in
825020c3866e7312947e17a0caa9dd1a5622bafc now)?

Calling initcall 0xc0628d59: isicom_setup+0x0/0x315()
kobject_add failed for ttyM0 with -EEXIST, don't try to register things with the
same name in the same directory.
 [<c0106273>] show_trace_log_lvl+0x34/0x4a
 [<c01063a9>] show_trace+0x2c/0x2e
 [<c01063d6>] dump_stack+0x2b/0x2d
 [<c04f06a3>] kobject_add+0x15f/0x187
 [<c06e3421>] class_device_add+0xb5/0x45c
 [<c06e37e5>] class_device_register+0x1d/0x21
 [<c06e3892>] class_device_create+0xa9/0xcc
 [<c05f8a5c>] tty_register_device+0xe3/0xea

Can't be called from tty_register_driver, since
!(driver->flags & TTY_DRIVER_DYNAMIC_DEV) is false in
http://www.linux-m32r.org/lxr/http/source/drivers/char/tty_io.c#L3756

 [<c05f97fa>] tty_register_driver+0x202/0x21e
 [<c0628fa3>] isicom_setup+0x24a/0x315

Is no longer in the isicom driver.

 [<c0100567>] init+0x178/0x451
 [<c0105feb>] kernel_thread_helper+0x7/0x10
 =======================

regards,
-- 
http://www.fi.muni.cz/~xslaby/            Jiri Slaby
faculty of informatics, masaryk university, brno, cz
e-mail: jirislaby gmail com, gpg pubkey fingerprint:
B674 9967 0407 CE62 ACC8  22A0 32CC 55C3 39D4 7A7E
