Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262037AbVC1Tg1@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262037AbVC1Tg1 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 28 Mar 2005 14:36:27 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262020AbVC1Tg0
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 28 Mar 2005 14:36:26 -0500
Received: from mail0.lsil.com ([147.145.40.20]:15513 "EHLO mail0.lsil.com")
	by vger.kernel.org with ESMTP id S262024AbVC1TfQ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 28 Mar 2005 14:35:16 -0500
Message-ID: <91888D455306F94EBD4D168954A9457C01C2B134@nacos172.co.lsil.com>
From: "Moore, Eric Dean" <Eric.Moore@lsil.com>
To: Christoph Hellwig <hch@infradead.org>
Cc: linux-scsi@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: RE: [PATCH] - MPT FUSION - SPLITTING SCSI HOST DRIVERS
Date: Mon, 28 Mar 2005 12:34:42 -0700
MIME-Version: 1.0
X-Mailer: Internet Mail Service (5.5.2653.19)
Content-Type: text/plain;
	charset="iso-8859-1"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Saturday, March 26, 2005 4:21 AM, Christoph Hellwig wrote:
> I took a quick look an a here's a few comments:
> 
>  - I don't think renaming mptscsih.c to mpt_core.c makes sense.
>    the new name is confusing at best, and keeping the old name allows
>    to keep SCCS history aswell.  That means the new SPI stub 
> driver should
>    be called mptspi or something like that.

Ok fine.
I was wondering whether I should be providing a patch 
for all the defconfig files down in the arch branch with
CONFIG_FUSION=m , so our new drivers(mptspi and mptfc) 
would be getting compiled into default configurations?  

>  - please don't link mpt_core.o into both mptfch.ko and 
> mptscsih.ko but
>    make it a module of it's own

I'm not clear on this request.  Do you want me to add 
the mptscsih.ko module back, with module_init and module_exit
functions?  Thus when someone is either loading 
mptspi.ko/mptfc.ko, then they would need to 
load mptscsih.ko as well as mptbase.ko?  Bottom line,
three drivers loaded for either FC or SPI.  Just wondering
whether keeping the naming of mptscsih.ko driver would cause 
any problems.


>  - the new driver shoild use module_param, not MODULE_PARM

I'll fix it.

>  - why does the fc driver set ioc->spi_data.mpt_pq_filter?

Yes - this appplies to fiber.  It was requested by engenio, 
to prevent seeing a dummy Lun.  I probably confused you when I saved
this command line options in the spi_data member. Fine, I 
will save mpt_pq_filter somewhere else.

>  - no need to forward-declare the module_init/module_exit handlers
> 

Fine
