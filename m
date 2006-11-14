Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1755358AbWKNB2v@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755358AbWKNB2v (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 13 Nov 2006 20:28:51 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751907AbWKNB2v
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 13 Nov 2006 20:28:51 -0500
Received: from e4.ny.us.ibm.com ([32.97.182.144]:49128 "EHLO e4.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id S1755358AbWKNB2u (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 13 Nov 2006 20:28:50 -0500
Message-ID: <45591BD1.9070600@linux.vnet.ibm.com>
Date: Mon, 13 Nov 2006 17:28:49 -0800
From: suzuki <suzuki@linux.vnet.ibm.com>
User-Agent: Mozilla Thunderbird 1.0 (X11/20041206)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Arnd Bergmann <arnd@arndb.de>
CC: akpm@osdl.org, davem@davemloft.net, linux-kernel@vger.kernel.org
Subject: Re: + fix-compat-space-msg-size-limit-for-msgsnd-msgrcv.patch added
 to -mm tree
References: <200611132358.kADNwF0V012270@shell0.pdx.osdl.net> <200611140138.19111.arnd@arndb.de>
In-Reply-To: <200611140138.19111.arnd@arndb.de>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Arnd Bergmann wrote:
> On Tuesday 14 November 2006 00:58, akpm@osdl.org wrote:
> 
> 
>>Subject: Fix compat space msg size limit for msgsnd/msgrcv
>>From: suzuki <suzuki@linux.vnet.ibm.com>
>>
>>Currently we allocate 64k space on the user stack and use it the msgbuf for
>>sys_{msgrcv,msgsnd} for compat and the results are later copied in user [by
>>copy_in_user].
>>
>>This patch introduces helper routines for sys_{msgrcv,msgsnd} which would
>>accept the pointer to msgbuf along with the msgp->mtext.  This avoids the
>>need to allocate the msgsize on the userspace (thus removing the size
>>limit) and the overhead of an extra copy_in_user().
>>
>>Signed-off-by: Suzuki K P <suzuki@in.ibm.com>
>>Cc: Arnd Bergmann <arnd@arndb.de>
>>Cc: "David S. Miller" <davem@davemloft.net>
>>Signed-off-by: Andrew Morton <akpm@osdl.org>
> 

> 
> This patch is definitely a big step in the right direction here, but why 
> not go all the way and pass msgp->mtype to do_msgsnd/do_msgrcv as kernel
> data instead of a user space pointer? This way you can get rid of the
> compat_alloc_userspace entirely and save avoid doing an extra 
> put_user/get_user pair in the compat_ function.
> 

I left it as such, inorder to avoid the future changes that may come in 
the struct msgbuf -if at all-, which would make us to pass every single 
field as a parameter to do_msgrcv/do_msgsnd.

thanks,

Suzuki
> 	Arnd <><

