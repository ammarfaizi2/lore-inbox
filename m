Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965189AbVIVAVw@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965189AbVIVAVw (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 21 Sep 2005 20:21:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965193AbVIVAVw
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 21 Sep 2005 20:21:52 -0400
Received: from relay02.mail-hub.dodo.com.au ([202.136.32.45]:10915 "EHLO
	relay02.mail-hub.dodo.com.au") by vger.kernel.org with ESMTP
	id S965189AbVIVAVw (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 21 Sep 2005 20:21:52 -0400
From: Grant Coady <grant_lkml@dodo.com.au>
To: linux-kernel@vger.kernel.org
Cc: akpm@osdl.org
Subject: Query: How fix: `ide_generic_all_on' defined but not used??
Date: Thu, 22 Sep 2005 10:21:38 +1000
Organization: http://bugsplatter.mine.nu/
Reply-To: gcoady@gmail.com
Message-ID: <mpn3j1p9n087sq45le5tio0np8aoa3s11a@4ax.com>
X-Mailer: Forte Agent 2.0/32.652
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi there,

With 2.6.14-rc2 allmodconfig with CONFIG_ISDN_I4L=n I get:

drivers/ide/pci/generic.c:45: warning: `ide_generic_all_on' defined but not used


Source:
...
static int ide_generic_all;             /* Set to claim all devices */

static int __init ide_generic_all_on(char *unused)
{
        ide_generic_all = 1;
        printk(KERN_INFO "IDE generic will claim all unknown PCI IDE storage controllers.\n");
        return 1;
}

__setup("all-generic-ide", ide_generic_all_on);
...

How to silence this type of warning?


Other "defined but not used" warnings in 2.6.14-rc2 are:

grant@sempro:/opt/linux$ grep "defined but not used" errorlog |cut -d: -f1|sort|uniq
drivers/ide/pci/generic.c
drivers/net/cs89x0.c		appears okay?
drivers/scsi/BusLogic.c		caller is '#if 0' out, but is nightmare code ;)
drivers/scsi/NCR5380.c		heaps of 'em, me not go there
drivers/scsi/NCR53c406a.c	[0]
drivers/scsi/fd_mcs.c		[0]
drivers/scsi/fdomain.c		appears okay? nested #ifdef -> hard to tell
drivers/scsi/ncr53c8xx.c	[0]
drivers/video/fbmem.c		[0]

[0] similar to drivers/ide/pci/generic.c above


Query: "< > Old ISDN4Linux (obsolete)" (CONFIG_ISDN_I4L) turned off to get 
compile completion, should this be marked BROKEN in Kconfig?

Thanks,
Grant.
