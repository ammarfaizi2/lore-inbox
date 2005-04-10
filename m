Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261486AbVDJMjh@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261486AbVDJMjh (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 10 Apr 2005 08:39:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261488AbVDJMjh
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 10 Apr 2005 08:39:37 -0400
Received: from wproxy.gmail.com ([64.233.184.193]:56875 "EHLO wproxy.gmail.com")
	by vger.kernel.org with ESMTP id S261486AbVDJMj3 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 10 Apr 2005 08:39:29 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:reply-to:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:references;
        b=HvngBuvlTMdH/V9KGzWbwMrETHeCZj2x1pPtLdQbWQOTbAwC5KRgBQW7jVQL/JcMhEv4CsVx+IOqaQ11BAtycRwq7ZhpYD8KZIbTgviETWuMveF6WdE8XSGsT0N2MDdUefA1TEpw3UayHYooAcTFbeeObbY3wDaf0OtuN9c2W8M=
Message-ID: <58cb370e0504100539274f5df7@mail.gmail.com>
Date: Sun, 10 Apr 2005 14:39:26 +0200
From: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
Reply-To: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
To: "joram.agten@pandora.be" <joram.agten@pandora.be>
Subject: Re: PROBLEM: kernel 2.4 pdc202xx and kernel 2.6 pdc202xx_old Broken
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <000701c53dc6$8246e3b0$0505a8c0@cheopsturbo>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
References: <000701c53dc6$8246e3b0$0505a8c0@cheopsturbo>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Apr 10, 2005 2:12 PM, joram.agten@pandora.be <joram.agten@pandora.be> wrote:
> Hello
> 
> please put me in CC
> 
> I'm using a pdc20262 promise utra66 controller to manage 4 HD's, all 30GB
> and I put them in a software /dev/md/0 raid5 configuration
> 
> recently I upgraded my kernel to linux-2.6.11-gentoo-r4 and also
> linux-2.6.11-gentoo-r5
> and the raid array would go offline with dma timeouts when putting load to
> it
> 
> Apr  9 23:30:15 vennen hde: DMA timeout error
> Apr  9 23:30:15 vennen hde: dma timeout error: status=0x58 { DriveReady
> SeekComplete DataRequest }
> Apr  9 23:30:15 vennen
> Apr  9 23:30:15 vennen ide: failed opcode was: unknown
> Apr  9 23:30:15 vennen hdh: dma_timer_expiry: dma status == 0x62
> Apr  9 23:30:15 vennen hdh: DMA timeout error
> Apr  9 23:30:15 vennen hdh: dma timeout error: status=0x58 { DriveReady
> SeekComplete DataRequest }
> Apr  9 23:30:15 vennen
> Apr  9 23:30:15 vennen ide: failed opcode was: unknown
> Apr  9 23:30:15 vennen hdg: status timeout: status=0xd0 { Busy }
> Apr  9 23:30:15 vennen
> Apr  9 23:30:15 vennen ide: failed opcode was: unknown
> Apr  9 23:30:15 vennen hdg: DMA disabled
> Apr  9 23:30:15 vennen PDC202XX: Secondary channel reset.
> Apr  9 23:30:15 vennen PDC202XX: Primary channel reset.

This is a buggy expiry handler but it gets triggered as a result of
earlier OOPS:

Apr  9 23:30:01 vennen Call Trace:
Apr  9 23:30:01 vennen [] _spin_lock+0x16/0x90
Apr  9 23:30:01 vennen [] _spin_unlock+0xd/0x30
Apr  9 23:30:01 vennen [] do_truncate+0x4a/0x70
Apr  9 23:30:01 vennen [] _spin_unlock_irqrestore+0xf/0x30
Apr  9 23:30:01 vennen [] do_coredump+0x1fd/0x216
Apr  9 23:30:01 vennen [] __dequeue_signal+0xf5/0x1b0
Apr  9 23:30:01 vennen [] dequeue_signal+0x35/0xd0
Apr  9 23:30:01 vennen [] get_signal_to_deliver+0x229/0x320
Apr  9 23:30:01 vennen [] do_signal+0x9b/0x130
Apr  9 23:30:01 vennen [] sys_rt_sigaction+0xaa/0xc0
Apr  9 23:30:01 vennen [] do_page_fault+0x0/0x5d5
Apr  9 23:30:01 vennen [] do_notify_resume+0x37/0x3c
Apr  9 23:30:01 vennen [] work_notifysig+0x13/0x15

which doesn't seem to be related to IDE in any way.

It would be useful if you pinpoint issue further to a specific kernel version.

Bartlomiej
