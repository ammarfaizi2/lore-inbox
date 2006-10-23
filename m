Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932227AbWJWRiq@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932227AbWJWRiq (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 23 Oct 2006 13:38:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932231AbWJWRiq
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 23 Oct 2006 13:38:46 -0400
Received: from outpipe-village-512-1.bc.nu ([81.2.110.250]:37814 "EHLO
	lxorguk.ukuu.org.uk") by vger.kernel.org with ESMTP id S932228AbWJWRio
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 23 Oct 2006 13:38:44 -0400
Subject: Re: [KJ][PATCH] Correct misc_register return code handling in
	several drivers
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: Neil Horman <nhorman@tuxdriver.com>
Cc: kernel-janitors@lists.osdl.org, kjhall@us.ibm.com, akpm@osdl.org,
       benh@kernel.crashing.org, maxk@qualcomm.com,
       linux-kernel@vger.kernel.org
In-Reply-To: <20061023171910.GA23714@hmsreliant.homelinux.net>
References: <20061023171910.GA23714@hmsreliant.homelinux.net>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Date: Mon, 23 Oct 2006 18:39:24 +0100
Message-Id: <1161625164.21701.18.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.6.2 (2.6.2-1.fc5.5) 
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Ar Llu, 2006-10-23 am 13:19 -0400, ysgrifennodd Neil Horman:
> +	for_each_online_node(node) {
> +		if(timers[node] != NULL)
> +			kfree(timers[node]);
> +	}

The if test appears to be redundant as kfree(NULL) is a valid no-op.

> +	if (misc_register(&hp_sdc_rtc_dev) != 0)
> +		printk(KERN_INFO "Could not register misc. dev for sdc\n");

Many users will misconstrue this has a hard disk name - is there a
better name to use.

>  	if (ret)
>  		printk(KERN_ERR "tun: Can't register misc device %d\n", TUN_MINOR);

These all really show that we should pass the name into the misc
register and do the printk there to cut down on random name variants and
kernel size. Separate problem, just noting it in case someone feels
inspired 8)

Alan

