Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751821AbWCILCK@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751821AbWCILCK (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 9 Mar 2006 06:02:10 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751826AbWCILCK
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 9 Mar 2006 06:02:10 -0500
Received: from emailhub.stusta.mhn.de ([141.84.69.5]:51730 "HELO
	mailout.stusta.mhn.de") by vger.kernel.org with SMTP
	id S1751821AbWCILCI (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 9 Mar 2006 06:02:08 -0500
Date: Thu, 9 Mar 2006 12:02:07 +0100
From: Adrian Bunk <bunk@stusta.de>
To: Dan Williams <dan.j.williams@intel.com>
Cc: Jeff Garzik <jgarzik@pobox.com>, linux-ide@vger.kernel.org,
       linux-kernel@vger.kernel.org
Subject: drivers/scsi/sata_vsc.c: inconsistent NULL checking
Message-ID: <20060309110207.GA4006@stusta.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.11+cvs20060126
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

The Coverity checker found this inconsistent NULL checking recently 
introduced by the following commit:

  2ae5b30ff08cee422c7f6388a759f7
  Author: Dan Williams <dan.j.williams@intel.com>
  [PATCH] Necessary evil to get sata_vsc to initialize with Intel iq3124h hba


In function vsc_sata_interrupt():

	err_status = ap ? vsc_sata_scr_read(ap, SCR_ERROR) : 0;
	vsc_sata_scr_write(ap, SCR_ERROR, err_status);


vsc_sata_scr_write() always dereferences ap
(since SCR_ERROR < SCR_CONTROL).

Checking for NULL in one line and unconditionally dereferencing the 
variable in the next line can't be right.

cu
Adrian

-- 

       "Is there not promise of rain?" Ling Tan asked suddenly out
        of the darkness. There had been need of rain for many days.
       "Only a promise," Lao Er said.
                                       Pearl S. Buck - Dragon Seed

