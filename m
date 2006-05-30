Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964809AbWE3XF7@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964809AbWE3XF7 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 30 May 2006 19:05:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964806AbWE3XF6
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 30 May 2006 19:05:58 -0400
Received: from mx3.mail.elte.hu ([157.181.1.138]:27539 "EHLO mx3.mail.elte.hu")
	by vger.kernel.org with ESMTP id S964803AbWE3XF5 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 30 May 2006 19:05:57 -0400
Date: Wed, 31 May 2006 01:06:20 +0200
From: Ingo Molnar <mingo@elte.hu>
To: Michal Piotrowski <michal.k.k.piotrowski@gmail.com>
Cc: Arjan van de Ven <arjan@linux.intel.com>, linux-scsi@vger.kernel.org,
       linux-kernel@vger.kernel.org, Andrew Morton <akpm@osdl.org>
Subject: Re: 2.6.17-rc5-mm1
Message-ID: <20060530230620.GA6226@elte.hu>
References: <20060530022925.8a67b613.akpm@osdl.org> <6bffcb0e0605301155h3b472d79h65e8403e7fa0b214@mail.gmail.com> <6bffcb0e0605301157o6b7c5f66q3c9f151cbb4537d5@mail.gmail.com> <20060530194259.GB22742@elte.hu> <6bffcb0e0605301457v9ba284bk75b8b6d14384489a@mail.gmail.com> <20060530220931.GA32759@elte.hu> <6bffcb0e0605301559y603a60bl685b7aca60069dfd@mail.gmail.com> <20060530230512.GA6042@elte.hu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060530230512.GA6042@elte.hu>
User-Agent: Mutt/1.4.2.1i
X-ELTE-SpamScore: 0.0
X-ELTE-SpamLevel: 
X-ELTE-SpamCheck: no
X-ELTE-SpamVersion: ELTE 2.0 
X-ELTE-SpamCheck-Details: score=0.0 required=5.9 tests=AWL autolearn=no SpamAssassin version=3.0.3
	0.0 AWL                    AWL: From: address is in the auto white-list
X-ELTE-VirusStatus: clean
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


* Ingo Molnar <mingo@elte.hu> wrote:

> Could you try the patch below? This uses the ID string as the key. 
> (the ID string seems to be based on static kernel strings most of the 
> time, so this might as well work)

that patch should be:

Index: linux/sound/core/seq/seq_device.c
===================================================================
--- linux.orig/sound/core/seq/seq_device.c
+++ linux/sound/core/seq/seq_device.c
@@ -74,8 +74,6 @@ struct ops_list {
 	struct mutex reg_mutex;
 
 	struct list_head list;	/* next driver */
-
-	struct lockdep_type_key reg_mutex_key;
 };
 
 
@@ -382,7 +380,7 @@ static struct ops_list * create_driver(c
 
 	/* set up driver entry */
 	strlcpy(ops->id, id, sizeof(ops->id));
-	mutex_init_key(&ops->reg_mutex, id, &ops->reg_mutex_key);
+	mutex_init_key(&ops->reg_mutex, id, (struct lockdep_type_key *)id);
 	ops->driver = DRIVER_EMPTY;
 	INIT_LIST_HEAD(&ops->dev_list);
 	/* lock this instance */

