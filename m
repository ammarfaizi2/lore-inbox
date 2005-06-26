Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261564AbVFZT0P@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261564AbVFZT0P (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 26 Jun 2005 15:26:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261578AbVFZT0P
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 26 Jun 2005 15:26:15 -0400
Received: from smtp.osdl.org ([65.172.181.4]:37077 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S261564AbVFZT0N (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 26 Jun 2005 15:26:13 -0400
Date: Sun, 26 Jun 2005 12:25:38 -0700
From: Andrew Morton <akpm@osdl.org>
To: Adam Kropelin <akropel1@rochester.rr.com>
Cc: linux-kernel@vger.kernel.org, vojtech@suse.cz, greg@kroah.com,
       dtor@mail.ru
Subject: Re: 2.6.12-mm2
Message-Id: <20050626122538.34152dda.akpm@osdl.org>
In-Reply-To: <20050626101851.A18283@mail.kroptech.com>
References: <20050626040329.3849cf68.akpm@osdl.org>
	<20050626101851.A18283@mail.kroptech.com>
X-Mailer: Sylpheed version 1.0.4 (GTK+ 1.2.10; i386-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Adam Kropelin <akropel1@rochester.rr.com> wrote:
>
> I'd like to lobby for the merging into mainline of this patch from
> git-input. It fixes a real bug, seen by real users, and has been
> languishing in the input tree since March. It may also be a candidate
> for the stable tree given it's one-linedness.
> 

I think we can merge all of git-input into Linus's tree immediately.

But if that'll take some time then sure, we can merge up this little bit.

> 
> Fix extraction of HID items >= 32 bits
> 
> HID items of width 32 (bits) or greater are incorrectly extracted due to
> a masking bug in hid-core.c:extract(). This patch fixes it up by forcing
> the mask to be 64 bits wide.
> 
> 
> Signed-off-by: Adam Kropelin <akropel1@rochester.rr.com>
> 
> 
> --- linux-2.6.11/drivers/usb/input/hid-core.c	Thu Mar  3 20:40:49 2005
> +++ linux-2.6.11.adk/drivers/usb/input/hid-core.c	Sun Mar 13 14:00:47 2005
> @@ -757,7 +757,7 @@
>  static __inline__ __u32 extract(__u8 *report, unsigned offset, unsigned n)
>  {
>  	report += (offset >> 5) << 2; offset &= 31;
> -	return (le64_to_cpu(get_unaligned((__le64*)report)) >> offset) & ((1 << n) - 1);
> +	return (le64_to_cpu(get_unaligned((__le64*)report)) >> offset) & ((1ULL << n) - 1);
>  }
>  
>  static __inline__ void implement(__u8 *report, unsigned offset, unsigned n, __u32 value)
