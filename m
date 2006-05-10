Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964785AbWEJGPc@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964785AbWEJGPc (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 10 May 2006 02:15:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964823AbWEJGPc
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 10 May 2006 02:15:32 -0400
Received: from wr-out-0506.google.com ([64.233.184.227]:60245 "EHLO
	wr-out-0506.google.com") by vger.kernel.org with ESMTP
	id S964785AbWEJGPc convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 10 May 2006 02:15:32 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:sender:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references:x-google-sender-auth;
        b=Ks2G1jfZfxwEptGlnyMsFP4W/A7+/Sh3sKAHC6RkuzpPNi6iBe5vukmtAfNf5tNSpIPFkNq3H93jVizIexuU5tpKHlTXV6gcba1g0GNnYJFru3Ul4/c7+FCH4/5bIpuWpae6EeoEFXI8uhJbebiE9djoTGYLiqppheIUEZT5uT0=
Message-ID: <84144f020605092315m30faf8f6n5c667c57e845b27f@mail.gmail.com>
Date: Wed, 10 May 2006 09:15:31 +0300
From: "Pekka Enberg" <penberg@cs.helsinki.fi>
To: "Daniel Walker" <dwalker@mvista.com>
Subject: Re: [PATCH -mm] megaraid gcc 4.1 warning fix
Cc: akpm@osdl.org, Seokmann.Ju@lsil.com, linux-kernel@vger.kernel.org
In-Reply-To: <200605100256.k4A2u3lB031731@dwalker1.mvista.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII;
	format=flowed
Content-Transfer-Encoding: 7BIT
Content-Disposition: inline
References: <200605100256.k4A2u3lB031731@dwalker1.mvista.com>
X-Google-Sender-Auth: cf6095ef90248132
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Daniel,

On 5/10/06, Daniel Walker <dwalker@mvista.com> wrote:
> -#define RDINDOOR(adapter)              readl((adapter)->base + 0x20)
> -#define RDOUTDOOR(adapter)             readl((adapter)->base + 0x2C)
> -#define WRINDOOR(adapter,value)                writel(value, (adapter)->base + 0x20)
> -#define WROUTDOOR(adapter,value)       writel(value, (adapter)->base + 0x2C)
> +#define RDINDOOR(adapter)              readl((void*)((adapter)->base + 0x20))
> +#define RDOUTDOOR(adapter)             readl((void*)((adapter)->base + 0x2C))
> +#define WRINDOOR(adapter,value)                writel(value, (void *)((adapter)->base + 0x20))
> +#define WROUTDOOR(adapter,value)       writel(value, (void*)((adapter)->base + 0x2C))

This looks wrong. adapter->base should be void __iomem *.

                                        Pekka
