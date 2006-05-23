Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932228AbWEWW0W@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932228AbWEWW0W (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 23 May 2006 18:26:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932233AbWEWW0W
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 23 May 2006 18:26:22 -0400
Received: from mailout1.vmware.com ([65.113.40.130]:60677 "EHLO
	mailout1.vmware.com") by vger.kernel.org with ESMTP id S932228AbWEWW0V
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 23 May 2006 18:26:21 -0400
Message-ID: <44738C0C.9010107@vmware.com>
Date: Tue, 23 May 2006 15:26:20 -0700
From: Zachary Amsden <zach@vmware.com>
User-Agent: Thunderbird 1.5.0.2 (X11/20060420)
MIME-Version: 1.0
To: Ingo Molnar <mingo@elte.hu>
Cc: Andrew Morton <akpm@osdl.org>, Arjan van de Ven <arjan@infradead.org>,
       Linus Torvalds <torvalds@osdl.org>, jakub@redhat.com,
       rusty@rustcorp.com.au, kraxel@suse.de, linux-kernel@vger.kernel.org
Subject: Re: [patch 2/3] vdso: improve print_fatal_signals support by adding
 memory maps
References: <20060523000126.GC9934@elte.hu>
In-Reply-To: <20060523000126.GC9934@elte.hu>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Ingo Molnar wrote:
>  
>  static void print_fatal_signal(struct pt_regs *regs, int signr)
>  {
> @@ -781,9 +870,13 @@ static void print_fatal_signal(struct pt
>  			printk("%02x ", insn);
>  		}
>  	}
> -#endif
>  	printk("\n");
> +	if (current->mm)
> +		printk("vDSO at %p\n", current->mm->context.vdso);
> +#endif
>  	show_regs(regs);
> +	printk("\n");
> +	print_vmas();
>  }
>  
>  static int __init setup_print_fatal_signals(char *str

Perhaps I should have read your first patch more carefully - it did have 
register info.  This looks even better (although you may now want to 
allow it to be #ifdef'd out under CONFIG_EMBEDDED).

You probably should use PATH_MAX+1 instead of SIZE or check IS_ERR() on 
the string from d_path.

Zach
