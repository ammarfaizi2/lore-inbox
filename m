Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1752552AbWKAXTZ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752552AbWKAXTZ (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 1 Nov 2006 18:19:25 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752554AbWKAXTZ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 1 Nov 2006 18:19:25 -0500
Received: from rgminet01.oracle.com ([148.87.113.118]:38584 "EHLO
	rgminet01.oracle.com") by vger.kernel.org with ESMTP
	id S1752553AbWKAXTY (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 1 Nov 2006 18:19:24 -0500
Date: Wed, 1 Nov 2006 15:14:52 -0800
From: Randy Dunlap <randy.dunlap@oracle.com>
To: Jesper Juhl <jesper.juhl@gmail.com>
Cc: linux-kernel@vger.kernel.org, Linus Torvalds <torvalds@osdl.org>,
       billm@suburbia.net
Subject: Re: [PATCH] bail out in mathemu if __copy_to_user fails
Message-Id: <20061101151452.0a1f3a96.randy.dunlap@oracle.com>
In-Reply-To: <200611020003.16424.jesper.juhl@gmail.com>
References: <200611020003.16424.jesper.juhl@gmail.com>
Organization: Oracle Linux Eng.
X-Mailer: Sylpheed version 2.2.9 (GTK+ 2.8.10; x86_64-unknown-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Brightmail-Tracker: AAAAAQAAAAI=
X-Brightmail-Tracker: AAAAAQAAAAI=
X-Whitelist: TRUE
X-Whitelist: TRUE
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2 Nov 2006 00:03:16 +0100 Jesper Juhl wrote:

> I believe we should check the return value of 
> __copy_to_user in math-emu/fpu_entry.c and bail out of save_i387_soft() if 
> it fails.
> This patch does that.
> 
> This also kills the warning :
>   arch/i386/math-emu/fpu_entry.c:745: warning: ignoring return value of `__copy_to_user', declared with attribute warn_unused_result


http://www.kernel.org/pub/linux/kernel/people/akpm/patches/2.6/2.6.19-rc4/2.6.19-rc4-mm1/broken-out/x86_64-mm-i386-mathemu-must-check.patch


> Signed-off-by: Jesper Juhl <jesper.juhl@gmail.com>
> ---
> 
> diff --git a/arch/i386/math-emu/fpu_entry.c b/arch/i386/math-emu/fpu_entry.c
> index d93f16e..ddf8fa3 100644
> --- a/arch/i386/math-emu/fpu_entry.c
> +++ b/arch/i386/math-emu/fpu_entry.c
> @@ -742,7 +742,8 @@ #ifdef PECULIAR_486
>    S387->fcs &= ~0xf8000000;
>    S387->fos |= 0xffff0000;
>  #endif /* PECULIAR_486 */
> -  __copy_to_user(d, &S387->cwd, 7*4);
> +  if (__copy_to_user(d, &S387->cwd, 7*4))
> +    return -1;
>    RE_ENTRANT_CHECK_ON;
>  
>    d += 7*4;


---
~Randy
