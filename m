Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267266AbTBLPgT>; Wed, 12 Feb 2003 10:36:19 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267252AbTBLPfu>; Wed, 12 Feb 2003 10:35:50 -0500
Received: from mail0.lsil.com ([147.145.40.20]:55514 "EHLO mail0.lsil.com")
	by vger.kernel.org with ESMTP id <S267266AbTBLPee>;
	Wed, 12 Feb 2003 10:34:34 -0500
Message-Id: <EB1DF7EA0D32D611B79C0002A51363F1AC9E13@exw-ks.ks.lsil.com>
From: "Liu, Yanqing" <yaliu@lsil.com>
To: "'linux-kernel@vger.kernel.org'" <linux-kernel@vger.kernel.org>
Subject: 
Date: Wed, 12 Feb 2003 09:43:47 -0600
MIME-Version: 1.0
X-Mailer: Internet Mail Service (5.5.2653.19)
Content-Type: text/plain;
	charset="gb2312"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Here's a question about SCSI driver module loading.

There's Qlogic2200 HBA inserted in my machine.
I want to establish some dependency relationship between qlogic driver and
my SCSI driver (like scsi_debug) so that they can be loaded/unloaded
together. Basically, I want my SCSI driver (say, scsi_debug) loaded after
sd/sg driver and before all other low level SCSI HBA drivers(like qla
driver). In modules.conf file, I added

alias scsi_hostadapter qla2200

add above scsi_hostadapter scsi_debug

I didn't make initrd since the Qlogic driver is not essential to the system
boot.

Anyway, Qlogic driver is loaded, but scsi_debug is not.

In the shell, if I type
modprobe scsi_hostadapter 
it will load scsi_debug module.
If I type
modprobe qla2200,
it will not.  (Why??)

And, if I modified modules.conf like the following:

alias scsi_hostadapter qla2200

add above qla2200 scsi_debug

Kernel will panic! 

My questions are:

1. When and how ia the alogic driver loaded in boot time (my machine has the
qlogic card).

2. How can I modify modules.conf (or possibly other way, e.g. rc script or
depmod) so that I can establish some dependency relationship between qlogic
driver and other SCSI drivers so that they can be loaded/unloaded together?

3. Do I need to load qlogic driver and my scsi_debug with initrd?

Thanks.

Yanqing
