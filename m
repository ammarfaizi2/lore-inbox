Return-Path: <linux-kernel-owner+willy=40w.ods.org-S265106AbUGNRmh@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265106AbUGNRmh (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 14 Jul 2004 13:42:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265108AbUGNRmh
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 14 Jul 2004 13:42:37 -0400
Received: from [208.223.9.37] ([208.223.9.37]:16399 "EHLO maestro.symsys.com")
	by vger.kernel.org with ESMTP id S265106AbUGNRmf (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 14 Jul 2004 13:42:35 -0400
Date: Wed, 14 Jul 2004 12:42:33 -0500 (CDT)
From: Greg Ingram <ingram@symsys.com>
To: linux-kernel@vger.kernel.org
Subject: via82xx.c vs. sonypi.c i/o region conflict on vaio
Message-ID: <Pine.LNX.4.44.0407141230550.25786-100000@maestro.symsys.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Howdy,

(I sent a similar version of this message to Jaroslav Kysela
<perex@suse.cz> but haven't heard back from him.)

I'm working with a Sony Vaio PCG-FXA32.  The "Sony Programmable I/O
Controller Driver v1.22"  (drivers/char/sonypi.c). finds a controller and
grabs ports 0x1080-0x109f.  The sound module (sound/pci/via82xx.c) finds a
VIA686A and grabs ports 0x1000-0x10ff.  The ranges overlap. I can't load
both modules.

I modified the sound driver to grab only 128 ports instead of 256 and the
driver works fine on this hardware.  In 2.6.7, it's line 2049 or so of
sound/pci/via82xx.c:

old:	if ((chip->res_port = request_region(chip->port, 256, card->driver)) == NULL) {
new:	if ((chip->res_port = request_region(chip->port, 256, card->driver)) == NULL) {

Does anyone know specifically that some chipsets need so many ports?  If
so, what info for this hardware can I supply to fix the sound driver
permanently?

Regards,

- Greg




