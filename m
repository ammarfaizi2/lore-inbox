Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262315AbRERNjn>; Fri, 18 May 2001 09:39:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262316AbRERNjd>; Fri, 18 May 2001 09:39:33 -0400
Received: from tomts7.bellnexxia.net ([209.226.175.40]:58019 "EHLO
	tomts7-srv.bellnexxia.net") by vger.kernel.org with ESMTP
	id <S262315AbRERNjY>; Fri, 18 May 2001 09:39:24 -0400
To: linux-kernel@vger.kernel.org
Subject: APIC, AMD-K6/2 -mcpu=586...
From: Bill Pringlemeir <bpringle@sympatico.ca>
Date: 18 May 2001 09:38:01 -0400
Message-ID: <m2u22ibww6.fsf@sympatico.ca>
User-Agent: Gnus/5.0803 (Gnus v5.8.3) Emacs/20.4
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Hello,

I have the 2.4.4 distribution from kernel.org. 

 "http://www.kernel.org/pub/linux/kernel/v2.4/"

I have a Mandrake system and selected the AMD processors and APIC
option.  The egcs-2.91.66 compiler with -mcpu=586.  It appears that
the structure alignment of the floating point registers was not
correct under this configuration.  This code was being compiled and
a linker error produced.

	if (offsetof(struct task_struct, thread.i387.fxsave) & 15) {
/*  printk("WJP: value is %x.\n", 
       offsetof(struct task_struct, thread.i387.fxsave) & 15); */
/*  	  while(1); */
		extern void __buggy_fxsr_alignment(void);
		__buggy_fxsr_alignment();
	}

The alignment was to 8 bytes instead of 16.  I added some padding to
the thread structure to produce an alignment of 16 and the code
compiled and seemed to work fine; I used it for a few days.

[in processor.h]
/* floating point info */
/*          unsigned char wjpDummy[8]; */
	union i387_union	i387;


I did not see any mention of this in the archives [but the volume of
mailings is large... which I may be contributing to].  I recompiled
without the padding and APIC support and everything seems to be fine,
but _VERY_ slow.  Is this change ok locally?  Has it been addressed 
in a patch?

regards,
Bill Pringlemeir.




