Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S287919AbSBMRiV>; Wed, 13 Feb 2002 12:38:21 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S287966AbSBMRiN>; Wed, 13 Feb 2002 12:38:13 -0500
Received: from maile.telia.com ([194.22.190.16]:59857 "EHLO maile.telia.com")
	by vger.kernel.org with ESMTP id <S287919AbSBMRiB> convert rfc822-to-8bit;
	Wed, 13 Feb 2002 12:38:01 -0500
Message-ID: <006701c1b4b4$b8ef7ba0$0b02a8c0@pcu80>
From: "Per Persson" <per.persson@gnosjo.pp.se>
To: <linux-kernel@vger.kernel.org>
In-Reply-To: <fa.j3e61kv.181e63g@ifi.uio.no>
Subject: Re: Unable to compile 2.5.4: "control reaches end of non-void functionm"
Date: Wed, 13 Feb 2002 18:34:35 +0100
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
X-Priority: 3
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook Express 5.00.2919.6700
X-MimeOLE: Produced By Microsoft MimeOLE V5.00.2919.6700
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi all!

I had the same problem but found the following post from David Howells.

  /Per


> Subject: [PATCH] 2.5.4 compile error fix
>
> 
> Hi Linus,
> 
> This patch fixes <asm-i386/processor.h> trying to access task_struct (which
> can't have been defined at that point).
> 
> David
> 
> diff -uNr linux-2.5.4/include/asm-i386/processor.h linux-orn-254/include/asm-i386/processor.h
> --- linux-2.5.4/include/asm-i386/processor.h Mon Feb 11 09:41:35 2002
> +++ linux-orn-254/include/asm-i386/processor.h Mon Feb 11 10:29:29 2002
> @@ -439,10 +439,7 @@
>  /*
>   * Return saved PC of a blocked thread.
>   */
> -static inline unsigned long thread_saved_pc(struct task_struct *tsk)
> -{
> - return ((unsigned long *)tsk->thread->esp)[3];
> -}
> +#define thread_saved_pc(TSK) (((unsigned long *)(TSK)->thread.esp)[3])
>  
>  unsigned long get_wchan(struct task_struct *p);
>  #define KSTK_EIP(tsk) (((unsigned long *)(4096+(unsigned long)(tsk)->thread_info))[1019])
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/


