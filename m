Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262303AbSKHTtg>; Fri, 8 Nov 2002 14:49:36 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262304AbSKHTtg>; Fri, 8 Nov 2002 14:49:36 -0500
Received: from [202.88.171.30] ([202.88.171.30]:53941 "EHLO dikhow.hathway.com")
	by vger.kernel.org with ESMTP id <S262303AbSKHTtg>;
	Fri, 8 Nov 2002 14:49:36 -0500
Date: Sat, 9 Nov 2002 01:23:36 +0530
From: Dipankar Sarma <dipankar@gamebox.net>
To: Petr Vandrovec <VANDROVE@vc.cvut.cz>
Cc: Rusty Russell <rusty@rustcorp.com.au>,
       Linus Torvalds <torvalds@transmeta.com>, linux-kernel@vger.kernel.org
Subject: Re: [TRIVIAL] Re: UP went into unexpected trashing
Message-ID: <20021109012336.A25293@dikhow>
Reply-To: dipankar@gamebox.net
References: <6EF6764388E@vcnet.vc.cvut.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <6EF6764388E@vcnet.vc.cvut.cz>; from VANDROVE@vc.cvut.cz on Fri, Nov 08, 2002 at 04:40:13PM +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Nov 08, 2002 at 04:40:13PM +0100, Petr Vandrovec wrote:
> On  8 Nov 02 at 19:33, Rusty Trivial Russell wrote:
> 
> So maybe callers should just treat any return value >= size as "not found",
> leaving older smaller code in place.

Or add a check in there. I can't figure out a way to avoid the extra 
conditional branch anyway :)

Thanks
Dipankar

diff -urN linux-2.5.46-base/include/asm-i386/bitops.h linux-2.5.46-misc/include/asm-i386/bitops.h
--- linux-2.5.46-base/include/asm-i386/bitops.h	Sat Sep 28 03:20:22 2002
+++ linux-2.5.46-misc/include/asm-i386/bitops.h	Sat Nov  9 01:08:56 2002
@@ -317,7 +317,7 @@
 		"addl %%edi,%%eax"
 		:"=a" (res), "=&c" (d0), "=&D" (d1)
 		:"1" ((size + 31) >> 5), "2" (addr), "b" (addr));
-	return res;
+	return (size > res) ? res : size;
 }
 
 /**
