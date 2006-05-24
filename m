Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932601AbWEXFer@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932601AbWEXFer (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 24 May 2006 01:34:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932603AbWEXFer
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 24 May 2006 01:34:47 -0400
Received: from mx3.mail.elte.hu ([157.181.1.138]:4497 "EHLO mx3.mail.elte.hu")
	by vger.kernel.org with ESMTP id S932601AbWEXFeq (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 24 May 2006 01:34:46 -0400
Date: Wed, 24 May 2006 07:34:47 +0200
From: Ingo Molnar <mingo@elte.hu>
To: Zachary Amsden <zach@vmware.com>
Cc: Andrew Morton <akpm@osdl.org>, Arjan van de Ven <arjan@infradead.org>,
       Linus Torvalds <torvalds@osdl.org>, jakub@redhat.com,
       rusty@rustcorp.com.au, kraxel@suse.de, linux-kernel@vger.kernel.org
Subject: Re: [patch 2/3] vdso: improve print_fatal_signals support by adding memory maps
Message-ID: <20060524053447.GA1934@elte.hu>
References: <20060523000126.GC9934@elte.hu> <44738C0C.9010107@vmware.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <44738C0C.9010107@vmware.com>
User-Agent: Mutt/1.4.2.1i
X-ELTE-SpamScore: 0.0
X-ELTE-SpamLevel: 
X-ELTE-SpamCheck: no
X-ELTE-SpamVersion: ELTE 2.0 
X-ELTE-SpamCheck-Details: score=0.0 required=5.9 tests=AWL autolearn=no SpamAssassin version=3.0.3
	0.0 AWL                    AWL: From: address is in the auto white-list
X-ELTE-VirusStatus: clean
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


* Zachary Amsden <zach@vmware.com> wrote:

> >+	if (current->mm)
> >+		printk("vDSO at %p\n", current->mm->context.vdso);
> >+#endif
> > 	show_regs(regs);
> >+	printk("\n");
> >+	print_vmas();
> > }
> > 
> > static int __init setup_print_fatal_signals(char *str
> 
> Perhaps I should have read your first patch more carefully - it did 
> have register info.  This looks even better (although you may now want 
> to allow it to be #ifdef'd out under CONFIG_EMBEDDED).
> 
> You probably should use PATH_MAX+1 instead of SIZE or check IS_ERR() 
> on the string from d_path.

the string is constructed on the stack, so 4K would be too much. 128 is 
i think enough for most purposes.

	Ingo
