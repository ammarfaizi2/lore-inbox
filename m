Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S135709AbREBSMl>; Wed, 2 May 2001 14:12:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S135711AbREBSMc>; Wed, 2 May 2001 14:12:32 -0400
Received: from edtn006530.hs.telusplanet.net ([161.184.137.180]:53261 "EHLO
	mail.harddata.com") by vger.kernel.org with ESMTP
	id <S135709AbREBSMQ>; Wed, 2 May 2001 14:12:16 -0400
Date: Wed, 2 May 2001 12:12:03 -0600
From: Michal Jaegermann <michal@harddata.com>
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Linux 2.4.4-ac3
Message-ID: <20010502121203.A27478@mail.harddata.com>
In-Reply-To: <E14uhhF-0002Q8-00@the-village.bc.nu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <E14uhhF-0002Q8-00@the-village.bc.nu>; from alan@lxorguk.ukuu.org.uk on Tue, May 01, 2001 at 10:28:35PM +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, May 01, 2001 at 10:28:35PM +0100, Alan Cox wrote:
> 
....
> 2.4.4-ac3
....

Does not compile on Alpha.  I have a strange feeling that because
of this:-)
> o	Fix module exception race on Alpha		(Andrea Arcangeli)

A declaration was forgotten and, comparing with i386 equivalent, this
minor correction is required:

--- linux-2.4.4-ac/arch/alpha/mm/extable.c~	Wed May  2 11:08:43 2001
+++ linux-2.4.4-ac/arch/alpha/mm/extable.c	Wed May  2 12:08:50 2001
@@ -36,6 +36,8 @@
 
 register unsigned long gp __asm__("$29");
 
+extern spinlock_t modlist_lock;
+
 static unsigned
 search_exception_table_without_gp(unsigned long addr)
 {

    Michal

