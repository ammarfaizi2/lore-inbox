Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S275255AbTHGK1Z (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 7 Aug 2003 06:27:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S275260AbTHGK1Z
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 7 Aug 2003 06:27:25 -0400
Received: from host81-136-142-241.in-addr.btopenworld.com ([81.136.142.241]:31458
	"EHLO mx.homelinux.com") by vger.kernel.org with ESMTP
	id S275255AbTHGK1X (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 7 Aug 2003 06:27:23 -0400
Date: Thu, 7 Aug 2003 11:27:18 +0100 (BST)
From: Mitch@0Bits.COM
X-X-Sender: mitch@mx.homelinux.com
Reply-To: Mitch@0Bits.COM
To: fbusse@gmx.de
cc: linux-kernel@vger.kernel.org
Subject: Re: Linux 2.4.22-rc1
Message-ID: <Pine.LNX.4.53.0308071119200.27424@mx.homelinux.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
X-Spam-Hits: -0.6
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Not enough info.

What usb controller do you have ? Which usb driver ?
ohci ? uhci ? ehci ? usb 2.0 ?

I reported this a long time ago on the usb lists, but
never got down to the bottom of the problem (my fault for
not following thru). However if i disable the usb 2.0
driver (i.e. not loading the ehci driver) which my external
storage is connected to, then everything works fine - albeit
it much more slowly. Appears to be a timing issue on some
usb <-> ide controller chips since not everyone is seeing this.

Mitch

Fridtjof Busse wrote:
>
> * Marcelo Tosatti <marcelo@conectiva.com.br>:
> > Hello,
> >
> > Here goes the first release candidate of 2.4.22.
> >
> > Please test it extensively.
>
> Still the same USB-problem I reported for pre5 and pre10:
>
> kernel: hub.c: new USB device 00:02.2-2, assigned address 4
> kernel: scsi1 : SCSI emulation for USB Mass Storage devices
> kernel:   Vendor: Maxtor 6  Model: Y120L0            Rev: 0811
> kernel:   Type:   Direct-Access                   ANSI SCSI revision: 02
> kernel: Attached scsi disk sda at scsi1, channel 0, id 0, lun 0
> kernel: SCSI device sda: 240121728 512-byte hdwr sectors (122942 MB)
> kernel:  /dev/scsi/host1/bus0/target0/lun0: p1
> kernel: WARNING: USB Mass Storage data integrity not assured
> kernel: USB Mass Storage device found at 4
>
> Now I start 'dump':
>
> kernel: usb_control/bulk_msg: timeout
> kernel: usb_control/bulk_msg: timeout
> kernel: usb_control/bulk_msg: timeout
> kernel: usb.c: USB disconnect on device 00:02.2-2 address 4
> kernel: usb-storage: host_reset() requested but not implemented
> kernel: scsi: device set offline - command error recover failed: host 1
> channel 0 id 0 lun 0
> kernel: 192
> kernel:  I/O error: dev 08:01, sector 81655440
> lots of I/O errors following
>
> Works fine with 2.4.21.
> Could someone please fix that before 2.4.22 becomes stable?
>
> Please CC me, thanks
