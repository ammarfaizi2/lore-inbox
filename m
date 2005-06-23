Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262272AbVFWJst@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262272AbVFWJst (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 23 Jun 2005 05:48:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262268AbVFWJof
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 23 Jun 2005 05:44:35 -0400
Received: from mx2.elte.hu ([157.181.151.9]:53691 "EHLO mx2.elte.hu")
	by vger.kernel.org with ESMTP id S262272AbVFWJkY (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 23 Jun 2005 05:40:24 -0400
Date: Thu, 23 Jun 2005 11:40:08 +0200
From: Ingo Molnar <mingo@elte.hu>
To: Andrew Morton <akpm@osdl.org>
Cc: linux-kernel@vger.kernel.org
Subject: Re: DEBUG_PAGEALLOC & SMP?
Message-ID: <20050623094008.GA31207@elte.hu>
References: <20050623090936.GA28112@elte.hu> <20050623022000.094169d4.akpm@osdl.org> <20050623092902.GA29602@elte.hu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20050623092902.GA29602@elte.hu>
User-Agent: Mutt/1.4.2.1i
X-ELTE-SpamVersion: MailScanner 4.31.6-itk1 (ELTE 1.2) SpamAssassin 2.63 ClamAV 0.73
X-ELTE-VirusStatus: clean
X-ELTE-SpamCheck: no
X-ELTE-SpamCheck-Details: score=-4.9, required 5.9,
	autolearn=not spam, BAYES_00 -4.90
X-ELTE-SpamLevel: 
X-ELTE-SpamScore: -4
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


* Ingo Molnar <mingo@elte.hu> wrote:

> added them, it's:
> 
> (gdb) list *0xc02f993f
> 0xc02f993f is in sd_revalidate_disk (drivers/scsi/sd.c:1472).
> 1467                           "failure.\n");
> 1468                    goto out;
> 1469            }
> 1470
> 1471            buffer = kmalloc(512, GFP_KERNEL | __GFP_DMA);
> 1472            if (!buffer) {
> 1473                    printk(KERN_WARNING "(sd_revalidate_disk:) Memory allocation "
> 1474                           "failure.\n");
> 1475                    goto out_release_request;
> 1476            }
> (gdb)
> 
> full log attached below. (ob'fun: the oom-killer picked the migration 
> thread to kill ;)

this was with the -RT tree - let me try whether the same happens on 
vanilla 2.6.12 too.

	Ingo
