Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261363AbTILVgM (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 12 Sep 2003 17:36:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261531AbTILVgM
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 12 Sep 2003 17:36:12 -0400
Received: from e33.co.us.ibm.com ([32.97.110.131]:40650 "EHLO
	e33.co.us.ibm.com") by vger.kernel.org with ESMTP id S261363AbTILVgJ
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 12 Sep 2003 17:36:09 -0400
Date: Fri, 12 Sep 2003 16:36:05 -0500
Mime-Version: 1.0 (Apple Message framework v552)
Content-Type: text/plain; charset=US-ASCII; format=flowed
Subject: (kconfig) IDE DMA dependencies
From: Hollis Blanchard <hollisb@us.ibm.com>
To: linux-kernel@vger.kernel.org
Content-Transfer-Encoding: 7bit
Message-Id: <1D1AD482-E569-11D7-AC00-000A95A0560C@us.ibm.com>
X-Mailer: Apple Mail (2.552)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I noticed this when my linker couldn't find ide_setup_dma() last night. 
It looks like most of the drivers/ide/pci/ drivers use ide_setup_dma() 
in their .init_dma() function. ide_setup_dma() is defined in 
drivers/ide/ide-dma.c, but it is only compiled if 
CONFIG_BLK_DEV_IDEDMA_PCI is set. However, none of those PCI drivers 
express that dependency (I'm trying to use generic.c). What should be 
done here?

This is the full list of ide_setup_dma users:
aec62xx.c
alim15x3.c
amd74xx.c
cmd64x.c
cs5520.c
cs5530.c
generic.c
hpt34x.c
hpt366.c
it8172.c
ns87415.c
opti621.c
pdc202xx_new.c
pdc202xx_old.c
pdcadma.c
piix.c
sc1200.c
serverworks.c
siimage.c
sis5513.c
sl82c105.c
slc90e66.c
trm290.c
via82cxxx.c

-- 
Hollis Blanchard
IBM Linux Technology Center

