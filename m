Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261537AbVFHXSs@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261537AbVFHXSs (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 8 Jun 2005 19:18:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261527AbVFHXSs
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 8 Jun 2005 19:18:48 -0400
Received: from dsl027-180-168.sfo1.dsl.speakeasy.net ([216.27.180.168]:52895
	"EHLO sunset.davemloft.net") by vger.kernel.org with ESMTP
	id S261451AbVFHXQn (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 8 Jun 2005 19:16:43 -0400
Date: Wed, 08 Jun 2005 16:16:33 -0700 (PDT)
Message-Id: <20050608.161633.55509444.davem@davemloft.net>
To: paulus@samba.org
Cc: torvalds@osdl.org, akpm@osdl.org, anton@samba.org,
       linux-kernel@vger.kernel.org, jk@blackdown.de
Subject: Re: [PATCH] ppc64: Fix PER_LINUX32 behaviour
From: "David S. Miller" <davem@davemloft.net>
In-Reply-To: <17063.31568.618739.165823@cargo.ozlabs.ibm.com>
References: <17062.56723.535978.961340@cargo.ozlabs.ibm.com>
	<Pine.LNX.4.58.0506081022030.2286@ppc970.osdl.org>
	<17063.31568.618739.165823@cargo.ozlabs.ibm.com>
X-Mailer: Mew version 3.3 on Emacs 21.4 / Mule 5.0 (SAKAKI)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

From: Paul Mackerras <paulus@samba.org>
Date: Thu, 9 Jun 2005 09:12:16 +1000

> There is still a point of difference between ppc64 and x86_64: on
> ppc64 (and on sparc64), if the personality is PER_LINUX32, the
> personality(0xffffffffUL) system call returns PER_LINUX, and attempts
> to set the personality to PER_LINUX don't change the personality
> (i.e. it stays set to PER_LINUX32), for both 32-bit and 64-bit
> processes.  On x86_64 this is true for 32-bit processes but not for
> 64-bit processes AFAICT.  Does anyone know why we do this at all, and
> whether doing it for 64-bit processes makes sense?

We do this because, at least when this code was written,
glibc would do a personality(PER_LINUX) call (either via
the dynamic linker or via some other libc startup code)
and this would undo the PER_LINUX32 setting.

Therefore, it makes sense to do this for all cases, not
just for 32-bit processes.  The x86_64 code ought to be
fixed, I think.
