Return-Path: <linux-kernel-owner+w=401wt.eu-S1751995AbWLNXm0@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751995AbWLNXm0 (ORCPT <rfc822;w@1wt.eu>);
	Thu, 14 Dec 2006 18:42:26 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751991AbWLNXm0
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 14 Dec 2006 18:42:26 -0500
Received: from smtp.osdl.org ([65.172.181.25]:42694 "EHLO smtp.osdl.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751995AbWLNXmZ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 14 Dec 2006 18:42:25 -0500
Date: Thu, 14 Dec 2006 15:42:11 -0800
From: Andrew Morton <akpm@osdl.org>
To: "Amitabha Roy" <amitabha.roy@gmail.com>
Cc: phil.el@wanadoo.fr, oprofile-list@lists.sourceforge.net,
       linux-kernel@vger.kernel.org
Subject: Re: [patch 1/1] oprofile: Add a special cookie for the VDSO region
Message-Id: <20061214154211.34b0a7f7.akpm@osdl.org>
In-Reply-To: <cf9d85500612110156y40341563ge96ae598f72ef303@mail.gmail.com>
References: <cf9d85500612110156y40341563ge96ae598f72ef303@mail.gmail.com>
X-Mailer: Sylpheed version 2.2.7 (GTK+ 2.8.6; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 11 Dec 2006 15:26:26 +0530
"Amitabha Roy" <amitabha.roy@gmail.com> wrote:

> Emit a special VDSO_COOKIE for VDSO regions instead of simply marking
> them as anon.

Why?

> Signed-off-by: Amitabha Roy <amitabha.roy@gmail.com>
> ---
> diff --git a/drivers/oprofile/buffer_sync.c b/drivers/oprofile/buffer_sync.c
> index 78c2e6e..7f879db 100644
> --- a/drivers/oprofile/buffer_sync.c
> +++ b/drivers/oprofile/buffer_sync.c
> @@ -250,7 +250,14 @@ static unsigned long lookup_dcookie(stru
>  				vma->vm_file->f_path.mnt);
>  			*offset = (vma->vm_pgoff << PAGE_SHIFT) + addr -
>  				vma->vm_start;
> -		} else {
> +		}
> +#ifdef CONFIG_X86_32
> +		else if(mm->context.vdso==vma->vm_start){
> +                        cookie = VDSO_COOKIE;
> +		        *offset = addr;
> +		}
> +#endif
> +		else {
>  			/* must be an anonymous map */
>  			*offset = addr;
>  		}
> diff --git a/drivers/oprofile/event_buffer.h b/drivers/oprofile/event_buffer.h
> index 9241627..edc8ee2 100644
> --- a/drivers/oprofile/event_buffer.h
> +++ b/drivers/oprofile/event_buffer.h
> @@ -35,6 +35,7 @@ #define CTX_TGID_CODE			7
>  #define TRACE_BEGIN_CODE		8
>  #define TRACE_END_CODE			9
> 
> +#define VDSO_COOKIE ~1UL
>  #define INVALID_COOKIE ~0UL
>  #define NO_COOKIE 0UL


