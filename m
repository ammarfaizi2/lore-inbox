Return-Path: <linux-kernel-owner+w=401wt.eu-S1762838AbWLKM5L@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1762838AbWLKM5L (ORCPT <rfc822;w@1wt.eu>);
	Mon, 11 Dec 2006 07:57:11 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1762852AbWLKM5L
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 11 Dec 2006 07:57:11 -0500
Received: from srv5.dvmed.net ([207.36.208.214]:45512 "EHLO mail.dvmed.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1762838AbWLKM5K (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 11 Dec 2006 07:57:10 -0500
Message-ID: <457D559C.2030702@garzik.org>
Date: Mon, 11 Dec 2006 07:57:00 -0500
From: Jeff Garzik <jeff@garzik.org>
User-Agent: Thunderbird 1.5.0.8 (X11/20061107)
MIME-Version: 1.0
To: David Howells <dhowells@redhat.com>
CC: Akinobu Mita <akinobu.mita@gmail.com>, torvalds@osdl.org, akpm@osdl.org,
       linux-kernel@vger.kernel.org, Al Viro <viro@zeniv.linux.org.uk>
Subject: Re: Mark bitrevX() functions as const
References: <29447.1165840536@redhat.com>
In-Reply-To: <29447.1165840536@redhat.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Score: -4.3 (----)
X-Spam-Report: SpamAssassin version 3.1.7 on srv5.dvmed.net summary:
	Content analysis details:   (-4.3 points, 5.0 required)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

David Howells wrote:
> Mark the bit reversal functions as being const as they always return the same
> output for any given input.
> 
> Signed-Off-By: David Howells <dhowells@redhat.com>
> ---
> 
>  include/linux/bitrev.h |    4 ++--
>  1 files changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/include/linux/bitrev.h b/include/linux/bitrev.h
> index 05e540d..032056b 100644
> --- a/include/linux/bitrev.h
> +++ b/include/linux/bitrev.h
> @@ -5,11 +5,11 @@ #include <linux/types.h>
>  
>  extern u8 const byte_rev_table[256];
>  
> -static inline u8 bitrev8(u8 byte)
> +static inline __attribute__((const)) u8 bitrev8(u8 byte)
>  {
>  	return byte_rev_table[byte];
>  }
>  
> -extern u32 bitrev32(u32 in);
> +extern __attribute__((const)) u32 bitrev32(u32 in);


Comments:

* overall, I agree with this type of change.  several Linux lib 
functions could use this sort of annotation.

* I question its usefulness on static [inline] functions, because the 
compiler should be able to figure out side effects.  have you examined 
before-and-after asm to see if the code generation changes for the 
inlined area?

* naked __attribute__ is ugly.  define something short and memorable in 
include/linux/compiler.h.

* another annotation to consider is C99 keyword 'restrict'.

	Jeff



