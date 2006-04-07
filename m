Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932327AbWDGH2P@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932327AbWDGH2P (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 7 Apr 2006 03:28:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932326AbWDGH2P
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 7 Apr 2006 03:28:15 -0400
Received: from wproxy.gmail.com ([64.233.184.232]:33975 "EHLO wproxy.gmail.com")
	by vger.kernel.org with ESMTP id S932327AbWDGH2O convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 7 Apr 2006 03:28:14 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=KPW3vyptmMIReDLUNxEqfOKTLFD0z938mxvGMVHaPDE26iibmofYKb2MG8gOKCEJ9dQEsT2/ZowOEANIemoH9ezCR/c+QaqOoNTWZsWC/Z+MrEu/iJsoiYBag9CTFiG/b5+0H1kNmxReQgBqYRV36z9kG5d9yGjWVB3jut2Usc4=
Message-ID: <489ecd0c0604070028s2f6dc900ha4b5b3d19ef7df41@mail.gmail.com>
Date: Fri, 7 Apr 2006 15:28:13 +0800
From: "Luke Yang" <luke.adi@gmail.com>
To: "Andrew Morton" <akpm@osdl.org>
Subject: Re: Fw: [PATCH] use "#ifdef __KERNEL" to avoid compile error in input.h
Cc: "Dmitry Torokhov" <dtor_core@ameritech.net>, linux-kernel@vger.kernel.org
In-Reply-To: <20060406230822.2f3e45df.akpm@osdl.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Content-Disposition: inline
References: <20060406230822.2f3e45df.akpm@osdl.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 4/7/06, Andrew Morton <akpm@osdl.org> wrote:
> Hi all,
>
>     In linux/input.h, struct input_device_id uses type kernel_ulong_t,
> which is defined in linux/mod_devicetable.h,  but which is only
> included when __KERNEL__ is defined. So struct input_device_id should
> also be exported only in kernel mode.
>
> Signed-off-by: Luke Yang <luke.adi@gmail.com>
>
> diff --git a/include/linux/input.h b/include/linux/input.h
> index b0e612d..0319b65 100644
> --- a/include/linux/input.h
> +++ b/include/linux/input.h
> @@ -805,6 +805,7 @@ #define FF_AUTOCENTER       0x61
>
>  #define FF_MAX         0x7f
>
> +#ifdef __KERNEL__
>  struct input_device_id {
>
>         kernel_ulong_t flags;
> @@ -823,6 +824,7 @@ struct input_device_id {
>
>         kernel_ulong_t driver_info;
>  };
> +#endif
>
>  /*
>   * Structure for hotplug & device<->driver matching.
>
  Ooops, there is problem with the patch. The script/mod/file2alias.c
need the struct input_device_id, and it defines the "kernel_ulong_t"
by itself... Dmitry, any thought on how to solve the problem?



--
Best regards,
Luke Yang
luke.adi@gmail.com
