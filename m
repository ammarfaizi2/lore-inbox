Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262777AbTIQPRL (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 17 Sep 2003 11:17:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262779AbTIQPRL
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 17 Sep 2003 11:17:11 -0400
Received: from trained-monkey.org ([209.217.122.11]:25873 "EHLO
	trained-monkey.org") by vger.kernel.org with ESMTP id S262777AbTIQPRJ
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 17 Sep 2003 11:17:09 -0400
To: "Andrey Panin,,," <pazke@switch-ats62.donpac.ru>
Cc: linux-kernel@vger.kernel.org
Subject: Re: FWD: qla1280 SCSI driver crash on visws
References: <20030912124200.GA734@pazke>
From: Jes Sorensen <jes@wildopensource.com>
Date: 17 Sep 2003 11:17:07 -0400
In-Reply-To: <20030912124200.GA734@pazke>
Message-ID: <m3u17bh2bw.fsf@trained-monkey.org>
User-Agent: Gnus/5.0808 (Gnus v5.8.8) Emacs/20.7
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>>>>> "Andrey" == Andrey Panin,,, <pazke@switch-ats62.donpac.ru> writes:

Andrey> Hello Jes, qla1280 SCSI driver crashes in inetrrupt handler on
Andrey> visws

Andrey> Please take a look.

Andrey,

Try this as a band-aid. It's not a final patch, but it should get the
thing booting.

Jes


diff -Naur -X /home/jbarnes/dontdiff linux-2.6.0-test5-ia64/drivers/scsi/qla1280.c linux-2.6.0-test5-ia64-sn/drivers/scsi/qla1280.c
--- linux-2.6.0-test5-ia64/drivers/scsi/qla1280.c	Mon Sep  8 12:50:43 2003
+++ linux-2.6.0-test5-ia64-sn/drivers/scsi/qla1280.c	Mon Sep 15 12:19:06 2003
@@ -3359,9 +3359,9 @@
 			ha->bus_settings[bus].scsi_bus_dead = 1;
 		ha->bus_settings[bus].failed_reset_count++;
 	} else {
-		spin_unlock_irq(HOST_LOCK);
+/*		spin_unlock_irq(HOST_LOCK); */
 		schedule_timeout(reset_delay * HZ);
-		spin_lock_irq(HOST_LOCK);
+/*		spin_lock_irq(HOST_LOCK); */
 
 		ha->bus_settings[bus].scsi_bus_dead = 0;
 		ha->bus_settings[bus].failed_reset_count = 0;
