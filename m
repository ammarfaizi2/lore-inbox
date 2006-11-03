Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932487AbWKCXHA@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932487AbWKCXHA (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 3 Nov 2006 18:07:00 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932488AbWKCXHA
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 3 Nov 2006 18:07:00 -0500
Received: from nz-out-0102.google.com ([64.233.162.196]:6206 "EHLO
	nz-out-0102.google.com") by vger.kernel.org with ESMTP
	id S932487AbWKCXHA (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 3 Nov 2006 18:07:00 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:mime-version:content-type:content-transfer-encoding:content-disposition;
        b=LKomz0rXZF6v/6IuDsY+H6A/KZfb9KFL5qWrqrRQLXEUwXVUtrM3Y5zFYLlWUlgzd2CB3Iu+oyoglMKf+K40nTnTvgXUejSAq3VI2UXPWViyAxThG8uzBUkYYdd8F9IhmWrQEZUFOeCbbKc1skO+s6LG6mLlIS3bI7RvmFHvsUA=
Message-ID: <b9481e140611031506u42e326dbs5c0e97d14c5fb5b3@mail.gmail.com>
Date: Sat, 4 Nov 2006 00:06:58 +0100
From: "Nicolas FR" <nicolasfr@gmail.com>
To: linux-kernel@vger.kernel.org
Subject: sc3200 cpu + apm module kernel crash
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

I am currently trying to setup a fully functionnal linux on a Tatung
webpad (shipped with winCE), which has a AMD/NSC SC3200 CPU (more
details on my blog here: http://www.geek-fr.com ). So far everything
goes fine except one thing:

when I try to load the APM module, the kernel crashes. I have tried
different options, but always got the same crash. I have enabled some
verbosing and finally found that the crash is happening in
arch/i386/kernel/apm.c in function static void apm_mainloop(void) when
calling apm_event_handler();

I have thrown a bunch of  "printk(KERN_INFO "apm: I am here\n");" and
noticed the crash is happening just when calling apm_event_handler();
and does not even execute any instruction in this function... This is
the point I don't understand, how can it crash just on calling a
function and not executing the first statement in this function?

Moreover by enabling soft lockup detection I have managed to get those
informations:

==========================
apm: BIOS version 1.2 Flags 0x07 (Driver version 1.16ac)
apm: entry f000:51c8 cseg16 f000 dseg 40 cseg len ffff, dseg ken ffff
cseg16 len ffff
apm: Connection version 1.2
apm: AC on line, battery statys high, battery life 100%
apm: battery flag 0x01, battery life unknown

BUG: soft lockup detected on CPU#0!
[<c011d102>] update_process_times+0x22/0x60
[<c0106441>] timer_interrupt+0x41/0x80
[<c0134773>] handle_IRQ_event+0x33/0x60
[<c0134813>] __do_IRQ+0x73/0xd0
[<c0105171>] do_IRQ+0x31/0x70
[<c0103b1a>] common_interrupt+0x1a/0x20
[<c0409200>] do_cyrix_devid+0x60/0x90
==========================

Any idea on what can be happening here?

Regards,
Nicolas.

PS: please CC me if answering this message, as I am not subscribed to the list
PPS: I have read the list FAQ before posting, but still if this
message is not appropriate to the list, then sorry.
