Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261388AbSJZSCP>; Sat, 26 Oct 2002 14:02:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261403AbSJZSCP>; Sat, 26 Oct 2002 14:02:15 -0400
Received: from marcie.netcarrier.net ([216.178.72.21]:8978 "HELO
	marcie.netcarrier.net") by vger.kernel.org with SMTP
	id <S261388AbSJZSCO>; Sat, 26 Oct 2002 14:02:14 -0400
Message-ID: <3DBADB56.C782BD1D@compuserve.com>
Date: Sat, 26 Oct 2002 14:13:42 -0400
From: Kevin Brosius <cobra@compuserve.com>
X-Mailer: Mozilla 4.78 [en] (X11; U; Linux 2.4.16-4GB i586)
X-Accept-Language: en
MIME-Version: 1.0
To: Oliver Neukum <oliver@neukum.name>, Greg KH <greg@kroah.com>
CC: kernel <linux-kernel@vger.kernel.org>
Subject: Re: 2.5.44-ac3 usb audio - illegal sleep call
References: <3DBAA320.B02AB7FC@compuserve.com> <200210261902.32626.oliver@neukum.name>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Oliver Neukum wrote:
> 
> 
> Am Samstag, 26. Oktober 2002 16:13 schrieb Kevin Brosius:
> > I've been trying to get USB up to test a audio device and just managed
> > to get it all working to some extent.  When using xmms to play audio
> > (usb audio module - oss soundcore) I see the following kernel messages
> > repeatedly, maybe once a second or so:
> 
> Go edit usbout_completed() and usbin_completed(). Change the GFP_KERNEL
> in usb_submit_urb to GFP_ATOMIC.
> Does that help ?
> 
>         Regards
>                 Oliver


Hi guys,
  No... Well, actually, it does change which function gives the
warning.  Now usbout_sync_completed is complaining.


Oct 26 13:54:18 sea kernel: Debug: sleeping function called from illegal
context at mm/slab.c:1374
Oct 26 13:54:18 sea kernel: Call Trace:
Oct 26 13:54:18 sea kernel:  [<c013fd0b>] __kmem_cache_alloc+0x17b/0x180
Oct 26 13:54:18 sea kernel:  [<e0a38bb5>] ohci_urb_enqueue+0xb5/0x2d0
[ohci-hcd]
Oct 26 13:54:18 sea kernel:  [<e09b9017>] hcd_submit_urb+0x117/0x180
[usbcore]
Oct 26 13:54:18 sea kernel:  [<e09c9d20>] usb_hcd_operations+0x0/0x40
[usbcore]
Oct 26 13:54:18 sea kernel:  [<e09b993b>] usb_submit_urb+0x1db/0x250
[usbcore]
Oct 26 13:54:18 sea kernel:  [<e0a2bd45>]
usbout_sync_completed+0xe5/0x110 [audio]
Oct 26 13:54:18 sea kernel:  [<e09b9409>] usb_hcd_giveback_urb+0x19/0x30
[usbcore]
Oct 26 13:54:18 sea kernel:  [<e0a38add>] dl_done_list+0x13d/0x160
[ohci-hcd]
Oct 26 13:54:18 sea kernel:  [<e0a3945b>] ohci_irq+0xfb/0x160 [ohci-hcd]
Oct 26 13:54:18 sea kernel:  [<e09b9442>] usb_hcd_irq+0x22/0x60
[usbcore]
Oct 26 13:54:18 sea kernel:  [<c010b8c5>] handle_IRQ_event+0x45/0x70
Oct 26 13:54:18 sea kernel:  [<c010bb6a>] do_IRQ+0xba/0x160
Oct 26 13:54:18 sea kernel:  [<c0107100>] default_idle+0x0/0x50
Oct 26 13:54:18 sea kernel:  [<c010a1ba>] common_interrupt+0x42/0x58

-- 
Kevin
