Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261402AbVC2UoU@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261402AbVC2UoU (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 29 Mar 2005 15:44:20 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261388AbVC2UnF
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 29 Mar 2005 15:43:05 -0500
Received: from rproxy.gmail.com ([64.233.170.195]:32676 "EHLO rproxy.gmail.com")
	by vger.kernel.org with ESMTP id S261402AbVC2Ukz (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 29 Mar 2005 15:40:55 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:reply-to:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:references;
        b=VEZmEJM8QCsV2j5DB+TEf8gd7hbezp4V0IKaXeb3Ko2ei6PkBm9aMajl2juyJPhM8kf9+vCZYZwio713cAG+Zy3B8fp56gcOMoL0dqDRHhUTcubukPfOX8/EZ+AR6ongKYHXu6OJlyqkeZ4BBDtljhubVWuTmsKG2cAaEFSqyuQ=
Message-ID: <d120d50005032912207bb3dd33@mail.gmail.com>
Date: Tue, 29 Mar 2005 15:20:53 -0500
From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Reply-To: dtor_core@ameritech.net
To: Alexey Dobriyan <adobriyan@mail.ru>
Subject: Re: 2.6.12-rc1-bk2+PREEMPT_BKL: Oops at serio_interrupt
Cc: linux-kernel@vger.kernel.org, Vojtech Pavlik <vojtech@suse.cz>
In-Reply-To: <200503292349.55319.adobriyan@mail.ru>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
References: <200503282126.55366.adobriyan@mail.ru>
	 <200503292128.20140.adobriyan@mail.ru>
	 <d120d50005032911027c13436e@mail.gmail.com>
	 <200503292349.55319.adobriyan@mail.ru>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 29 Mar 2005 23:49:55 +0400, Alexey Dobriyan <adobriyan@mail.ru> wrote:
> On Tuesday 29 March 2005 23:02, Dmitry Torokhov wrote:
> > On Tue, 29 Mar 2005 21:28:20 +0400, Alexey Dobriyan <adobriyan@mail.ru> wrote:
> > > On Tuesday 29 March 2005 10:27, Dmitry Torokhov wrote:
> > > > On Monday 28 March 2005 12:26, Alexey Dobriyan wrote:
> > > > > Steps to reproduce for me:
> > > > >     * Boot CONFIG_PREEMPT_BKL=y kernel (.config, dmesg are attached)
> > > > >     * Start rebooting
> > > > >     * Start moving serial mouse (I have Genius NetMouse Pro)
> > > > >     * Right after gpm is shut down I see the oops
> > > > >     * The system continues to reboot
> > > >
> > > > Could you try the patch below, please? Thanks!
> > >
> > > > Input: serport - fix an Oops when closing port - should not call
> > > >        serio_interrupt when serio port is being unregistered.
> > >
> > > Doesn't work, sorry. Even worse: rebooting now also produces many pages of
> > > oopsen, then hang the system. I'm willing to test any new patches.
> >
> > Does it oops at the same place with this patch or at some other place?
> 
> I manage to find this in the logs (nothing more :-( ):
> ============================================================================
> Unable to handle kernel NULL pointer dereference at virtual address 00000068
> printing eip:
> c0202947
> *pde = 00000000
> Oops: 0000 [#1]
> PREEMPT
> Modules linked in: ipt_REJECT ipt_state ip_conntrack iptable_filter ip_tables binfmt_misc uhci_hcd snd_intel8x0 snd_ac97_codec snd_pcm snd_timer snd soundcore snd_page_alloc floppy
> CPU:    0
> EIP:    0060:[<c0202947>]    Not tainted VLI
> EFLAGS: 00010282   (2.6.12-rc1-bk2-serio)
> ============================================================================
> According to vmlinux, c0202947 is at:
> 
> c020293e <serport_ldisc_write_wakeup>:

Ok, I have seen this OOPS before - it is a bit different scenario and
I am trying to look into it.

-- 
Dmitry
