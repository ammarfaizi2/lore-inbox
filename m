Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S266548AbSKGOKq>; Thu, 7 Nov 2002 09:10:46 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S266559AbSKGOKq>; Thu, 7 Nov 2002 09:10:46 -0500
Received: from out002pub.verizon.net ([206.46.170.141]:46847 "EHLO
	out002.verizon.net") by vger.kernel.org with ESMTP
	id <S266548AbSKGOKp>; Thu, 7 Nov 2002 09:10:45 -0500
Date: Thu, 07 Nov 2002 09:16:50 -0500
From: Akira Tsukamoto <at541@columbia.edu>
To: Akira Tsukamoto <at541@columbia.edu>
Subject: Re: [PATCH] 2.5.46 add original copy_ro/from_user for i386 and support PenPro PenII
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <20021105090237.511A.AT541@columbia.edu>
References: <20021105090237.511A.AT541@columbia.edu>
Message-Id: <20021107091529.5742.AT541@columbia.edu>
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-Mailer: Becky! ver. 2.05.06
X-Authentication-Info: Submitted using SMTP AUTH LOGIN at out002.verizon.net from [138.89.33.207] at Thu, 7 Nov 2002 08:17:19 -0600
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 05 Nov 2002 09:36:48 -0500
Akira Tsukamoto <at541@columbia.edu> mentioned:
> 
> This is revised version from my previous patch, adding original copy_user.
> 
> In addition, I changed one line in Kconfig, remove M585MMX and add M686
> because I run new copy-user on my PentiumMMX but had no improvement,
> however PenII/PenPro likely to have improvement from new copy_user function.

I gathered benchmark results for PentiumMMX. 
They confirm that my patch improves the speed.

I run the Taka's socket benchmark program on PentiumMMX with CONFIG-M586MMX.
http://www.suna-asobi.com/~akira-t/linux/cleanup-copy-user-1/netio586mmx.c

Without my patch on 2.5.46:

(off:0, size:0x100000) 
send/recv: copied 5.0 Mbytes in 0.381 seconds at 13.1 Mbytes/sec
(off:1, size:0x100000) 
send/recv: copied 5.0 Mbytes in 0.488 seconds at 10.2 Mbytes/sec
(off:2, size:0x100000) 
send/recv: copied 5.0 Mbytes in 0.493 seconds at 10.1 Mbytes/sec
(off:3, size:0x100000) 
send/recv: copied 5.0 Mbytes in 0.489 seconds at 10.2 Mbytes/sec
(off:4, size:0x100000) 
send/recv: copied 5.0 Mbytes in 0.381 seconds at 13.1 Mbytes/sec
(Entire log is here, 
http://www.suna-asobi.com/~akira-t/linux/cleanup-copy-user-1/586MMX-PenMMX-no-patch.log)

With my patch on 2.5.46:

(off:0, size:0x100000) 
send/recv: copied 5.0 Mbytes in 0.380 seconds at 13.2 Mbytes/sec
(off:1, size:0x100000) 
send/recv: copied 5.0 Mbytes in 0.385 seconds at 13.0 Mbytes/sec
(off:2, size:0x100000) 
send/recv: copied 5.0 Mbytes in 0.385 seconds at 13.0 Mbytes/sec
(off:3, size:0x100000) 
send/recv: copied 5.0 Mbytes in 0.384 seconds at 13.0 Mbytes/sec
(off:4, size:0x100000) 
send/recv: copied 5.0 Mbytes in 0.381 seconds at 13.1 Mbytes/sec
(Entire log is here, 
http://www.suna-asobi.com/~akira-t/linux/cleanup-copy-user-1/586MMX-PenMMX-with-patch.log)

I appreciate if somebody could try on 386 or 486.
I don't have them right now.

Cheers,

Akira 



