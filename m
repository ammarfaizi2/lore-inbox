Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262432AbVDGLqz@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262432AbVDGLqz (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 7 Apr 2005 07:46:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262435AbVDGLqz
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 7 Apr 2005 07:46:55 -0400
Received: from linux01.gwdg.de ([134.76.13.21]:49304 "EHLO linux01.gwdg.de")
	by vger.kernel.org with ESMTP id S262432AbVDGLqv (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 7 Apr 2005 07:46:51 -0400
Date: Thu, 7 Apr 2005 13:46:16 +0200 (MEST)
From: Jan Engelhardt <jengelh@linux01.gwdg.de>
To: rjy <rjy@angelltech.com>
cc: linux-kernel@vger.kernel.org
Subject: Re: init process freezed after run_init_process
In-Reply-To: <4254AB72.8070704@angelltech.com>
Message-ID: <Pine.LNX.4.61.0504071341500.27692@yvahk01.tjqt.qr>
References: <424B7A87.2070100@angelltech.com> <Pine.LNX.4.61.0503311113550.17113@yvahk01.tjqt.qr>
 <4254AB72.8070704@angelltech.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> Thanks for kindly reply, :)
>
> No. I got the same problem without linuxrc.
> As I mount ram0 as root, linuxrc is not necessary. Right?

Apply these rules:
1.) If you do provide an initrd= thing, the initrd is being looked for 
/linuxrc.
2.) If the root is the same as the ramdisk, then the initrd is _not_ run 
_implicitly_, and thus /sbin/init is executed, _instead of_ /linuxrc.

> I missed some driver for VIA platform?  Why it can work without initrd?

Only VIA IDE chipset maybe, but you don't usually need that for just-initrd.
You'd need that for the harddisks...

> After the starting process, the /sbin/init is loaded: I found that in
> a breakpoint of do_schedule. It keeps scheduling init and pdflush.
> I am still finding the way to debug the init process...

Make your own initrd and put a bash into it. Then start that, e.g. (for our 
linux live cd), initrd=initrd.sqfs root=/dev/ram0 init=/bin/bash


Jan Engelhardt
-- 
No TOFU for me, please.
