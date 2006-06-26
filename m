Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932429AbWFZAlg@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932429AbWFZAlg (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 25 Jun 2006 20:41:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932302AbWFZAlg
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 25 Jun 2006 20:41:36 -0400
Received: from e32.co.us.ibm.com ([32.97.110.150]:6854 "EHLO e32.co.us.ibm.com")
	by vger.kernel.org with ESMTP id S932429AbWFZAlf (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 25 Jun 2006 20:41:35 -0400
Date: Sun, 25 Jun 2006 20:41:08 -0400
From: Vivek Goyal <vgoyal@in.ibm.com>
To: Adrian Bunk <bunk@stusta.de>, Morton Andrew Morton <akpm@osdl.org>
Cc: linux-kernel@vger.kernel.org, mike.miller@hp.com, iss_storagedev@hp.com,
       hbabu@us.ibm.com, fastboot@lists.osdl.org
Subject: Re: 2.6.17-mm2: BLK_CPQ_CISS_DA=m error
Message-ID: <20060626004108.GA21170@in.ibm.com>
Reply-To: vgoyal@in.ibm.com
References: <20060624061914.202fbfb5.akpm@osdl.org> <20060625193220.GE23314@stusta.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060625193220.GE23314@stusta.de>
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Jun 25, 2006 at 09:32:21PM +0200, Adrian Bunk wrote:
> On Sat, Jun 24, 2006 at 06:19:14AM -0700, Andrew Morton wrote:
> >...
> > Changes since 2.6.17-mm1:
> >...
> > +kdump-cciss-driver-initialization-issue-fix.patch
> > 
> >  Unpleasant kdump patches.
> >...
> 
> This patch breaks CONFIG_BLK_CPQ_CISS_DA=m:
> 
> <--  snip  -->
> 
> ...
> if [ -r System.map -a -x /sbin/depmod ]; then /sbin/depmod -ae -F System.map  2.6.17-mm2; fi
> WARNING: /lib/modules/2.6.17-mm2/kernel/drivers/block/cciss.ko needs unknown symbol crash_boot
>

Sorry. I forgot to export the symbol crash_boot. Please find attached the
patch.

Thanks
Vivek
 


o Compilation of cciss driver broke when compiled as a module as crash_boot
  was not exported.

Signed-off-by: Vivek Goyal <vgoyal@in.ibm.com>
---

 linux-2.6.17-1M-vivek/init/main.c |    1 +
 1 files changed, 1 insertion(+)

diff -puN init/main.c~cciss-module-compilation-break-fix init/main.c
--- linux-2.6.17-1M/init/main.c~cciss-module-compilation-break-fix	2006-06-25 20:31:24.000000000 -0400
+++ linux-2.6.17-1M-vivek/init/main.c	2006-06-25 20:31:24.000000000 -0400
@@ -131,6 +131,7 @@ static char *ramdisk_execute_command;
  * context.
  */
 unsigned int crash_boot;
+EXPORT_SYMBOL(crash_boot);
 
 /* Setup configured maximum number of CPUs to activate */
 static unsigned int max_cpus = NR_CPUS;
_
