Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262275AbVEYGkl@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262275AbVEYGkl (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 25 May 2005 02:40:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262293AbVEYGkk
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 25 May 2005 02:40:40 -0400
Received: from smtp814.mail.sc5.yahoo.com ([66.163.170.84]:15492 "HELO
	smtp814.mail.sc5.yahoo.com") by vger.kernel.org with SMTP
	id S262275AbVEYGkb (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 25 May 2005 02:40:31 -0400
Message-Id: <20050525063738.864916000.dtor_core@ameritech.net>
Date: Wed, 25 May 2005 01:37:38 -0500
From: Dmitry Torokhov <dtor_core@ameritech.net>
To: irda-users@lists.sourceforge.net
Cc: Jean Tourrilhes <jt@hpl.hp.com>, linux-kernel@vger.kernel.org
Subject: [patch 0/9] smsc-ircc2: sysfs, suspend and other patches
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

[ This is a resend. I apologize if you already received copy of these
   patches...]

Hi,

The following patches attempt to convert smsc-ircc2 driver to the new
power management scheme by registering driver/device as platform device.
Additionally, suspend and resume methods were adjusted to keep network
device open and not release IRQ/DMA upon suspend to make sure that they
will still be available at resume time (IRQ and DMA simply disabled when
suspending). Plus there some less significant cleanups.

The resulting driver loads on my laptop and survives swsusp suspend/resume
cycle. Borrowed windows laptop recognizes and is being recognzed when
moved into vicinity of the box. Unfortunately I was not able to test any
higher-level protocols because IRDA connection would not stay on, but
it is the same with the original driver as well.

I would appreciate if owners of laptops with this chip could give these
patches a try. Thanks!

ircc2-whitespace.patch
  - whitespace fixes

ircc2-formatting.patch
  - some formatting changes for better readability

ircc2-remove-dim.patch
  - remove homegrown DIM macro in favor of ARRAY_SIZE, fix out-of-bounds
    array access

ircc2-remove-typedef.patch
  - drop some typedefs, use 'struct blah' instead

ircc2-cleanup.patch
  - do not pass around iobase, it is available from smsc_ircc_cb structure

ircc2-pm.patch
  - add smsc-ircc2 to sysfs/driver model as platform device/driver,
    switch to the new PM scheme.

ircc2-pm2.patch
  - avoid closing interface in suspend methods - it will cause IRQ/DMA be
    released and they may not be availabe at resume.

ircc2-netdev-priv.patch
  - switch to using netdev_priv().

ircc2-cleanup2.patch
  - avoid using void * pointers where specific type will do.

--
Dmitry

