Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261861AbTEZRks (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 26 May 2003 13:40:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261906AbTEZRks
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 26 May 2003 13:40:48 -0400
Received: from 213-96-224-204.uc.nombres.ttd.es ([213.96.224.204]:32004 "EHLO
	betawl.net") by vger.kernel.org with ESMTP id S261861AbTEZRkq (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 26 May 2003 13:40:46 -0400
Date: Mon, 26 May 2003 19:53:54 +0200
From: Santiago Garcia Mantinan <manty@manty.net>
To: Andrzej Krzysztofowicz <ankry@green.mif.pg.gda.pl>
Cc: kernel list <linux-kernel@vger.kernel.org>, marcelo@conectiva.com.br,
       Alan Cox <alan@lxorguk.ukuu.org.uk>
Subject: Re: Linux 2.4.21-rc3
Message-ID: <20030526175354.GA4051@man.beta.es>
References: <200305261400.h4QE00JF009630@green.mif.pg.gda.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200305261400.h4QE00JF009630@green.mif.pg.gda.pl>
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

The patch Andrzej sent only solves part of the problem, I can still see
this:

depmod: *** Unresolved symbols in
/lib/modules/2.4.21-rc3/kernel/drivers/ide/ide-probe.o
depmod:         do_ide_request
depmod:         ide_add_generic_settings
depmod: *** Unresolved symbols in
/lib/modules/2.4.21-rc3/kernel/drivers/ide/ide-proc.o
depmod:         ide_find_setting_by_name
depmod:         ide_modules
depmod:         ide_read_setting
depmod:         generic_subdriver_entries
depmod: *** Unresolved symbols in
/lib/modules/2.4.21-rc3/kernel/drivers/ide/ide.o
depmod:         ide_release_dma
depmod:         pnpide_init
depmod:         ide_scan_pcibus

I have seen that even though I have CONFIG_BLK_DEV_ISAPNP=y on the config
file, ide-pnp.c is not compiled, this raises a warning when compiling ide.c:
ide.c: In function 	de_unregister_subdriver':
ide.c:2625: warning: implicit declaration of function `pnpide_init'

On the others I suppose that the problem is that the symbols are not
exported :-(

Hope this helps fixing ide modules compiling before 2.4.21 is released.

Regards...
-- 
Manty/BestiaTester -> http://manty.net
