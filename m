Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263818AbUHDK3M@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263818AbUHDK3M (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 4 Aug 2004 06:29:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263851AbUHDK3M
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 4 Aug 2004 06:29:12 -0400
Received: from tapuz.safe-mail.net ([212.68.149.115]:24293 "EHLO
	tapuz.safe-mail.net") by vger.kernel.org with ESMTP id S263818AbUHDK3F
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 4 Aug 2004 06:29:05 -0400
X-SMType: Regular
X-SMRef: N1-NFKCXPH7
Message-ID: <4110BA81.4030309@safe-mail.net>
Date: Wed, 04 Aug 2004 18:29:21 +0800
From: Liu Tao <liutao@safe-mail.net>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.6) Gecko/20040413 Debian/1.6-5
X-Accept-Language: en
MIME-Version: 1.0
To: arjanv@redhat.com
CC: lkml <linux-kernel@vger.kernel.org>
Subject: Re: [patch] Add a writer prior lock methord for rwlock
References: <4110A7AF.2060903@safe-mail.net> <1091610963.2792.13.camel@laptop.fenrus.com>
In-Reply-To: <1091610963.2792.13.camel@laptop.fenrus.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Arjan van de Ven wrote:

>On Wed, 2004-08-04 at 11:09, Liu Tao wrote:
>  
>
>>The patch adds the write_forcelock() methord, which has higher priority than
>>read_lock() and write_lock(). The original read_lock() and write_lock() 
>>is not
>>touched, and the unlock methord is still write_unlock();
>>The patch gives implemention on i386, for kernel 2.6.7.
>>    
>>
>
>can you please elaborate what kind of usage scenarios this would be
>useful ? It would be nice to know what this is for ;)
>  
>

write_forcelock() should be used to avoid readers starve writers, or for 
writers
to update shared data as far as possiable, since it prevents new readers 
acquire
the lock while it's waiting for existing readers release their locks. 
I'm not clear
who will need it now,  since it doesn't affect the original read_lock() 
and write_lock()
I tried it.

Regards
