Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750738AbVKKXyp@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750738AbVKKXyp (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 11 Nov 2005 18:54:45 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750745AbVKKXyp
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 11 Nov 2005 18:54:45 -0500
Received: from zproxy.gmail.com ([64.233.162.200]:52177 "EHLO zproxy.gmail.com")
	by vger.kernel.org with ESMTP id S1750738AbVKKXyp convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 11 Nov 2005 18:54:45 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=PyTN9nyGRu53jZF5Q4NTTukyxlD0bAfUcRKI8mhZ+1GCeeYOgDqf9eCMPuOvn6Be8dfVtn4GL6n2Q/igfxvlXxHPwlHHIw27yTlJVntLR/msDPNri+et436RhpXkwoJbf9lfys9LynML3h0bRGfzjs2Ta+FhoIoLz7lon5dd3vI=
Message-ID: <6bffcb0e0511111554h1b0e81d5t@mail.gmail.com>
Date: Sat, 12 Nov 2005 00:54:44 +0100
From: Michal Piotrowski <michal.k.k.piotrowski@gmail.com>
To: "Antonino A. Daplas" <adaplas@gmail.com>
Subject: Re: [PATCH] nvidiafb: Fix bug in nvidiafb_pan_display
Cc: Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org,
       "Antonino A. Daplas" <adaplas@pol.net>,
       Benjamin Herrenschmidt <benh@kernel.crashing.org>
In-Reply-To: <4375291F.3040508@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Content-Disposition: inline
References: <20051110203544.027e992c.akpm@osdl.org>
	 <6bffcb0e0511111432m771dcda2y@mail.gmail.com>
	 <20051111150108.265b2d3f.akpm@osdl.org> <4375291F.3040508@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On 12/11/05, Antonino A. Daplas <adaplas@gmail.com> wrote:
> nvidiafb_pan_display() is incorrectly using the fields in
> info->var instead of var passed to the function.
>
> Signed-off-by: Antonino Daplas <adaplas@pol.net>
> ---
[snip]
> Looks like a bug in nvidiafb_pan_display() which was revealed when I
> changed the semantics of update_var/update_start.
>
> Try this patch.
>
> Tony
>
>  nvidia.c |    2 +-
>  1 files changed, 1 insertion(+), 1 deletion(-)
>
>
> diff --git a/drivers/video/nvidia/nvidia.c b/drivers/video/nvidia/nvidia.c
> index 0b40a2a..bee09c6 100644
> --- a/drivers/video/nvidia/nvidia.c
> +++ b/drivers/video/nvidia/nvidia.c
> @@ -1301,7 +1301,7 @@ static int nvidiafb_pan_display(struct f
>         struct nvidia_par *par = info->par;
>         u32 total;
>
> -       total = info->var.yoffset * info->fix.line_length + info->var.xoffset;
> +       total = var->yoffset * info->fix.line_length + var->xoffset;
>
>         NVSetStartAddress(par, total);
>
>
>

Problem fixed. Great thanks.

Regards,
Michal Piotrowski
