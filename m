Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267334AbUHDQJU@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267334AbUHDQJU (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 4 Aug 2004 12:09:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267331AbUHDQID
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 4 Aug 2004 12:08:03 -0400
Received: from pfepc.post.tele.dk ([195.41.46.237]:51249 "EHLO
	pfepc.post.tele.dk") by vger.kernel.org with ESMTP id S267334AbUHDQFq
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 4 Aug 2004 12:05:46 -0400
Date: Wed, 4 Aug 2004 18:07:09 +0200
From: Sam Ravnborg <sam@ravnborg.org>
To: Alexander Stohr <Alexander.Stohr@gmx.de>
Cc: linux-kernel@vger.kernel.org
Subject: Re: confirmed: kernel build for 2.6.8-rc3 is broken for at least i386
Message-ID: <20040804160709.GB7151@mars.ravnborg.org>
Mail-Followup-To: Alexander Stohr <Alexander.Stohr@gmx.de>,
	linux-kernel@vger.kernel.org
References: <24770.1091613003@www56.gmx.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <24770.1091613003@www56.gmx.net>
User-Agent: Mutt/1.5.6i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Aug 04, 2004 at 11:50:03AM +0200, Alexander Stohr wrote:
> a "make bzImage" produces this command:
> 
> cmd_arch/i386/kernel/vmlinux.lds.s :=                                       
>    
> gcc -E -Wp,-MD,arch/i386/kernel/.vmlinux.lds.s.d                            
>    
>  -nostdinc -iwithprefix include -D__KERNEL__ -Iinclude  -D__ASSEMBLY__      
>    
>  -Iinclude/asm-i386/mach-default -traditional                               
>    
>                                                                             
>    
>     -o arch/i386/kernel/vmlinux.lds.s arch/i386/kernel/vmlinux.lds.S        
>    
>                                                                             
>    
> it should produce something like this:
> 
> cmd_arch/i386/kernel/vmlinux.lds.s :=                                       
>    
> gcc -E -Wp,-MD,arch/i386/kernel/.vmlinux.lds.s.d                            
>    
>  -nostdinc -iwithprefix include -D__KERNEL__ -Iinclude  -D__ASSEMBLY__      
>    
>  -Iinclude/asm-i386/mach-default -traditional                               
>    
>  -P -C -Ui386                                                               
>    
>     -o arch/i386/kernel/vmlinux.lds.s arch/i386/kernel/vmlinux.lds.S
> 
> see the last but one line for the difference.

Could you please try to do the following:
1) Add the following lines to bottom of arch/i386/kernel/Makefile
$(warning AFLAGS-lds=$(AFLAGS_vmlinux.lds.o))
$(warning aflags=$(aflags))

2) Delete arch/i386/kernel/vmlinux.lds.s
3) make V=1 arch/i386/kernel/ > mail_to_sam 2>&1

And reply to this mail with output generated.

[Downloading atm. but see no changes that should impose this error].

Also - what shell / system are you using?

	Sam
