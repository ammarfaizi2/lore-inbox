Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267406AbSLEToR>; Thu, 5 Dec 2002 14:44:17 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267407AbSLEToQ>; Thu, 5 Dec 2002 14:44:16 -0500
Received: from chaos.physics.uiowa.edu ([128.255.34.189]:43470 "EHLO
	chaos.physics.uiowa.edu") by vger.kernel.org with ESMTP
	id <S267406AbSLEToM>; Thu, 5 Dec 2002 14:44:12 -0500
Date: Thu, 5 Dec 2002 13:50:32 -0600 (CST)
From: Kai Germaschewski <kai@tp1.ruhr-uni-bochum.de>
X-X-Sender: kai@chaos.physics.uiowa.edu
To: Burton Windle <bwindle@fint.org>
cc: linux-kernel@vger.kernel.org
Subject: Re: 2.5.50-bk5: KALLSYMS shows call trace as all _stext
In-Reply-To: <Pine.LNX.4.43.0212051357230.10336-100000@morpheus>
Message-ID: <Pine.LNX.4.44.0212051349090.13520-100000@chaos.physics.uiowa.edu>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 5 Dec 2002, Burton Windle wrote:

> Starting in 2.5.50-bk5 (it works in bk4), oopses when CONFIG_KALLSYMS
> seems to mis-report all functions as _stext.
> 
> Call Trace:
>  [<c014cec9>] _stext+0x47ec9/0x17ab4e
> 
> However, as seen in the System.map,
> bwindle@razor:/giant/linux$ grep c014ce System.map
> c014ce50 T get_locks_status

Thanks, my bad.

Could you confirm that the appended patch fixes it?

--Kai


===== scripts/kallsyms.c 1.1 vs edited =====
--- 1.1/scripts/kallsyms.c	Wed Dec  4 13:16:58 2002
+++ edited/scripts/kallsyms.c	Thu Dec  5 13:47:38 2002
@@ -114,6 +114,7 @@
 
 	printf(".globl kallsyms_num_syms\n");
 	printf("\t.align 8\n");
+	printf("kallsyms_num_syms:\n");
 	printf("\t.long\t%d\n", valid);
 	printf("\n");
 

