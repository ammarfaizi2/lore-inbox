Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S315279AbSGINd6>; Tue, 9 Jul 2002 09:33:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S315293AbSGINd5>; Tue, 9 Jul 2002 09:33:57 -0400
Received: from ns.virtualhost.dk ([195.184.98.160]:61905 "EHLO virtualhost.dk")
	by vger.kernel.org with ESMTP id <S315279AbSGINd4>;
	Tue, 9 Jul 2002 09:33:56 -0400
Date: Tue, 9 Jul 2002 15:36:38 +0200
From: Jens Axboe <axboe@suse.de>
To: Roy Sigurd Karlsbakk <roy@karlsbakk.net>
Cc: Kernel mailing list <linux-kernel@vger.kernel.org>
Subject: Re: panic at boot with 2.5.25 with Jens's IDE patch
Message-ID: <20020709133638.GE1940@suse.de>
References: <200207091526.14703.roy@karlsbakk.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200207091526.14703.roy@karlsbakk.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jul 09 2002, Roy Sigurd Karlsbakk wrote:
> hi all
> 
> running (or trying to boot) 2.5.25, I get this little, cute panic :-)

Probably passing unitialized stuff to driversfs, please try and memset
gd in drivers/ide24/ide-probe.c:init_gendisk()

        gd        = kmalloc (sizeof(struct gendisk), GFP_KERNEL);
        if (!gd)
                goto err_kmalloc_gd;
+	memset(gd, 0, sizeof(*gd));

pseudo patch. Does that work?

-- 
Jens Axboe

