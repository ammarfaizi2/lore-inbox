Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265669AbTFVF5q (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 22 Jun 2003 01:57:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265670AbTFVF5q
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 22 Jun 2003 01:57:46 -0400
Received: from nat-pool-rdu.redhat.com ([66.187.233.200]:38943 "EHLO
	devserv.devel.redhat.com") by vger.kernel.org with ESMTP
	id S265669AbTFVF5p (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 22 Jun 2003 01:57:45 -0400
Date: Sun, 22 Jun 2003 02:11:42 -0400
From: Pete Zaitcev <zaitcev@redhat.com>
To: Ishikawa <ishikawa@yk.rim.or.jp>
Cc: linux-kernel@vger.kernel.org, Pete Zaitcev <zaitcev@redhat.com>,
       Alan Cox <alan@redhat.com>
Subject: Re: Warning message during linux kernel 2.4.21 compilation (ymfpci.c)
Message-ID: <20030622021142.A13819@devserv.devel.redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <no.id>; from ishikawa@yk.rim.or.jp on Sun, Jun 22, 2003 at 05:10:13AM +0900
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> Date: Sun, 22 Jun 2003 05:10:13 +0900
> From: Ishikawa <ishikawa@yk.rim.or.jp>

> It certainly looks that  something is wrong with the code.
> (Maybe some masking of the eid and the immediate value is missing?)

>    u16 eid;
> 	...

>    2462	eid = ymfpci_codec_read(codec, AC97_EXTENDED_ID);
> -->2463	if (eid==0xFFFFFF) {
> 		printk(KERN_WARNING "ymfpci: no codec attached ?\n");
> 		goto out_kfree;
> 	}

This is indeed a bug, and ymfpci inherits it from cs46xx.c.
I wonder why cs46xx.c does not trigger a warning.

Since the check never worked and nobody ever complained,
I think the best fix is to remove the "if" statement with
its block. If we repair the comparison to "eid == 0xFFFF",
then we run a risk of breaking previously working systems.

-- Pete
