Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262193AbTKCS6h (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 3 Nov 2003 13:58:37 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262192AbTKCS6h
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 3 Nov 2003 13:58:37 -0500
Received: from smtp13.eresmas.com ([62.81.235.113]:14516 "EHLO
	smtp13.eresmas.com") by vger.kernel.org with ESMTP id S262190AbTKCS6f
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 3 Nov 2003 13:58:35 -0500
Message-ID: <3FA6A4E8.5030609@wanadoo.es>
Date: Mon, 03 Nov 2003 19:56:40 +0100
From: Xose Vazquez Perez <xose@wanadoo.es>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.0.1) Gecko/20021003
X-Accept-Language: gl, es, en
MIME-Version: 1.0
To: khc@pm.waw.pl, linux-kernel <linux-kernel@vger.kernel.org>,
       Marcelo Tosatti <marcelo.tosatti@cyclades.com>
Subject: Re: Linux 2.4.23-pre9
X-Enigmail-Version: 0.63.3.0
X-Enigmail-Supports: pgp-inline, pgp-mime
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Krzysztof Halasa wrote:

> Would you (try to) accept a patch from me if I fix the following?
> 
> Modular IDE is still broken:
> hq:/usr/src/linux-hq# /sbin/depmod -ae
> depmod: *** Unresolved symbols in .../kernel/drivers/ide/ide-core.o
> depmod:         ide_wait_hwif_ready
> depmod:         ide_probe_for_drive
> depmod:         ide_probe_reset
> depmod:         ide_tune_drives
> 
> This is a circular dependency - ide-core.o wants them and they are exported
> by ide-probe.o which wants things from ide-core.o.

Last time that I compiled _all_ kernel modules with _all_ core options, with
OSDL compregress.sh test, there was more bugs:

--cut--
# make modules_install
[...]
if [ -r System.map ]; then /sbin/depmod -ae -F System.map  2.4.23-pre5; fi
depmod: *** Unresolved symbols in /lib/modules/2.4.23-pre5/kernel/drivers/ide/ide-core.o
depmod:         init_cmd640_vlb
depmod:         ide_wait_hwif_ready
depmod:         ide_probe_for_drive
depmod:         ide_probe_reset
depmod:         ide_tune_drives
depmod: *** Unresolved symbols in /lib/modules/2.4.23-pre5/kernel/drivers/net/wan/comx.o
depmod:         proc_get_inode
depmod: *** Unresolved symbols in /lib/modules/2.4.23-pre5/kernel/fs/binfmt_elf.o
depmod:         put_files_struct
depmod:         steal_locks
--end--

--
HTML mails are going to trash automagically

