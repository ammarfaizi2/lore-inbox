Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751093AbVIGFRW@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751093AbVIGFRW (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 7 Sep 2005 01:17:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751146AbVIGFRW
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 7 Sep 2005 01:17:22 -0400
Received: from havoc.gtf.org ([69.61.125.42]:56500 "EHLO havoc.gtf.org")
	by vger.kernel.org with ESMTP id S1751093AbVIGFRW (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 7 Sep 2005 01:17:22 -0400
Date: Wed, 7 Sep 2005 01:17:20 -0400
From: Jeff Garzik <jgarzik@pobox.com>
To: Andrew Morton <akpm@osdl.org>, Linus Torvalds <torvalds@osdl.org>
Cc: linux-kernel@vger.kernel.org
Subject: [git patch] fix DocBook build
Message-ID: <20050907051720.GA10211@havoc.gtf.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



Please pull from 'upstream' branch of
rsync://rsync.kernel.org/pub/scm/linux/kernel/git/jgarzik/misc-2.6.git

to obtain the following DocBook change:


 Documentation/DocBook/mcabook.tmpl |    2 +-
 drivers/net/wan/syncppp.c          |    1 +
 drivers/scsi/libata-core.c         |    4 ++--
 include/sound/pcm.h                |    2 +-
 kernel/sched.c                     |    1 +
 5 files changed, 6 insertions(+), 4 deletions(-)



commit 344babaa9d39b10b85cadec4e5335d43b52b4ec0
Author: Jeff Garzik <jgarzik@pobox.com>
Date:   Wed Sep 7 01:15:17 2005 -0400

    [kernel-doc] fix various DocBook build problems/warnings
    
    Most serious is fixing include/sound/pcm.h, which breaks the DocBook
    build.
    
    The other stuff is just filling in things that cause warnings.



diff --git a/Documentation/DocBook/mcabook.tmpl b/Documentation/DocBook/mcabook.tmpl
--- a/Documentation/DocBook/mcabook.tmpl
+++ b/Documentation/DocBook/mcabook.tmpl
@@ -96,7 +96,7 @@
 
   <chapter id="pubfunctions">
      <title>Public Functions Provided</title>
-!Earch/i386/kernel/mca.c
+!Edrivers/mca/mca-legacy.c
   </chapter>
 
   <chapter id="dmafunctions">
diff --git a/drivers/net/wan/syncppp.c b/drivers/net/wan/syncppp.c
--- a/drivers/net/wan/syncppp.c
+++ b/drivers/net/wan/syncppp.c
@@ -1440,6 +1440,7 @@ static void sppp_print_bytes (u_char *p,
  *	@skb:	The buffer to process
  *	@dev:	The device it arrived on
  *	@p: Unused
+ *	@orig_dev: Unused
  *
  *	Protocol glue. This drives the deferred processing mode the poorer
  *	cards use. This can be called directly by cards that do not have
diff --git a/drivers/scsi/libata-core.c b/drivers/scsi/libata-core.c
--- a/drivers/scsi/libata-core.c
+++ b/drivers/scsi/libata-core.c
@@ -2531,7 +2531,7 @@ void swap_buf_le16(u16 *buf, unsigned in
  *	@ap: port to read/write
  *	@buf: data buffer
  *	@buflen: buffer length
- *	@do_write: read/write
+ *	@write_data: read/write
  *
  *	Transfer data from/to the device data register by MMIO.
  *
@@ -2577,7 +2577,7 @@ static void ata_mmio_data_xfer(struct at
  *	@ap: port to read/write
  *	@buf: data buffer
  *	@buflen: buffer length
- *	@do_write: read/write
+ *	@write_data: read/write
  *
  *	Transfer data from/to the device data register by PIO.
  *
diff --git a/include/sound/pcm.h b/include/sound/pcm.h
--- a/include/sound/pcm.h
+++ b/include/sound/pcm.h
@@ -903,7 +903,7 @@ int snd_pcm_format_unsigned(snd_pcm_form
 int snd_pcm_format_linear(snd_pcm_format_t format);
 int snd_pcm_format_little_endian(snd_pcm_format_t format);
 int snd_pcm_format_big_endian(snd_pcm_format_t format);
-/**
+/*
  * snd_pcm_format_cpu_endian - Check the PCM format is CPU-endian
  * @format: the format to check
  *
diff --git a/kernel/sched.c b/kernel/sched.c
--- a/kernel/sched.c
+++ b/kernel/sched.c
@@ -1478,6 +1478,7 @@ static inline void prepare_task_switch(r
 
 /**
  * finish_task_switch - clean up after a task-switch
+ * @rq: runqueue associated with task-switch
  * @prev: the thread we just switched away from.
  *
  * finish_task_switch must be called after the context switch, paired
