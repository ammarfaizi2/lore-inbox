Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261346AbSKBUAT>; Sat, 2 Nov 2002 15:00:19 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261349AbSKBUAS>; Sat, 2 Nov 2002 15:00:18 -0500
Received: from nat-pool-rdu.redhat.com ([66.187.233.200]:50273 "EHLO
	devserv.devel.redhat.com") by vger.kernel.org with ESMTP
	id <S261346AbSKBUAQ>; Sat, 2 Nov 2002 15:00:16 -0500
From: Alan Cox <alan@redhat.com>
Message-Id: <200211022006.gA2K6XW08545@devserv.devel.redhat.com>
Subject: Re: swsusp: don't eat ide disks
To: pavel@ucw.cz (Pavel Machek)
Date: Sat, 2 Nov 2002 15:06:33 -0500 (EST)
Cc: torvalds@transmeta.com, linux-kernel@vger.kernel.org (kernel list),
       alan@redhat.com
In-Reply-To: <20021102184735.GA179@elf.ucw.cz> from "Pavel Machek" at Nov 02, 2002 07:47:35 PM
X-Mailer: ELM [version 2.5 PL6]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> Here's patch to prevent random scribling over disks during
> suspend... In the meantime alan killed (unreferenced at that time)
> idedisk_suspend() and idedisk_release(), so I have to reintroduce
> them.

Please fix this at a different level. idedisk is not the place to be
doing this. If the device layer is doing the right thing then the
request queue will be idle. 

> +	.gen_driver		= {
> +		.suspend	= idedisk_suspend,
> +		.resume		= idedisk_resume,
> +	}

Some disks are going to be settint their own power methods too.

