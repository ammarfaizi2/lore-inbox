Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261981AbUDXGoO@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261981AbUDXGoO (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 24 Apr 2004 02:44:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261993AbUDXGoO
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 24 Apr 2004 02:44:14 -0400
Received: from smtp811.mail.sc5.yahoo.com ([66.163.170.81]:54866 "HELO
	smtp811.mail.sc5.yahoo.com") by vger.kernel.org with SMTP
	id S261981AbUDXGoH (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 24 Apr 2004 02:44:07 -0400
From: Dmitry Torokhov <dtor_core@ameritech.net>
To: Greg KH <greg@kroah.com>
Subject: Re: [OOPS/HACK] atmel_cs and the latest changes in sysfs/symlink.c
Date: Sat, 24 Apr 2004 01:44:04 -0500
User-Agent: KMail/1.6.1
Cc: linux-usb-devel@lists.sourceforge.net, vojtech@suse.cz,
       Marcel Holtmann <marcel@holtmann.org>, Andrew Morton <akpm@osdl.org>,
       linux-kernel@vger.kernel.org, Simon Kelley <simon@thekelleys.org.uk>
References: <200404230142.46792.dtor_core@ameritech.net> <20040423171953.GB13835@kroah.com> <20040423180342.GA14533@kroah.com>
In-Reply-To: <20040423180342.GA14533@kroah.com>
MIME-Version: 1.0
Content-Disposition: inline
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Message-Id: <200404240144.05004.dtor_core@ameritech.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Friday 23 April 2004 01:03 pm, Greg KH wrote:
> On Fri, Apr 23, 2004 at 10:19:53AM -0700, Greg KH wrote:
> > On Fri, Apr 23, 2004 at 08:31:11AM -0700, Greg KH wrote:
> > > 
> > > No, we need to oops, as that's a real bug.  Can you post the whole oops
> > > that was generated with this usb problem?  I can't seem to duplicate
> > > this here.
> > 
> > Nevermind I dug up a device here that causes this problem.  I'll track
> > it down...
> 
> Ok, here's a patch that fixes it for me.  I was waiting for a good
> reason to finally get rid of this fake usb_interface structure, and now
> I have it :)
> 

Yes, it does fix it for me, thanks a lot!
Now if somebody could fix the following oops...

Unable to handle kernel paging request at virtual address e1b1a120
 printing eip:
e1b1504a
*pde = 1fe1d067
*pte = 00000000
Oops: 0002 [#1]
PREEMPT
CPU:    0
EIP:    0060:[<e1b1504a>]    Tainted: P
EFLAGS: 00010246   (2.6.6-rc2)
EIP is at hiddev_cleanup+0x2a/0x40 [usbhid]
eax: 00000060   ebx: d7215640   ecx: 00000000   edx: e18728f4
esi: e1b19b80   edi: dfe30800   ebp: df2bfe50   esp: df2bfe44
ds: 007b   es: 007b   ss: 0068
Process khubd (pid: 400, threadinfo=df2be000 task=df3a5230)
Stack: d7922680 e1b19c7c d3e8e000 df2bfe64 e1b14ac8 d7215640 e1b19b80 d7922680
       df2bfe80 e1859106 d7922680 d7922680 d44f9da0 d7922690 e1b19ba0 df2bfe98
       c0210bc6 d7922690 d79226b8 d7922690 dfe308cc df2bfeb0 c0210d03 d7922690
Call Trace:
 [<e1b14ac8>] hid_disconnect+0xb8/0xe0 [usbhid]
 [<e1859106>] usb_unbind_interface+0x76/0x80 [usbcore]
 [<c0210bc6>] device_release_driver+0x66/0x70
 [<c0210d03>] bus_remove_device+0x53/0xa0
 [<c020fbdd>] device_del+0x5d/0xa0
 [<c020fc34>] device_unregister+0x14/0x30
 [<e185f480>] usb_disable_device+0x70/0xb0 [usbcore]
 [<e1859d16>] usb_disconnect+0xa6/0x100 [usbcore]
 [<e1859d58>] usb_disconnect+0xe8/0x100 [usbcore]
 [<e185bfef>] hub_port_connect_change+0x28f/0x2a0 [usbcore]
 [<e185b971>] hub_port_status+0x41/0xb0 [usbcore]
 [<e185c343>] hub_events+0x343/0x3b0 [usbcore]
 [<e185c3e5>] hub_thread+0x35/0xf0 [usbcore]
 [<c0115ef0>] default_wake_function+0x0/0x20
 [<e185c3b0>] hub_thread+0x0/0xf0 [usbcore]
 [<c01032e5>] kernel_thread_helper+0x5/0x10


-- 
Dmitry
