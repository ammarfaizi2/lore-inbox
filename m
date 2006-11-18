Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1756097AbWKRAT1@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756097AbWKRAT1 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 17 Nov 2006 19:19:27 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1756098AbWKRAT1
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 17 Nov 2006 19:19:27 -0500
Received: from gprs189-60.eurotel.cz ([160.218.189.60]:49087 "EHLO amd.ucw.cz")
	by vger.kernel.org with ESMTP id S1756097AbWKRAT0 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 17 Nov 2006 19:19:26 -0500
Date: Sat, 18 Nov 2006 01:19:07 +0100
From: Pavel Machek <pavel@ucw.cz>
To: Vivek Goyal <vgoyal@in.ibm.com>
Cc: linux kernel mailing list <linux-kernel@vger.kernel.org>,
       Reloc Kernel List <fastboot@lists.osdl.org>, ebiederm@xmission.com,
       akpm@osdl.org, ak@suse.de, hpa@zytor.com, magnus.damm@gmail.com,
       lwang@redhat.com, dzickus@redhat.com, rjw@sisk.pl
Subject: Re: [PATCH 12/20] x86_64: wakeup.S Misc cleanup
Message-ID: <20061118001907.GD9188@elf.ucw.cz>
References: <20061117223432.GA15449@in.ibm.com> <20061117224940.GM15449@in.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20061117224940.GM15449@in.ibm.com>
X-Warning: Reading this can be dangerous to your mental health.
User-Agent: Mutt/1.5.11+cvs20060126
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

> o Various cleanups. One of the main purpose of cleanups is that make
>   wakeup.S as close as possible to trampoline.S.
> 
> o Following are the changes
> 	- Indentations for comments.
> 	- Changed the gdt table to compact form and to resemble the
> 	  one in trampoline.S
> 	- Take the jump to 32bit from real mode using ljmpl. Makes code
> 	  more readable.
> 	- After enabling long mode, directly take a long jump for 64bit
> 	  mode. No need to take an extra jump to "reach_comaptibility_mode"
> 	- Stack is not used after real mode. So don't load stack in
>  	  32 bit mode.
> 	- No need to enable PGE here.
> 	- No need to do extra EFER read, anyway we trash the read contents.
> 	- No need to enable system call (EFER_SCE). Anyway it will be 
> 	  enabled when original EFER is restored.
> 	- No need to set MP, ET, NE, WP, AM bits in cr0. Very soon we will
>   	  reload the original cr0 while restroing the processor state.
> 
> Signed-off-by: Eric W. Biederman <ebiederm@xmission.com>
> Signed-off-by: Vivek Goyal <vgoyal@in.ibm.com>

ACK, minor nitpicks:

> +	/* ??? Why I need the accessed bit set in order for this to work? */

Yes, I'd like to know :-).

> +	.quad   0x00cf9b000000ffff              # __KERNEL32_CS
> +	.quad   0x00af9b000000ffff              # __KERNEL_CS
> +	.quad   0x00cf93000000ffff              # __KERNEL_DS

Can we get a comment telling us what to keep it in sync with?

									Pavel
-- 
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blog.html
