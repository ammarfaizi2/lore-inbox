Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S270222AbTHQOel (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 17 Aug 2003 10:34:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S270248AbTHQOel
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 17 Aug 2003 10:34:41 -0400
Received: from caramon.arm.linux.org.uk ([212.18.232.186]:39954 "EHLO
	caramon.arm.linux.org.uk") by vger.kernel.org with ESMTP
	id S270222AbTHQOej (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 17 Aug 2003 10:34:39 -0400
Date: Sun, 17 Aug 2003 15:34:35 +0100
From: Russell King <rmk@arm.linux.org.uk>
To: Linux Kernel List <linux-kernel@vger.kernel.org>
Cc: linux-pcmcia@lists.infradead.org
Subject: [CFT] Clean up yenta_socket
Message-ID: <20030817153435.A24478@flint.arm.linux.org.uk>
Mail-Followup-To: Linux Kernel List <linux-kernel@vger.kernel.org>,
	linux-pcmcia@lists.infradead.org
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
X-Message-Flag: Your copy of Microsoft Outlook is vulnerable to viruses. See www.mutt.org for more details.
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Patch set:

	http://patches.arm.linux.org.uk/pcmcia/yenta-20030817*

	The tar file contains all patches.

This is a patch set aimed to cleaning up the yenta controller quirks,
working around some of the warts which have appeared (eg, overwriting
of yenta_operations init pointer.) and adding better power management
support.

Unfortunately, since my laptop continues to have an argument with the
2.6 kernel APM, I am unable to properly test the suspend/hibernate/resume
functionality.

yenta-20030817-1-zv.diff

	Use #defined constants for TI ZV initialisation

yenta-20030817-2-override.diff

	Clean up yenta overrides - move the quirks to the main
	PCI ID table, and list the quirks by type.

yenta-20030817-3-sockinit.diff

	Move socket initialisation to the quirk table.

yenta-20030817-4-pm.diff

	Add per-quirk power management (to aid saving/restoring
	controller specific state.)  Also, add proper pci state
	saving/restoring.  Note that Cardbus bridges have to
	save and restore at least 0x48 bytes of configuration
	space, not 0x40.  WIBNI pci_save_state/pci_restore_state
	took "start, length" parameters...

yenta-20030817-5-pm2.diff

	Remove PM restore from socket initialisation; less reason
	for socket initialisation to vary between controller types
	now.  In fact, we could very well get rid of much of the
	TI-specific socket initialisation quirk handling, since
	TI realised that they should be more compatible with other
	implementations in later versions of their bridges.

yenta-20030817-6-init.diff

	Move re-initialisation from the socket init/resume paths to
	where it belongs - the main initialisation path.

yenta-20030817-7-quirks.diff

	Move more controllers to the more advanced quirks.

-- 
Russell King (rmk@arm.linux.org.uk)                The developer of ARM Linux
             http://www.arm.linux.org.uk/personal/aboutme.html

