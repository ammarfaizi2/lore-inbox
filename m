Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1757048AbWKVVoi@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757048AbWKVVoi (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 22 Nov 2006 16:44:38 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1757049AbWKVVoi
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 22 Nov 2006 16:44:38 -0500
Received: from smtp.osdl.org ([65.172.181.25]:62920 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S1757048AbWKVVog (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 22 Nov 2006 16:44:36 -0500
Date: Wed, 22 Nov 2006 13:44:06 -0800
From: Andrew Morton <akpm@osdl.org>
To: "Rafael J. Wysocki" <rjw@sisk.pl>
Cc: LKML <linux-kernel@vger.kernel.org>, Greg KH <greg@kroah.com>
Subject: Re: 2.6.19-rc5-mm2 (end earlier): WARNING at lib/kobject.c:172
 kobject_init() on resume from disk
Message-Id: <20061122134406.f3a30fc4.akpm@osdl.org>
In-Reply-To: <200611222207.07143.rjw@sisk.pl>
References: <200611222207.07143.rjw@sisk.pl>
X-Mailer: Sylpheed version 2.2.7 (GTK+ 2.8.6; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 22 Nov 2006 22:07:06 +0100
"Rafael J. Wysocki" <rjw@sisk.pl> wrote:

> Hi,
> 
> I get similar traces on every resume from disk on SMP systems:
> 
> WARNING at lib/kobject.c:172 kobject_init()
> 
> Call Trace:
>  [<ffffffff80265559>] dump_trace+0xaa/0x3fd
>  [<ffffffff802658e8>] show_trace+0x3c/0x52
>  [<ffffffff80265913>] dump_stack+0x15/0x17
>  [<ffffffff8031c1ad>] kobject_init+0x3f/0x8a
>  [<ffffffff8031c298>] kobject_register+0x1a/0x3e
>  [<ffffffff8038e5b4>] sysdev_register+0x5f/0xec
>  [<ffffffff8026af39>] mce_create_device+0x79/0x103
>  [<ffffffff8026afed>] mce_cpu_callback+0x2a/0xbd
>  [<ffffffff8026112f>] notifier_call_chain+0x29/0x3e
>  [<ffffffff8028e809>] raw_notifier_call_chain+0x9/0xb
>  [<ffffffff80299f18>] _cpu_up+0xc2/0xd5
>  [<ffffffff80299f56>] cpu_up+0x2b/0x42
>  [<ffffffff80299fbb>] enable_nonboot_cpus+0x4e/0x9b
>  [<ffffffff802a35da>] snapshot_ioctl+0x1a0/0x5d2
>  [<ffffffff8023d9cd>] do_ioctl+0x5e/0x77
>  [<ffffffff8022d785>] vfs_ioctl+0x256/0x273
>  [<ffffffff8024770b>] sys_ioctl+0x5f/0x82
>  [<ffffffff8025811e>] system_call+0x7e/0x83
> DWARF2 unwinder stuck at system_call+0x7e/0x83
> Leftover inexact backtrace:
> 
> False positive?
> 

Don't know.  The changelog in
http://www.kernel.org/pub/linux/kernel/people/gregkh/gregkh-2.6/gregkh-01-driver/kobject-warn.patch
is pretty pathetic.

Perhaps mce_remove_device() isn't being called.

<wonders why mce_remove_device() isn't __cpuinit too>  
