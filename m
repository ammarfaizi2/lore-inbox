Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262866AbTC0EfG>; Wed, 26 Mar 2003 23:35:06 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262871AbTC0EfF>; Wed, 26 Mar 2003 23:35:05 -0500
Received: from pimout1-ext.prodigy.net ([207.115.63.77]:59629 "EHLO
	pimout1-ext.prodigy.net") by vger.kernel.org with ESMTP
	id <S262866AbTC0EfF>; Wed, 26 Mar 2003 23:35:05 -0500
Message-Id: <200303270446.h2R4kGu4636448@pimout1-ext.prodigy.net>
Content-Type: text/plain; charset=US-ASCII
From: dan carpenter <d_carpenter@sbcglobal.net>
To: "Martin J. Bligh" <mbligh@aracnet.com>,
       linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: [Bug 509] New: NULL pointer when rmmod faulty driver
Date: Wed, 26 Mar 2003 12:25:28 +0100
X-Mailer: KMail [version 1.3.2]
References: <1451130000.1048708440@flay>
In-Reply-To: <1451130000.1048708440@flay>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wednesday 26 March 2003 08:54 pm, Martin J. Bligh wrote:
> http://bugme.osdl.org/show_bug.cgi?id=509
>

> Mar 26 20:23:33 localhost modprobe: FATAL: Module /dev/video0 not found.
> Mar 26 20:27:14 localhost kernel: drivers/usb/host/uhci-hcd.c: 1000: host
> controller halted. very bad

There is a fixme next to the printf statement in 
drivers/usb/host/uhci-hcd.c

  1886                  if ((status & USBSTS_HCH) && !uhci->is_suspended) {
  1887                          err("%x: host controller halted. very bad", io_addr);
  1888                          /* FIXME: Reset the controller, fix the offending TD */
  1889                  }

> Mar 26 20:27:14 localhost kernel: EIP:    0060:[<ce8c2a3c>]    Tainted: GF
> Mar 26 20:27:14 localhost kernel: EFLAGS: 00010206
> Mar 26 20:27:14 localhost kernel: EIP is at qc_usb_disconnect+0x98/0x268
> [quickcam] Mar 26 20:27:14 localhost kernel: eax: ce8d07c0   ebx: 00000077 

The quickcam source isn't available to fix the null dereference bug.

regards,
dan
