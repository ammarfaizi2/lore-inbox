Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262202AbTFBMCO (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 2 Jun 2003 08:02:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262220AbTFBMCO
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 2 Jun 2003 08:02:14 -0400
Received: from holomorphy.com ([66.224.33.161]:29086 "EHLO holomorphy")
	by vger.kernel.org with ESMTP id S262202AbTFBMCN (ORCPT
	<rfc822;Linux-Kernel@vger.kernel.org>);
	Mon, 2 Jun 2003 08:02:13 -0400
Date: Mon, 2 Jun 2003 05:14:57 -0700
From: William Lee Irwin III <wli@holomorphy.com>
To: Nikita Danilov <Nikita@Namesys.COM>
Cc: Gianni Tedesco <gianni@scaramanga.co.uk>,
       Linux Kernel Mailing List <Linux-Kernel@Vger.Kernel.ORG>,
       Linus Torvalds <Torvalds@Transmeta.COM>, Andrew Morton <AKPM@Digeo.COM>
Subject: Re: const from include/asm-i386/byteorder.h
Message-ID: <20030602121457.GO8978@holomorphy.com>
Mail-Followup-To: William Lee Irwin III <wli@holomorphy.com>,
	Nikita Danilov <Nikita@Namesys.COM>,
	Gianni Tedesco <gianni@scaramanga.co.uk>,
	Linux Kernel Mailing List <Linux-Kernel@Vger.Kernel.ORG>,
	Linus Torvalds <Torvalds@Transmeta.COM>,
	Andrew Morton <AKPM@Digeo.COM>
References: <16088.47088.814881.791196@laputa.namesys.com> <1054406992.4837.0.camel@sherbert> <20030531185709.GK8978@holomorphy.com> <16091.14923.815819.792026@laputa.namesys.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <16091.14923.815819.792026@laputa.namesys.com>
Organization: The Domain of Holomorphy
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jun 02, 2003 at 03:51:39PM +0400, Nikita Danilov wrote:
> Gcc info page:
> `const'
>      Many functions do not examine any values except their arguments,
>      and have no effects except the return value.  Basically this is
>      just slightly more strict class than the `pure' attribute above,
>      since function is not allowed to read global memory.
> So, it seems byte swapping functions should be __attribute__((const))
> Here is a patch:

I'm very skeptical, in particular, about these hunks:


On Mon, Jun 02, 2003 at 03:51:39PM +0400, Nikita Danilov wrote:
>  #include <linux/thread_info.h>
> -static inline struct task_struct *get_current(void) __attribute__ (( __const__ ));
> +static inline struct task_struct *get_current(void) __attribute_const;
>  static inline struct task_struct *get_current(void)
>  {
> ===== include/asm-arm/thread_info.h 1.6 vs edited =====
> --- 1.6/include/asm-arm/thread_info.h	Sat Dec 28 19:26:45 2002
> +++ edited/include/asm-arm/thread_info.h	Mon Jun  2 14:44:24 2003
> @@ -74,7 +74,7 @@
>  /*
>   * how to get the thread information struct from C
>   */
> -static inline struct thread_info *current_thread_info(void) __attribute__ (( __const__ ));
> +static inline struct thread_info *current_thread_info(void) __attribute_const;
>  
>  static inline struct thread_info *current_thread_info(void)
>  {

Someone needs to doublecheck whether this actually works. Last I heard,
it did not, but that could have changed since. It vaguely appears some
assumption about it working was made recently since __const__ was there.


-- wli
