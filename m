Return-Path: <linux-kernel-owner+willy=40w.ods.org-S966370AbWKNVWd@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S966370AbWKNVWd (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 14 Nov 2006 16:22:33 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S966368AbWKNVWc
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 14 Nov 2006 16:22:32 -0500
Received: from e33.co.us.ibm.com ([32.97.110.151]:20918 "EHLO
	e33.co.us.ibm.com") by vger.kernel.org with ESMTP id S966044AbWKNVWb
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 14 Nov 2006 16:22:31 -0500
Message-ID: <455A3392.6040501@linux.vnet.ibm.com>
Date: Tue, 14 Nov 2006 13:22:26 -0800
From: suzuki <suzuki@linux.vnet.ibm.com>
User-Agent: Mozilla Thunderbird 1.0 (X11/20041206)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Arnd Bergmann <arnd@arndb.de>
CC: akpm@osdl.org, davem@davemloft.net, linux-kernel@vger.kernel.org
Subject: Re: + fix-compat-space-msg-size-limit-for-msgsnd-msgrcv.patch added
 to -mm tree
References: <200611132358.kADNwF0V012270@shell0.pdx.osdl.net>	<200611140138.19111.arnd@arndb.de> <45591BD1.9070600@linux.vnet.ibm.com> <200611141049.36145.arnd@arndb.de>
In-Reply-To: <200611141049.36145.arnd@arndb.de>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Hello Arnd,
Arnd Bergmann wrote:
> On Tuesday 14 November 2006 02:28, suzuki wrote:
> 
>>I left it as such, inorder to avoid the future changes that may come in 
>>the struct msgbuf -if at all-, which would make us to pass every single 
>>field as a parameter to do_msgrcv/do_msgsnd.
> 
> 
> struct msgbuf is part of the kernel ABI and will never change, so that's
> no problem at all.
Ok.

Does the following change look fine ?

do_msgsnd() - Accepting the mtype and user space ptr to the mtext. i.e.,

long do_msgsnd(int msqid, long mtype, void __user *mtext,
		size_t msgsz, int msgflg);
and,

do_msgrcv() - accepting the kernel space data ptr to pmtype and user 
space ptr to mtext. The caller has to copy the *pmtype back to the user 
space.

i.e.,

long do_msgrcv(int msqid, long *pmtype, void __user *mtext,
                        size_t msgsz, long msgtyp, int msgflg);

or

Can we use the kernel space "struct msgbuf" instead of the mtype being 
passed explicitly.


Thanks,

Suzuki
> 
> 	Arnd <><

