Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030358AbWALK7L@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030358AbWALK7L (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 12 Jan 2006 05:59:11 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030381AbWALK7L
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 12 Jan 2006 05:59:11 -0500
Received: from host2092.kph.uni-mainz.de ([134.93.134.92]:205 "EHLO
	a1i15.kph.uni-mainz.de") by vger.kernel.org with ESMTP
	id S1030358AbWALK7K (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 12 Jan 2006 05:59:10 -0500
To: linux-kernel@vger.kernel.org
CC: Dave Airlie <airlied@linux.ie>, Dave Jones <davej@redhat.com>,
       Brice Goglin <Brice.Goglin@ens-lyon.org>, Andrew Morton <akpm@osdl.org>
Subject: Re: 2.6.15-mm2
References: <20060107052221.61d0b600.akpm@osdl.org>
	<43C0172E.7040607@ens-lyon.org> <20060107210413.GL9402@redhat.com>
	<43C03214.5080201@ens-lyon.org> <43C55148.4010706@ens-lyon.org>
	<20060111202957.GA3688@redhat.com>
Date: Thu, 12 Jan 2006 11:58:31 +0100
From: ulm@kph.uni-mainz.de (Ulrich Mueller)
Message-ID: <u3bjtogq0@a1i15.kph.uni-mainz.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>>>>> On Wed, 11 Jan 2006, Dave Airlie wrote:

>> > How are we supposed to get DRM to work on PCI Express cards if DRM
>> > needs AGP and agpgart does not load when no AGP card is found ? :)
>> 
>> That's puzzling. It should still be loadable. All the current
>> agpgart tree is doing is basically enforcing agp=off if there's no
>> agp card present. That shouldn't prevent the module from actually
>> loading, or it's symbols being referenced by other modules.
>> 
>> Hrmm, it's puzzling that you also are unable to resolve drm_open
>> and drm_release. That may be a follow-on failure from the first,
>> but it seems unlikely.

> Thats' just a cascaded failure, radeon gives out because drm won't
> load because agpgart won't load... there must be a reason why
> agpgart doesn't load... perhaps we've some issue when the backend
> isn't there or something..

Same problem here with 2.6.15-mm3:

   $ lspci -s 00:02.0 -v
   00:02.0 VGA compatible controller: Intel Corporation Mobile 915GM/GMS/910GML Express Graphics Controller (rev 03) (prog-if 00 [VGA])
   	Subsystem: Hewlett-Packard Company nx6110/nc6120
   	Flags: bus master, fast devsel, latency 0, IRQ 16
   	Memory at d0400000 (32-bit, non-prefetchable) [size=512K]
   	I/O ports at 7000 [size=8]
   	Memory at c0000000 (32-bit, prefetchable) [size=256M]
   	Memory at d0480000 (32-bit, non-prefetchable) [size=256K]
   	Capabilities: [d0] Power Management version 2
   $ modprobe -v agpgart
   insmod /lib/modules/2.6.15-mm3/kernel/drivers/char/agp/agpgart.ko 
   FATAL: Error inserting agpgart (/lib/modules/2.6.15-mm3/kernel/drivers/char/agp/agpgart.ko): No such device

And as a consequence intel-agp, drm, and i915 cannot be loaded.

The problem disappears if I revert git-agpgart.patch.
