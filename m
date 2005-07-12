Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262404AbVGLUrW@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262404AbVGLUrW (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 12 Jul 2005 16:47:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261945AbVGLUrN
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 12 Jul 2005 16:47:13 -0400
Received: from e4.ny.us.ibm.com ([32.97.182.144]:54189 "EHLO e4.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id S262389AbVGLUp0 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 12 Jul 2005 16:45:26 -0400
Date: Tue, 12 Jul 2005 13:45:21 -0700
From: Mike Anderson <andmike@us.ibm.com>
To: Laurent Riffard <laurent.riffard@free.fr>,
       Alasdair G Kergon <agk@redhat.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: 2.6.13-rc2-mm2 : oops in dm_mod
Message-ID: <20050712204521.GA2483@us.ibm.com>
Mail-Followup-To: Laurent Riffard <laurent.riffard@free.fr>,
	Alasdair G Kergon <agk@redhat.com>, linux-kernel@vger.kernel.org
References: <20050712021724.13b2297a.akpm@osdl.org> <42D41177.9020300@free.fr>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <42D41177.9020300@free.fr>
X-Operating-System: Linux 2.6.8.1
User-Agent: Mutt/1.5.8i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Laurent Riffard [laurent.riffard@free.fr] wrote:
> device-mapper: 4.4.0-ioctl (2005-01-12) initialised: dm-devel@redhat.com
> Unable to handle kernel NULL pointer dereference at virtual address 00000094
>  printing eip:
> d08612ec
> *pde = 00000000
> Oops: 0000 [#1]
> last sysfs file:
> Modules linked in: dm_mod joydev usbhid uhci_hcd usbcore video hotkey configfs
> CPU:    0
> EIP:    0060:[<d08612ec>]    Not tainted VLI
> EFLAGS: 00010246   (2.6.13-rc2-mm2)
> EIP is at suspend_targets+0x8/0x42 [dm_mod]
> eax: 00000000   ebx: cf764340   ecx: 00000000   edx: 00000000
> esi: 00000000   edi: 00000000   ebp: cf06bec4   esp: cf06beb8
> ds: 007b   es: 007b   ss: 0068
> Process lvm2 (pid: 1532, threadinfo=cf06a000 task=cfa3e520)
> Stack: cf764340 00000000 ffffffea cf06becc d0861330 cf06bf20 d085ff99 00000000
>        cfa3e520 c0114664 00000000 00000000 00000000 00000000 00000000 00000000
>        cfa3e520 c0114664 00000000 00000000 00000000 cf06bf20 d0861e0f cf615aa0
> Call Trace:
>  [<c01038e1>] show_stack+0x76/0x7e
>  [<c01039ea>] show_registers+0xea/0x152
>  [<c0103b8e>] die+0xc2/0x13c
>  [<c0113348>] do_page_fault+0x394/0x4d4
>  [<c0103583>] error_code+0x4f/0x54
>  [<d0861330>] dm_table_presuspend_targets+0xa/0xc [dm_mod]
>  [<d085ff99>] dm_suspend+0x79/0x1a3 [dm_mod]
>  [<d0862b51>] do_resume+0xee/0x173 [dm_mod]

I am also receiving a similar oops in a call to suspend_targets on
bootup.

Alasdiar,
Based on your previous patch
http://marc.theaimsgroup.com/?l=linux-kernel&m=112112298922766&w=2

How is suspend_targets suppose to protect against the NULL value now being
passed in. or is something else going on here?


-andmike
--
Michael Anderson
andmike@us.ibm.com

