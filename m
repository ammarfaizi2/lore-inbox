Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261532AbSJDI2i>; Fri, 4 Oct 2002 04:28:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261539AbSJDI2i>; Fri, 4 Oct 2002 04:28:38 -0400
Received: from dp.samba.org ([66.70.73.150]:966 "EHLO lists.samba.org")
	by vger.kernel.org with ESMTP id <S261532AbSJDI2h>;
	Fri, 4 Oct 2002 04:28:37 -0400
Date: Fri, 4 Oct 2002 18:29:18 +1000
From: Anton Blanchard <anton@samba.org>
To: akpm@zip.com.au
Cc: linux-kernel@vger.kernel.org
Subject: sleeper
Message-ID: <20021004082918.GB4800@krispykreme>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Hi,

I cant remember if we have seen this one before.

scsi_try_to_abort_cmd does:

  spin_lock_irqsave(scmd->host->host_lock, flags);

and sym_eh_handler (in sym53c8xx_2 driver) does:

  down(&ep->sem);

Anton

Debug: sleeping function called from illegal context at
/scratch/anton/linux-2.5_ppc64_work/include/asm/semaphore.h:80
Call backtrace: 
C00000000005C390 __might_sleep+0xf4
C00000000029D220 sym_eh_handler+0x1d0
C000000000295C4C scsi_try_to_abort_cmd+0xdc
C000000000295EA4 scsi_eh_abort_cmd+0x60
C000000000296CE0 scsi_unjam_host+0xf4
C000000000296F44 scsi_error_handler+0x1fc
