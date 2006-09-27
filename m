Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751227AbWI0Ql2@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751227AbWI0Ql2 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 27 Sep 2006 12:41:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751229AbWI0Ql1
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 27 Sep 2006 12:41:27 -0400
Received: from moutng.kundenserver.de ([212.227.126.177]:44743 "EHLO
	moutng.kundenserver.de") by vger.kernel.org with ESMTP
	id S1751227AbWI0Ql1 convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 27 Sep 2006 12:41:27 -0400
From: Arnd Bergmann <arnd@arndb.de>
To: Robin Getz <rgetz@blackfin.uclinux.org>
Subject: Re: [PATCH 1/4] Blackfin: arch patch for 2.6.18
Date: Wed, 27 Sep 2006 18:41:13 +0200
User-Agent: KMail/1.9.4
Cc: luke Yang <luke.adi@gmail.com>, Andrew Morton <akpm@osdl.org>,
       linux-kernel@vger.kernel.org
References: <6.1.1.1.0.20060927121508.01ecea90@ptg1.spd.analog.com>
In-Reply-To: <6.1.1.1.0.20060927121508.01ecea90@ptg1.spd.analog.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 8BIT
Content-Disposition: inline
Message-Id: <200609271841.14135.arnd@arndb.de>
X-Provags-ID: kundenserver.de abuse@kundenserver.de login:c48f057754fc1b1a557605ab9fa6da41
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wednesday 27 September 2006 18:25, Robin Getz wrote:
> +#define idle_with_irq_disabled() do {   \
> +        __asm__ __volatile__ (          \
> +                "nop; nop;\n"           \
> +                ".align 8;\n"           \
> +                "sti %0; idle;\n"       \
> +                ::"d" (irq_flags));     \
> +} while (0)
> 

The irq_flags are not declared anywhere in the code you just posted,
I guess you could simply declare a local variable in this macro.

It would also be better to convert macros like this one to inline
functions in general. The rule is: if you can use either a macro
or an inline function with the same effect, use an inline function.

	Arnd <><
