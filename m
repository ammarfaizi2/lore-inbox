Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965142AbWGFJTL@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965142AbWGFJTL (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 6 Jul 2006 05:19:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965166AbWGFJTL
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 6 Jul 2006 05:19:11 -0400
Received: from smtp.osdl.org ([65.172.181.4]:60298 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S965142AbWGFJTJ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 6 Jul 2006 05:19:09 -0400
Date: Thu, 6 Jul 2006 02:19:06 -0700
From: Andrew Morton <akpm@osdl.org>
To: Haavard Skinnemoen <hskinnemoen@atmel.com>
Cc: linux-kernel@vger.kernel.org, torvalds@osdl.org
Subject: Re: AVR32 architecture patch against Linux 2.6.18-rc1 available
Message-Id: <20060706021906.1af7ffa3.akpm@osdl.org>
In-Reply-To: <20060706105227.220565f8@cad-250-152.norway.atmel.com>
References: <20060706105227.220565f8@cad-250-152.norway.atmel.com>
X-Mailer: Sylpheed version 2.2.4 (GTK+ 2.8.17; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 6 Jul 2006 10:52:27 +0200
Haavard Skinnemoen <hskinnemoen@atmel.com> wrote:

> Hi everyone,
> 
> I've put up an updated set of patches for AVR32 support at
> http://avr32linux.org/twiki/bin/view/Main/LinuxPatches
> 
> The most interesting patch probably is
> http://avr32linux.org/twiki/pub/Main/LinuxPatches/avr32-arch-2.patch
> 
> which, at 544K, is too large to attach here. Please let me know if you
> want me to do it anyway.
> 
> Anyone want to have a look at this? I understand that a full review is
> a huge job, but I'd appreciate a pointer or two in the general
> direction that I need to take this in order to get it acceptable for
> mainline.
> 

Looks pretty sane from a quick scan.

- request_irq() can use GFP_KERNEL?

- show_interrupts() should use for_each_online_cpu()

<wow, kprobes support>

- do you really need __udivdi3() and friends?  We struggle hard to avoid
  the necessity on x86 and you should be able to leverage that advantage.

- What are these for?

	+EXPORT_SYMBOL(register_dma_controller);
	+EXPORT_SYMBOL(find_dma_controller);

	+EXPORT_SYMBOL(clk_get);
	+EXPORT_SYMBOL(clk_put);
	+EXPORT_SYMBOL(clk_enable);
	+EXPORT_SYMBOL(clk_disable);
	+EXPORT_SYMBOL(clk_get_rate);
	+EXPORT_SYMBOL(clk_round_rate);
	+EXPORT_SYMBOL(clk_set_rate);
	+EXPORT_SYMBOL(clk_set_parent);
	+EXPORT_SYMBOL(clk_get_parent);

- Was there a ./MAINTAINERS patch?  I didn't see one.

- Who stands behind this port?  How do we know this isn't a patch-n-run
  exercise?  How do we know that the code won't rot?

- How does one build a something->avr32 cross-toolchain?

Thanks.
