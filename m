Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932617AbVKBHXL@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932617AbVKBHXL (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 2 Nov 2005 02:23:11 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932615AbVKBHXL
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 2 Nov 2005 02:23:11 -0500
Received: from smtp.osdl.org ([65.172.181.4]:37807 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S932596AbVKBHXK (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 2 Nov 2005 02:23:10 -0500
Date: Wed, 2 Nov 2005 17:21:44 +1100
From: Andrew Morton <akpm@osdl.org>
To: Masanari Iida <standby24x7@gmail.com>
Cc: stern@rowland.harvard.edu, linux-kernel@vger.kernel.org,
       linux-scsi@vger.kernel.org, linux-usb-devel@lists.sourceforge.net
Subject: Re: [linux-usb-devel] Re: oops with USB Storage on 2.6.14
Message-Id: <20051102172144.757fe643.akpm@osdl.org>
In-Reply-To: <38bdcd1f0511011856i3780bf55q3013956dc7e06e3e@mail.gmail.com>
References: <20051030170244.4a8c06b7.akpm@osdl.org>
	<Pine.LNX.4.44L0.0510311055270.13355-100000@iolanthe.rowland.org>
	<38bdcd1f0511011856i3780bf55q3013956dc7e06e3e@mail.gmail.com>
X-Mailer: Sylpheed version 1.0.0 (GTK+ 1.2.10; i386-vine-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Masanari Iida <standby24x7@gmail.com> wrote:
>
> On 11/1/05, Alan Stern <stern@rowland.harvard.edu> wrote:
> > On Sun, 30 Oct 2005, Andrew Morton wrote:
> >
> > > Masanari Iida <standby24x7@gmail.com> wrote:
> >
> > > > Hello Andrew,
> > > >
> > > > I did disabled CONFIG_DEBUG_PAGEALLOC and re-tested on 2.6.14-rc1.
> > > > Now the oops didn't happen when I connect digital camera to the USB.
> > >
> > > So the first oops was probably use-after-free.
> > >
> > > > I could mount the camera as USB storage.
> > > > But oops still happen when I turned the camera power off.
> > > > (This oops didn't halt my system, BTW)
> > > >
> > > > # Unable to handle kernel paging request at virtual address 6b6b6bb3
> > > >   printing eip:
> > > > c02b88ca
> > > > *pde = 00000000
> > > > Oops: 0002 [#1]
> > > > SMP
> > > > Modules linked in: autofs e100 ipt_LOG ipt_state ip_conntrack
> > > > ipt_recent iptable_filter ip_tables video rtc
> > > > CPU:    0
> > > > EIP:    0060:[<c02b88ca>]    Not tainted VLI
> > > > EFLAGS: 00010296   (2.6.14-rc1)
> > > > EIP is at scsi_remove_device+0x3a/0x50
> >
> > > > If you need some more test, let me know.
> > > > In that case, please specify which version of kernel you want me to test.
> > > >
> > >
> > > OK, thanks.  This is a different bug.  Presumably in USB.
> >
> > This was fixed in later releases of 2.6.14-rc.
> >
> > I wasn't able to reproduce the original problem, even after setting
> > CONFIG_DEBUG_PAGEALLOC.
> >
> > Alan Stern
> >
> Alan,
> 
> Confirm the " scsi_remove_device " oops didn't happen on 2.4.14.

2.6.14, I assume.

> Talking about the original PANIC, as I have a workaround
> (CONFIG_DEBUG_PAGEALLOC disabled),  I agree to close my report, now.

That's not a valid workaround.  We're touching freed, unallocated or simply
wild memory and that is a bad bug.
