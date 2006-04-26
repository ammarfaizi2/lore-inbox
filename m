Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964833AbWDZPvO@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964833AbWDZPvO (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 26 Apr 2006 11:51:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964837AbWDZPvO
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 26 Apr 2006 11:51:14 -0400
Received: from xenotime.net ([66.160.160.81]:13978 "HELO xenotime.net")
	by vger.kernel.org with SMTP id S964833AbWDZPvN (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 26 Apr 2006 11:51:13 -0400
Date: Wed, 26 Apr 2006 08:53:38 -0700
From: "Randy.Dunlap" <rdunlap@xenotime.net>
To: "Jan Beulich" <jbeulich@novell.com>
Cc: ak@suse.de, linux-kernel@vger.kernel.org, discuss@x86-64.org
Subject: Re: [PATCH] serialize assign_irq_vector() use of static variables
Message-Id: <20060426085338.c1cd6b94.rdunlap@xenotime.net>
In-Reply-To: <444F9AD9.76E4.0078.0@novell.com>
References: <444F9AD9.76E4.0078.0@novell.com>
Organization: YPO4
X-Mailer: Sylpheed version 2.2.4 (GTK+ 2.8.3; x86_64-unknown-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 26 Apr 2006 16:07:53 +0200 Jan Beulich wrote:

> Since assign_irq_vector() can be called at runtime, its access of static
> variables should be protected by a lock.
> 
> Signed-off-by: Jan Beulich <jbeulich@novell.com>

Hi,
Would you include diffstat output also, as mentioned (optional)
in Documentation/SubmittingPatches?  I'd really like to see a list
of patched files without having to scan the entire patch.
Thanks.

Oh, the diff filenames should begin at the linux-2.x.y level so
that they can be applied with patch -p1.
Lots of tools know how to do this.

> diff -Npru /home/jbeulich/tmp/linux-2.6.17-rc2/arch/i386/kernel/io_apic.c
> 2.6.17-rc2-x86-assign_irq_vector-lock/arch/i386/kernel/io_apic.c
> --- /home/jbeulich/tmp/linux-2.6.17-rc2/arch/i386/kernel/io_apic.c	2006-04-26 10:55:11.000000000 +0200
> +++ 2.6.17-rc2-x86-assign_irq_vector-lock/arch/i386/kernel/io_apic.c	2006-04-25 15:38:32.000000000 +0200
> @@ -1163,16 +1170,21 @@ next:
>  
>  	if (current_vector >= FIRST_SYSTEM_VECTOR) {
>  		offset++;
> -		if (!(offset%8))
> +		if (!(offset%8)) {

Use better spacing here:  (offset % 8)

> +			spin_unlock(&vector_lock);
>  			return -ENOSPC;
> +		}
>  		current_vector = FIRST_DEVICE_VECTOR + offset;
>  	}
>  

---
~Randy
