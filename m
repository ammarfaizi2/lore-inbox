Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964964AbWEVATh@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964964AbWEVATh (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 21 May 2006 20:19:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964965AbWEVATh
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 21 May 2006 20:19:37 -0400
Received: from watts.utsl.gen.nz ([202.78.240.73]:31121 "EHLO
	watts.utsl.gen.nz") by vger.kernel.org with ESMTP id S964964AbWEVATh
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 21 May 2006 20:19:37 -0400
Message-ID: <44710388.2050909@vilain.net>
Date: Mon, 22 May 2006 12:19:20 +1200
From: Sam Vilain <sam@vilain.net>
User-Agent: Mozilla Thunderbird 1.0.7 (X11/20051013)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: "Serge E. Hallyn" <serue@us.ibm.com>
Cc: linux-kernel@vger.kernel.org, dev@sw.ru, herbert@13thfloor.at,
       devel@openvz.org, ebiederm@xmission.com, xemul@sw.ru,
       Dave Hansen <haveblue@us.ibm.com>, Andrew Morton <akpm@osdl.org>,
       Cedric Le Goater <clg@fr.ibm.com>
Subject: Re: [PATCH 4/9] namespaces: utsname: switch to using uts namespaces
References: <20060518154700.GA28344@sergelap.austin.ibm.com> <20060518154936.GE28344@sergelap.austin.ibm.com>
In-Reply-To: <20060518154936.GE28344@sergelap.austin.ibm.com>
X-Enigmail-Version: 0.92.1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Serge E. Hallyn wrote:

>--- a/arch/alpha/kernel/osf_sys.c
>+++ b/arch/alpha/kernel/osf_sys.c
>@@ -402,15 +402,15 @@ osf_utsname(char __user *name)
> 
> 	down_read(&uts_sem);
> 	error = -EFAULT;
>-	if (copy_to_user(name + 0, system_utsname.sysname, 32))
>+	if (copy_to_user(name + 0, utsname()->sysname, 32))
> 		goto out;
>diff --git a/arch/i386/kernel/sys_i386.c b/arch/i386/kernel/sys_i386.c
>index 8fdb1fb..4af731d 100644
>--- a/arch/i386/kernel/sys_i386.c
>+++ b/arch/i386/kernel/sys_i386.c
>@@ -210,7 +210,7 @@ asmlinkage int sys_uname(struct old_utsn
> 	if (!name)
> 		return -EFAULT;
> 	down_read(&uts_sem);
>-	err=copy_to_user(name, &system_utsname, sizeof (*name));
>+	err=copy_to_user(name, utsname(), sizeof (*name));
> 	up_read(&uts_sem);
> 	return err?-EFAULT:0;
> }
>  
>

The semaphore (uts_sem) should be moved in the uts_ns structure, no?

It's probably low impact enough to keep it as it is, though. Just a tad
untidy.

Sam.
