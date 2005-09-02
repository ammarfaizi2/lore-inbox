Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1161094AbVIBWxy@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161094AbVIBWxy (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 2 Sep 2005 18:53:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161095AbVIBWxy
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 2 Sep 2005 18:53:54 -0400
Received: from ms-smtp-04.nyroc.rr.com ([24.24.2.58]:26825 "EHLO
	ms-smtp-04.nyroc.rr.com") by vger.kernel.org with ESMTP
	id S1161094AbVIBWxx (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 2 Sep 2005 18:53:53 -0400
Date: Fri, 2 Sep 2005 19:20:47 -0400
From: Adam Kropelin <akropel1@rochester.rr.com>
To: Adrian Bunk <bunk@stusta.de>
Cc: Paul.Clements@steeleye.com, linux-kernel@vger.kernel.org
Subject: Re: [2.6 patch] drivers/block/nbd.c: don't defer compile error to runtime
Message-ID: <20050902192047.A5879@mail.kroptech.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <20050902221059.GY3657@stusta.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Adrian Bunk wrote:
> If we can detect a problem at compile time, the compilation should
> fail.

[...] 

>  	if (sizeof(struct nbd_request) != 28) {
> -		printk(KERN_CRIT "nbd: sizeof nbd_request needs to be 28 in order to work!\n" );
> -		return -EIO;
> +		extern void nbd_request_wrong_size(void);
> +		nbd_request_wrong_size();

	BUILD_BUG_ON(sizeof(struct nbd_request) != 28);

...perhaps?

--Adam

