Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261659AbVDKBmM@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261659AbVDKBmM (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 10 Apr 2005 21:42:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261658AbVDKBmM
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 10 Apr 2005 21:42:12 -0400
Received: from fire.osdl.org ([65.172.181.4]:58086 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S261306AbVDKBmE (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 10 Apr 2005 21:42:04 -0400
Date: Sun, 10 Apr 2005 18:41:56 -0700
From: "Randy.Dunlap" <rddunlap@osdl.org>
To: sai narasimhamurthy <sai_narasi@yahoo.com>
Cc: linux-scsi@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: increasing scsi_max_sg / max_segments for scsi writes/reads
Message-Id: <20050410184156.3014a2ea.rddunlap@osdl.org>
In-Reply-To: <20050410023552.2545.qmail@web54101.mail.yahoo.com>
References: <20050410023552.2545.qmail@web54101.mail.yahoo.com>
Organization: OSDL
X-Mailer: Sylpheed version 1.0.4 (GTK+ 1.2.10; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 9 Apr 2005 19:35:52 -0700 (PDT) sai narasimhamurthy wrote:

| Hi, 
| I had posted a question on increasing the scsi
| read/write sectors  per command. I figured out some of
| the things, but many questions still exist. 
| 
| I was wondering why the maximum writes I could get
| from a single scsi write command could never exceed
| 204 
| 4096B  segments . I traced it to :  
| 
| static const int scsi_max_sg = PAGE_SIZE /
| sizeof(struct scatterlist)
| 
| in scsi_merge.c .(which amounts to 204)  
| 
| Is this the limit of the maximum blocks we can
| read/write through a single scsi command, atleast for
| the given kernel (2.4.29) ? How can I increase
| it??????
| 
| I am on a P3 Dell poweredgde 2400 . 

Did you read the comment immediately above that
calculation?

/*
 * scsi_malloc() can only dish out items of PAGE_SIZE or less, so we cannot
 * build a request that requires an sg table allocation of more than that.
 */

so scsi_malloc() would need some reworking to handle more.

OTOH, it appears that this is all removed in 2.6.10++, so moving to
2.6.recent is probably your best choice.

---
~Randy
