Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266128AbUIECoN@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266128AbUIECoN (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 4 Sep 2004 22:44:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266136AbUIECoN
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 4 Sep 2004 22:44:13 -0400
Received: from rproxy.gmail.com ([64.233.170.207]:51251 "EHLO mproxy.gmail.com")
	by vger.kernel.org with ESMTP id S266128AbUIECnB (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 4 Sep 2004 22:43:01 -0400
Message-ID: <9e4733910409041943490b9587@mail.gmail.com>
Date: Sat, 4 Sep 2004 22:43:01 -0400
From: Jon Smirl <jonsmirl@gmail.com>
Reply-To: Jon Smirl <jonsmirl@gmail.com>
To: lkml <linux-kernel@vger.kernel.org>, Jaroslav Kysela <perex@suse.cz>
Subject: Intel ICH - sound/pci/intel8x0.c
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

The joystick PCI ID table in intel8x0.c is not correct. Joysticks and
MIDI ports are ISA devices and need be located by manual probing. This
ID table needs to be removed. Joystick and MIDI ports do not have PCI
IDs.

The PCI IDs in this table are for the ISA bridge chips, not the
joystick port.  These PC IDs should belong to the PCI bus driver. If I
fix the PCI bus driver to claim these like it should, joystick support
won't work any more.

static struct pci_device_id snd_intel8x0_joystick_ids[] = {
        { 0x8086, 0x2410, PCI_ANY_ID, PCI_ANY_ID, 0, 0, 0 },    /* 82801AA */
        { 0x8086, 0x2420, PCI_ANY_ID, PCI_ANY_ID, 0, 0, 0 },    /* 82901AB */
        { 0x8086, 0x2440, PCI_ANY_ID, PCI_ANY_ID, 0, 0, 0 }, /* ICH2 */
        { 0x8086, 0x244c, PCI_ANY_ID, PCI_ANY_ID, 0, 0, 0 }, /* ICH2M */
        { 0x8086, 0x248c, PCI_ANY_ID, PCI_ANY_ID, 0, 0, 0 },    /* ICH3 */
        // { 0x8086, 0x7195, PCI_ANY_ID, PCI_ANY_ID, 0, 0, 0 }, /* 440MX */
        // { 0x1039, 0x7012, PCI_ANY_ID, PCI_ANY_ID, 0, 0, 0 }, /* SI7012 */
        { 0x10de, 0x01b2, PCI_ANY_ID, PCI_ANY_ID, 0, 0, 0 },    /* NFORCE */
        { 0x10de, 0x006b, PCI_ANY_ID, PCI_ANY_ID, 0, 0, 0 },    /* NFORCE2 */
        { 0x10de, 0x00db, PCI_ANY_ID, PCI_ANY_ID, 0, 0, 0 },    /* NFORCE3 */
        { 0, }
};

2410	82801AA ISA Bridge (LPC)
2420	82801AB ISA Bridge (LPC)
2440	82801BA ISA Bridge (LPC)
244c	82801BAM ISA Bridge (LPC)
248c	82801CAM ISA Bridge (LPC)
01b2	nForce ISA Bridge

-- 
Jon Smirl
jonsmirl@gmail.com
