Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261448AbVGLNeQ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261448AbVGLNeQ (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 12 Jul 2005 09:34:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261441AbVGLNc0
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 12 Jul 2005 09:32:26 -0400
Received: from alog0255.analogic.com ([208.224.222.31]:41933 "EHLO
	chaos.analogic.com") by vger.kernel.org with ESMTP id S261439AbVGLNcC
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 12 Jul 2005 09:32:02 -0400
Date: Tue, 12 Jul 2005 09:30:27 -0400 (EDT)
From: "Richard B. Johnson" <linux-os@analogic.com>
Reply-To: linux-os@analogic.com
To: Mateusz Berezecki <mateuszb@gmail.com>
cc: LKML <linux-kernel@vger.kernel.org>
Subject: Re: "scheduling while atomic" ? 
In-Reply-To: <42D3C37C.6040401@gmail.com>
Message-ID: <Pine.LNX.4.61.0507120925540.2929@chaos.analogic.com>
References: <42D3C37C.6040401@gmail.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII; format=flowed
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 12 Jul 2005, Mateusz Berezecki wrote:

> Hi LKML,
>
> What does the message saying "scheduling while atomic" mean?
>
> The kernel prints a stack backtrace after this message appears so I
> suppose this is
> not a good behaviour. I am finishing an open source driver, and I need
> to do all of this
> locking stuff, etc. and this really makes me wonder what I am doing wrong.
>
> here is some part of a backtrace...
>
> scheduling while atomic: insmod/0x00000001/12692
> [<c03e7352>] schedule+0x632/0x640
> [<c0119bb1>] __wake_up_common+0x41/0x70
> [<c03e74df>] wait_for_completion+0x8f/0xf0
> [<c0119b50>] default_wake_function+0x0/0x20
> [<c0119b50>] default_wake_function+0x0/0x20
> [<c012e2dd>] queue_work+0x8d/0xa0
> [<c012e070>] __call_usermodehelper+0x0/0x70
> [<c012e1a5>] call_usermodehelper_keys+0xc5/0xd0
> [<c012e070>] __call_usermodehelper+0x0/0x70
> [<c020c028>] sprintf+0x28/0x30
> [<c020955d>] kobject_hotplug+0x29d/0x310
> [<c019fc6e>] sysfs_create_link+0x3e/0x60
> [<c028b601>] class_device_add+0x161/0x1e0
> [<c036f38e>] netdev_register_sysfs+0x3e/0x100
> [<c03650db>] netdev_run_todo+0x1eb/0x220
> [<c0364dce>] register_netdev+0x5e/0x90
>
> I enable a lock at the beginning of device attach routine
> and I disable it at the end. Whats wrong with it?

You probably have the interrupts disabled (a spin-lock locked)
when some timer or other routine that will schedule() is called.

Also, make sure that you initialize all your spin-locks and
semaphores before you try to use them.


Cheers,
Dick Johnson
Penguin : Linux version 2.6.12 on an i686 machine (5537.79 BogoMips).
  Notice : All mail here is now cached for review by Dictator Bush.
                  98.36% of all statistics are fiction.
