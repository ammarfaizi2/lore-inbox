Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264557AbUAIUFQ (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 9 Jan 2004 15:05:16 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264566AbUAIUFQ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 9 Jan 2004 15:05:16 -0500
Received: from adsl-065-081-070-095.sip.gnv.bellsouth.net ([65.81.70.95]:62350
	"EHLO medicaldictation.com") by vger.kernel.org with ESMTP
	id S264557AbUAIUFA (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 9 Jan 2004 15:05:00 -0500
Date: Fri, 9 Jan 2004 15:05:01 -0500
From: Chuck Berg <chuck@encinc.com>
To: linux-kernel@vger.kernel.org
Subject: HPT372 DMA corruption
Message-ID: <20040109150501.A5891@timetrax.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I have an HPT372 onboard a Soyo Dragon KT400 board. I get corruption when
reading from drives on this controller. (I don't dare write, so I don't
know if writes are affected as well). I'm using 2.6.1, but have experienced
this problem with older kernels (at least it's not crashing anymore).

Disabling DMA on these drives stops the corruption.

It only happens when I heavily exercise certain other devices on the system
at the same time. This includes both a network and a SCSI PCI card that
share an irq with the HPT372, but also a firewire card that does not. Load
on the other onboard IDE interfaces (which do not demonstrate the
corruption) does not trigger it.

I have four identical drives in the system. I've switched cables around to
verify that the problem follows the HPT372. I have no problems when I move
the drives to a Promise card. I have run memtest86 for over 24 hours with
no errors.

It happens whether I read the /dev/hd* devices, a file on the filesystem,
or using /dev/raw.

Here's an example of the corruption. (cmp -l output, left is bad right is
good). It always consists of bytes being replaced with 0. It's usually 4,
but sometimes 64 bytes at a time. On average, about 256 bytes per gigabyte
read are corrupt.

 51642365   0 211
 51642366   0 154
 51642367   0 163
 51642368   0 120
 63700989   0 100
 63700990   0 153
 63700991   0 216
 63700992   0   2
 89260029   0  31
 89260030   0 327
 89260031   0 200
 89260032   0  13

More information (.config, /proc/{interrupts,cpuinfo,ioports,iomem,ide}, bootup
messages, lspci -vvv) is at:
http://www.encinc.com/~chuck/kt400/2.6.1/

Thanks for any help.
