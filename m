Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263449AbTFDPR2 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 4 Jun 2003 11:17:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263451AbTFDPR2
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 4 Jun 2003 11:17:28 -0400
Received: from pub237.cambridge.redhat.com ([213.86.99.237]:7644 "EHLO
	passion.cambridge.redhat.com") by vger.kernel.org with ESMTP
	id S263449AbTFDPR0 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 4 Jun 2003 11:17:26 -0400
Subject: Re: [PATCH] fixed: CRC32=y && 8193TOO=m unresolved symbols
From: David Woodhouse <dwmw2@infradead.org>
To: Jeff Garzik <jgarzik@pobox.com>
Cc: Stewart Smith <stewartsmith@mac.com>,
       Linus Torvalds <torvalds@transmeta.com>, linux-kernel@vger.kernel.org,
       Stewart Smith <stewart@linux.org.au>
In-Reply-To: <20030604152806.GE19929@gtf.org>
References: <1054646171.17921.64.camel@passion.cambridge.redhat.com>
	 <3D3CD66D-9651-11D7-A060-00039346F142@mac.com>
	 <20030604152806.GE19929@gtf.org>
Content-Type: text/plain
Organization: 
Message-Id: <1054740649.17921.292.camel@passion.cambridge.redhat.com>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.2.2 (1.2.2-5.dwmw2) 
Date: Wed, 04 Jun 2003 16:30:49 +0100
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2003-06-04 at 16:28, Jeff Garzik wrote:

> You can't EXPORT_SYMBOL from a header.
> 
> This sounds like Kconfig or Makefile bugs to me... all the
> export-symbol stuff should already be in place.
> 
> Can you post your .config and the exact build errors you are getting?

It's because lib/crc32.o isn't actually _referenced_ by anything, hence
isn't actually pulled into vmlinux from lib/lib.a.

My fix in the 2.4 tree is to export its symbols from kernel/ksyms.c
#ifdef CONFIG_CRC32, and to export its symbols from lib/crc32.c 
#ifndef CONFIG_CRC32.

-- 
dwmw2

