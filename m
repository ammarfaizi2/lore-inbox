Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S270827AbRHXBx0>; Thu, 23 Aug 2001 21:53:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S270841AbRHXBxR>; Thu, 23 Aug 2001 21:53:17 -0400
Received: from freya.yggdrasil.com ([209.249.10.20]:9453 "EHLO
	ns1.yggdrasil.com") by vger.kernel.org with ESMTP
	id <S270827AbRHXBxD>; Thu, 23 Aug 2001 21:53:03 -0400
From: "Adam J. Richter" <adam@yggdrasil.com>
Date: Thu, 23 Aug 2001 18:53:16 -0700
Message-Id: <200108240153.SAA12447@adam.yggdrasil.com>
To: alan@lxorguk.ukuu.org.uk
Subject: PATCH: remove fusion_init from linux-2.4.9/drivers/block/genhd.c
Cc: linux-kernel@vger.kernel.org, Steve.Ralston@lsil.com
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Alan,

	Could you please remove the fusion_init() call from
drivers/block/genhd.c in your -ac tree and forward the change to Linus
at your convenience?  (If you'd rather I follow some other procedure, please
let me know.)  I have appended the following to this message:

	1. Email from Steve Ralston tepidly approving integration of
	   the change by you and Linus.

	2. My original email to Steve Ralson (fusion driver maintainer)
	   justifying the change.

	3. A (fake) patch to remove fusion_init from
	   linux-2.4.9/drivers/block/genhd.c for clarity and convenience.

Adam J. Richter     __     ______________   4880 Stevens Creek Blvd, Suite 104
adam@yggdrasil.com     \ /                  San Jose, California 95129-1034
+1 408 261-6630         | g g d r a s i l   United States of America
fax +1 408 261-6631      "Free Software For The Rest Of Us."


>From sralston@lsil.com Wed Aug 22 11:25:23 2001

>Hi Adam,

>Offhand, your removal of the fusion_init() call from drivers/block/genhd.c
>seems Ok.  I'm trying to remember the history/sequence on how and why
>it got put in there in the first place:-)  It may be that an early version
>of the
>fusion driver didn't have the code which automatically calls fusion_init()
>if
>mpt_register is called first, and a no longer needed call of fusion_init
>from
>genhd.c never got cleaned up.

>I want to check a few more things on my end, but unless you hear otherwise,
>it looks Ok to go ahead and remove any external calls to fusion_init
>(other than via module_init).  You can relay the request to Alan and/or
>Linus.

>Regards,
>-SteveR

>PS: I may be blind, otherwise I sure didn't see a patch included in your
>posting:-)

>> -----Original Message-----
>> From:	Adam J. Richter [SMTP:adam@yggdrasil.com]
>> Sent:	Monday, August 20, 2001 6:54 PM
>> To:	Steve.Ralston@lsil.com
>> Cc:	linux-kernel@vger.kernel.org
>> Subject:	PATCH: linux-2.4.9/drivers/block/genhd.c eliminating
>> unnecessary fusion_init call
>> 
>> 	linux-2.4.9/drivers/block/genhd.c calls fusion_init, but
>> fusion_init is again called unconditionally due to the
>> module_init() call at the end of drivers/message/fusion/mptbase.c.
>> The only effect of the second call is to possibly generate a printk,
>> since the fusion driver has code to protect against this case.  However,
>> the fusion driver also has code that automatically calls fusion_init
>> if mpt_register is called before fusion_init, so there does not
>> seem to be a need to an early call in drivers/block/genhd.c.
>> 
>> 	So, the following patch removes the unnecessary call
>> from genhd.c.  I believe no changes to the fusion driver or
>> the initialization order in linux/Makefile are necessary.
>> 
>> 	By the way, this is a fake patch.  The kernel that I am
>> actually using has no drivers/block/genhd.c anymore, since I
>> have eliminating all of its calls.
>> 
>> 	Steven: could you please comment on this patch?  If you
>> see no problems with it, I would like to ask Alan and Linus to
>> integrate it into their kernels (or you can do so, or we can
>> follow whatever procedure you prefer).  Please let me know.
>> Thanks in advance.
>> 
>> -- 
>> Adam J. Richter     __     ______________   4880 Stevens Creek Blvd, Suite
>> 104
>> adam@yggdrasil.com     \ /                  San Jose, California
>> 95129-1034
>> +1 408 261-6630         | g g d r a s i l   United States of America
>> fax +1 408 261-6631      "Free Software For The Rest Of Us."

--- linux-2.4.9/drivers/block/genhd.c	Thu Jul 19 17:48:15 2001
+++ linux/drivers/block/genhd.c	Thu Aug 23 18:42:49 2001
@@ -21,9 +21,6 @@
 #ifdef CONFIG_BLK_DEV_DAC960
 extern void DAC960_Initialize(void);
 #endif
-#ifdef CONFIG_FUSION_BOOT
-extern int fusion_init(void);
-#endif
 extern int net_dev_init(void);
 extern void console_map_init(void);
 extern int soc_probe(void);
@@ -40,9 +37,6 @@
 #endif
 #ifdef CONFIG_BLK_DEV_DAC960
 	DAC960_Initialize();
-#endif
-#ifdef CONFIG_FUSION_BOOT
-	fusion_init();
 #endif
 #ifdef CONFIG_FC4_SOC
 	/* This has to be done before scsi_dev_init */
