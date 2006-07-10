Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965275AbWGJWZm@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965275AbWGJWZm (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 10 Jul 2006 18:25:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965278AbWGJWZl
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 10 Jul 2006 18:25:41 -0400
Received: from ogre.sisk.pl ([217.79.144.158]:27345 "EHLO ogre.sisk.pl")
	by vger.kernel.org with ESMTP id S965275AbWGJWZk (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 10 Jul 2006 18:25:40 -0400
From: "Rafael J. Wysocki" <rjw@sisk.pl>
To: Catalin Marinas <catalin.marinas@gmail.com>
Subject: Re: [PATCH] Fix a memory leak in the i386 setup code
Date: Tue, 11 Jul 2006 00:25:57 +0200
User-Agent: KMail/1.9.3
Cc: linux-kernel@vger.kernel.org
References: <20060710221308.5351.78741.stgit@localhost.localdomain>
In-Reply-To: <20060710221308.5351.78741.stgit@localhost.localdomain>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="utf-8"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200607110025.57812.rjw@sisk.pl>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

Does x86_64 need a similar fix?

On Tuesday 11 July 2006 00:13, Catalin Marinas wrote:
> From: Catalin Marinas <catalin.marinas@gmail.com>
> 
> Signed-off-by: Catalin Marinas <catalin.marinas@gmail.com>
> ---
> 
>  arch/i386/kernel/setup.c |    5 ++++-
>  1 files changed, 4 insertions(+), 1 deletions(-)
> 
> diff --git a/arch/i386/kernel/setup.c b/arch/i386/kernel/setup.c
> index 08c00d2..d32d264 100644
> --- a/arch/i386/kernel/setup.c
> +++ b/arch/i386/kernel/setup.c
> @@ -1327,7 +1327,10 @@ #endif
>  		res->start = e820.map[i].addr;
>  		res->end = res->start + e820.map[i].size - 1;
>  		res->flags = IORESOURCE_MEM | IORESOURCE_BUSY;
> -		request_resource(&iomem_resource, res);
> +		if (request_resource(&iomem_resource, res)) {
> +			kfree(res);
> +			continue;
> +		}
>  		if (e820.map[i].type == E820_RAM) {
>  			/*
>  			 *  We don't know which RAM region contains kernel data,
> -

Evidently res is used if e820.map[i].type == E820_RAM, so it should
be freed later on, it seems.

Greetings,
Rafael
