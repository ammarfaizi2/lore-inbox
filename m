Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932230AbVKXQ5e@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932230AbVKXQ5e (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 24 Nov 2005 11:57:34 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932438AbVKXQ5e
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 24 Nov 2005 11:57:34 -0500
Received: from onyx.ip.pt ([195.23.92.252]:38337 "EHLO mail.isp.novis.pt")
	by vger.kernel.org with ESMTP id S932230AbVKXQ5d (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 24 Nov 2005 11:57:33 -0500
Subject: Re: Oops in 2.6.15-rc1
From: Ricardo Cerqueira <rmcc@linuxtv.org>
To: Brian Marete <bgmarete@gmail.com>
Cc: Mauro Carvalho Chehab <mchehab@brturbo.com.br>,
       linux-kernel@vger.kernel.org
In-Reply-To: <6dd519ae0511240209y712549bep6ba626134bb6f502@mail.gmail.com>
References: <6dd519ae0511240209y712549bep6ba626134bb6f502@mail.gmail.com>
Content-Type: text/plain
Organization: video4linux
Date: Thu, 24 Nov 2005 16:56:53 +0000
Message-Id: <1132851413.3229.12.camel@frolic>
Mime-Version: 1.0
X-Mailer: Evolution 2.4.1 (2.4.1-7) 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello;

On Thu, 2005-11-24 at 10:09 +0000, Brian Marete wrote:

[snip]

> saa7130[0]: option to override the default value.
> Unable to handle kernel NULL pointer dereference at virtual address 000006d0
>  printing eip:
> c0299163
> *pde = 00000000
> Oops: 0000 [#1]
> PREEMPT
> Modules linked in: saa7134 video_buf v4l2_common v4l1_compat ir_common
> videodev via_agp agpgart snd_via82xx snd_ac97_codec snd_ac97_bus
> snd_mpu401_uart snd_rawmidi snd_seq_device snd_rtctimer snd_pcm_oss
> snd_pcm snd_timer snd_page_alloc snd_mixer_oss snd soundcore video fan
> button thermal processor via_rhine fuse md5 ipv6 loop rtc pcspkr
> ide_cd cdrom dm_mod
> CPU:    0
> EIP:    0060:[<c0299163>]    Not tainted VLI
> EFLAGS: 00010296   (2.6.15-rc1)
> EIP is at input_register_device+0x9/0x180

This is due to a bug that's already been identified in v4l's input
support, caused by recent changes in the kernel's own input layer. A
patch has been proposed at the v4l list but it hasn't been tested yet. 
A good way to skip this for now is to add "options saa7134 disable_ir=1"
to you modprobe.conf.
Be aware that v4l @ rc1 has other problems related to kernel VMA changes
that render video-buf unusable, and have been fixed after the release of
rc1. You may want to try the latest -mm.

--
RC

