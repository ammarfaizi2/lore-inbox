Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932074AbWAABSU@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932074AbWAABSU (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 31 Dec 2005 20:18:20 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932153AbWAABST
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 31 Dec 2005 20:18:19 -0500
Received: from mail.aknet.ru ([82.179.72.26]:12305 "EHLO mail.aknet.ru")
	by vger.kernel.org with ESMTP id S932074AbWAABST (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 31 Dec 2005 20:18:19 -0500
Message-ID: <43B72DFC.4070707@aknet.ru>
Date: Sun, 01 Jan 2006 04:18:52 +0300
From: Stas Sergeev <stsp@aknet.ru>
User-Agent: Mozilla Thunderbird 1.0.2-6 (X11/20050513)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Adrian Bunk <bunk@stusta.de>
Cc: Steve Work <swork@aventail.com>, linux-kernel@vger.kernel.org,
       Andrew Morton <akpm@osdl.org>
Subject: Re: Multi-thread corefiles broken since April
References: <4397D844.8060903@aventail.com> <20051231142851.GH3811@stusta.de>
In-Reply-To: <20051231142851.GH3811@stusta.de>
Content-Type: multipart/mixed;
 boundary="------------010607080004080001010103"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------010607080004080001010103
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit

Hi.

Adrian Bunk wrote:
> On Wed, Dec 07, 2005 at 10:52:52PM -0800, Steve Work wrote:
>> Or do the corefile 
>> write routines need to know about this adjusted offset?
I think so, the attached patch seem to help.

Happy new year and happy hacking!


-----
teach dump_task_regs() about the -8 offset.

Signed-off-by: stsp@aknet.ru


--------------010607080004080001010103
Content-Type: text/x-patch;
 name="stkfix.diff"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="stkfix.diff"

--- linux/arch/i386/kernel/process.c.old	2005-08-07 21:58:25.000000000 +0400
+++ linux/arch/i386/kernel/process.c	2006-01-01 03:03:10.000000000 +0300
@@ -573,7 +573,9 @@
 	struct pt_regs ptregs;
 	
 	ptregs = *(struct pt_regs *)
-		((unsigned long)tsk->thread_info+THREAD_SIZE - sizeof(ptregs));
+		((unsigned long)tsk->thread_info +
+		/* see comments in copy_thread() about -8 */
+		THREAD_SIZE - sizeof(ptregs) - 8);
 	ptregs.xcs &= 0xffff;
 	ptregs.xds &= 0xffff;
 	ptregs.xes &= 0xffff;

--------------010607080004080001010103--
