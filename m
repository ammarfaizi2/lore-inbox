Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S269589AbTG1Njx (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 28 Jul 2003 09:39:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S269702AbTG1Njx
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 28 Jul 2003 09:39:53 -0400
Received: from mx.laposte.net ([213.30.181.11]:57549 "EHLO mx.laposte.net")
	by vger.kernel.org with ESMTP id S269589AbTG1Njv (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 28 Jul 2003 09:39:51 -0400
Message-ID: <030201c3550f$dec61620$0a00a8c0@toumi>
From: "Ghozlane Toumi" <gtoumi@laposte.net>
To: <Andries.Brouwer@cwi.nl>, <linux-kernel@vger.kernel.org>
References: <UTC200307281315.h6SDFOY08368.aeb@smtp.cwi.nl>
Subject: Re: [PATCH] Re: 2.6.0-test1 on alpha : disk label numbering trouble
Date: Mon, 28 Jul 2003 15:54:28 +0200
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
X-Priority: 3
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook Express 5.50.4133.2400
X-MimeOLE: Produced By Microsoft MimeOLE V5.50.4133.2400
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

From: <Andries.Brouwer@cwi.nl>

> 2.4:
> sda: sda3 sda4 sda5
>
> 2.6:
> sda: sda1 sda2 sda3
> 
> OK, I see what happened - viro changed things a little,
> maybe by mistake.
> 
> I suppose the below will give you your original numbering again.
> (Please confirm.)

yes, it works , thanks.
quickly checking viro's changes in this area, it seems other partitions
schemes are touched by the same problem...

> --- osf.c~ Wed Mar  5 04:29:32 2003
> +++ osf.c Mon Jul 28 16:13:03 2003
> @@ -67,9 +67,10 @@
>   if (slot == state->limit)
>           break;
>   if (le32_to_cpu(partition->p_size))
> - put_partition(state, slot++,
> + put_partition(state, slot,
>   le32_to_cpu(partition->p_offset),
>   le32_to_cpu(partition->p_size));
> + slot++;
>   }
>   printk("\n");
>   put_dev_sector(sect);

thanks,

ghoz

