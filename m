Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267318AbUHRFKJ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267318AbUHRFKJ (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 18 Aug 2004 01:10:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268591AbUHRFKJ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 18 Aug 2004 01:10:09 -0400
Received: from everest.2mbit.com ([24.123.221.2]:18613 "EHLO mail.sosdg.org")
	by vger.kernel.org with ESMTP id S267318AbUHRFJw (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 18 Aug 2004 01:09:52 -0400
Message-ID: <4122E477.4010601@greatcn.org>
Date: Wed, 18 Aug 2004 13:09:11 +0800
From: Coywolf Qi Hunt <coywolf@greatcn.org>
User-Agent: Mozilla Thunderbird 0.7.2 (Windows/20040707)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Sam Ravnborg <sam@ravnborg.org>
CC: akpm@osdl.org, kai@tp1.ruhr-uni-bochum.de, linux-kernel@vger.kernel.org
References: <411F3A48.2030201@greatcn.org> <20040815174915.GA7265@mars.ravnborg.org> <412016AA.6030006@greatcn.org> <20040816205230.GA21047@mars.ravnborg.org> <41218562.9040204@greatcn.org> <20040817211258.GA20246@mars.ravnborg.org>
In-Reply-To: <20040817211258.GA20246@mars.ravnborg.org>
X-Scan-Signature: a726be06c385139e599d1e3213de9f7b
X-SA-Exim-Connect-IP: 218.24.164.17
X-SA-Exim-Mail-From: coywolf@greatcn.org
Subject: Re: [patch] remove obsolete HEAD in kbuild
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Report: * -4.9 BAYES_00 BODY: Bayesian spam probability is 0 to 1%
	*      [score: 0.0000]
	*  3.0 RCVD_IN_AHBL_CNKR RBL: AHBL: sender is listed in the AHBL China/Korea blocks
	*      [218.24.164.17 listed in cnkrbl.ahbl.org]
X-SA-Exim-Version: 4.1 (built Tue, 17 Aug 2004 17:11:03 -0500)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Sam Ravnborg wrote:

>On Tue, Aug 17, 2004 at 12:11:14PM +0800, Coywolf Qi Hunt wrote:
>  
>
>>No, we needn't. Some archs do not have head-y. They use core-y for head.o .
>>    
>>

Sorry for my wrongness.

I felt _quit_ sure when I was saying that stupidity in the morning when 
I just woke up.
I was hesitating to look into it, but I didn't. It seemed so real to me 
then.
Maybe I dreamed I found that. It's possible for one who thinks of kernel 
issuses day to day.

What a shame. I nearly break kbuild on cris. :-(

>Looked and could not find it...
>Adding head.o to extra-y does not get it compiled in.
>To compile it in it needs to be listed in obj-y, and do not
>confuse the three different head.S files.
>
>	Sam
>

Makefile: remove obsolete HEAD
arch/cris/Makefile: replace HEAD with assignment to head-y


Signed-off-by: Coywolf Qi Hunt <coywolf@greatcn.org>

 Makefile           |    1 -
 arch/cris/Makefile |    2 +-
 2 files changed, 1 insertion(+), 2 deletions(-)
diff -Nrup linux-2.6.8/Makefile linux-2.6.8-cy/Makefile
--- linux-2.6.8/Makefile	2004-08-15 05:46:21.000000000 -0400
+++ linux-2.6.8-cy/Makefile	2004-08-15 05:46:41.000000000 -0400
@@ -506,7 +506,6 @@ libs-y		:= $(libs-y1) $(libs-y2)
 #       normal descending-into-subdirs phase, since at that time
 #       we cannot yet know if we will need to relink vmlinux.
 #	So we descend into init/ inside the rule for vmlinux again.
-head-y += $(HEAD)
 vmlinux-objs := $(head-y) $(init-y) $(core-y) $(libs-y) $(drivers-y) $(net-y)
 
 quiet_cmd_vmlinux__ = LD      $@
diff -Nrup linux-2.6.8/arch/cris/Makefile linux-2.6.8-cy/arch/cris/Makefile
--- linux-2.6.8/arch/cris/Makefile	2004-08-15 20:58:18.000000000 -0400
+++ linux-2.6.8-cy/arch/cris/Makefile	2004-08-17 22:48:39.671201824 -0400
@@ -39,7 +39,7 @@ CFLAGS := $(subst -fomit-frame-pointer,,
 CFLAGS += -fno-omit-frame-pointer
 endif
 
-HEAD := arch/$(ARCH)/$(SARCH)/kernel/head.o
+head-y := arch/$(ARCH)/$(SARCH)/kernel/head.o
 
 LIBGCC = $(shell $(CC) $(CFLAGS) -print-file-name=libgcc.a)


-- 
Coywolf Qi Hunt
Homepage http://greatcn.org/~coywolf/
Admin of http://GreatCN.org and http://LoveCN.org

