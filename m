Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751325AbWF1QFR@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751325AbWF1QFR (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 28 Jun 2006 12:05:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751322AbWF1QFR
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 28 Jun 2006 12:05:17 -0400
Received: from outpipe-village-512-1.bc.nu ([81.2.110.250]:27090 "EHLO
	lxorguk.ukuu.org.uk") by vger.kernel.org with ESMTP
	id S1751272AbWF1QFO (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 28 Jun 2006 12:05:14 -0400
Subject: Re: [PATCH] ia64: change usermode HZ to 250
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: John Hawkes <hawkes@sgi.com>
Cc: Arjan van de Ven <arjan@infradead.org>, Tony Luck <tony.luck@gmail.com>,
       Andrew Morton <akpm@osdl.org>, linux-ia64@vger.kernel.org,
       linux-kernel@vger.kernel.org, Jack Steiner <steiner@sgi.com>,
       Dan Higgins <djh@sgi.com>, Jeremy Higdon <jeremy@sgi.com>
In-Reply-To: <005e01c69ac9$a55e1bf0$6f00a8c0@comcast.net>
References: <20060627220139.3168.69409.sendpatchset@tomahawk.engr.sgi.com>
	 <1151483994.3153.5.camel@laptopd505.fenrus.org>
	 <005e01c69ac9$a55e1bf0$6f00a8c0@comcast.net>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Date: Wed, 28 Jun 2006 17:21:08 +0100
Message-Id: <1151511668.15166.34.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.6.2 (2.6.2-1.fc5.5) 
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Ar Mer, 2006-06-28 am 08:43 -0700, ysgrifennodd John Hawkes:
> > #define HZ sysconf(_SC_CLK_TCK)
> 
> That did occur to me.  It obviously does get the correct value.  The downside
> is that one of those crufty apps that thinks it is using "HZ" as a constant
> will instead be invoking a more costly syscall.  Should we care about the
> resulting performance impact?

Given that HZ can be cached by glibc the performance impact is minimal
for most cases. The bigger problem will be code that does things with HZ
that only work on compile time evaluation. At least for those you'll
break at compile time.

Either way its kind of irrelevant, the ABI set HZ. Its done, there are
plenty of ways to change the kernel HZ without confusing userspace.

Alan

