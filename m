Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262418AbUK3Xyn@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262418AbUK3Xyn (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 30 Nov 2004 18:54:43 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262426AbUK3Xyn
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 30 Nov 2004 18:54:43 -0500
Received: from fw.osdl.org ([65.172.181.6]:51397 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S262418AbUK3XtJ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 30 Nov 2004 18:49:09 -0500
Date: Tue, 30 Nov 2004 15:53:21 -0800
From: Andrew Morton <akpm@osdl.org>
To: Eyal Lebedinsky <eyal@eyal.emu.id.au>
Cc: linux-kernel@vger.kernel.org, Steven French <sfrench@us.ibm.com>
Subject: Re: 2.6.10-rc2-mm4 - cifs.ko needs unknown symbol
 CIFSSMBSetPosixACL
Message-Id: <20041130155321.3fe6da04.akpm@osdl.org>
In-Reply-To: <41ACFD1A.8050104@eyal.emu.id.au>
References: <20041130095045.090de5ea.akpm@osdl.org>
	<41ACFD1A.8050104@eyal.emu.id.au>
X-Mailer: Sylpheed version 0.9.7 (GTK+ 1.2.10; i586-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Eyal Lebedinsky <eyal@eyal.emu.id.au> wrote:
>
> WARNING: /lib/modules/2.6.10-rc2-mm4/kernel/fs/cifs/cifs.ko needs unknown symbol CIFSSMBSetPosixACL
> 
> Either it is really missing or a dependecy is not declared somewhere.

It looks like there's a slipup in bk-cifs.patch.  If you enable
CONFIG_CIFS_POSIX it'll probably link OK.


> I also get the following from the nvidia binary module,I should try the latest though.
> 
> WARNING: /lib/modules/2.6.10-rc2-mm4/kernel/drivers/video/nvidia.ko needs unknown symbol pgd_offset_k_is_obsolete
> WARNING: /lib/modules/2.6.10-rc2-mm4/kernel/drivers/video/nvidia.ko needs unknown symbol pgd_offset_is_obsolete

Looks like the nvidia wrapper will need updating if/when we merge Andi's
4-level pagetable implementation.

> WARNING: /lib/modules/2.6.10-rc2-mm4/kernel/drivers/video/nvidia.ko needs unknown symbol remap_page_range

remap_page_range() doesn't exist in -mm.  It does (and shall continue to)
exist in Linus's tree.  Reverting
for-mm-only-remove-remap_page_range-completely.patch will fix this one up.

