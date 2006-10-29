Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965287AbWJ2Qm2@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965287AbWJ2Qm2 (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 29 Oct 2006 11:42:28 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965290AbWJ2Qm2
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 29 Oct 2006 11:42:28 -0500
Received: from ns.suse.de ([195.135.220.2]:49855 "EHLO mx1.suse.de")
	by vger.kernel.org with ESMTP id S965287AbWJ2Qm1 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 29 Oct 2006 11:42:27 -0500
From: Andi Kleen <ak@suse.de>
To: virtualization@lists.osdl.org
Subject: Re: [PATCH 6/7] Add APIC accessors to paravirt-ops.
Date: Sun, 29 Oct 2006 08:31:20 -0800
User-Agent: KMail/1.9.1
Cc: Chris Wright <chrisw@sous-sol.org>, akpm@osdl.org, ak@muc.de,
       linux-kernel@vger.kernel.org
References: <20061029024504.760769000@sous-sol.org> <20061029024607.401333000@sous-sol.org>
In-Reply-To: <20061029024607.401333000@sous-sol.org>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200610290831.21062.ak@suse.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


>
>  /* nop stub */
>  static void native_nop(void)
> @@ -382,6 +384,26 @@ static fastcall void native_io_delay(voi
>  	asm volatile("outb %al,$0x80");
>  }
>
> +#ifdef CONFIG_X86_LOCAL_APIC

It would be nicer if you renamed the functions in apic.h to native_apic_*
and then do

#ifdef CONFIG_PARAVIRT
#include <asm/paravirt.h>
#else
#define apic_read native_apic_read
...
#endif

This way we wouldn't get that much duplication.

This might apply to at least some of the other paravirt ops too.

-Andi
