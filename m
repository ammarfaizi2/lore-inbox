Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261738AbVDCNs5@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261738AbVDCNs5 (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 3 Apr 2005 09:48:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261739AbVDCNs5
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 3 Apr 2005 09:48:57 -0400
Received: from wproxy.gmail.com ([64.233.184.205]:26039 "EHLO wproxy.gmail.com")
	by vger.kernel.org with ESMTP id S261738AbVDCNsx (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 3 Apr 2005 09:48:53 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:user-agent:x-accept-language:mime-version:to:cc:subject:references:in-reply-to:content-type:content-transfer-encoding:from;
        b=JE9VWnDD/UuvUN2WHbm1hMbjhbAz3LXssU5+hUecXkt/vZhUqxwVYxqc7f+KIu2geYtqLVcr+y9sjG9CwwCyFGnas7lEJkRXXVjBuYBAcRKaJypIcD893Z/nNz+OGNpnJ6oWzDJsqrOR9krjXR6i7LxGyPs3NJIjwlwzYrNmsgs=
Message-ID: <424FF442.1060006@gmail.com>
Date: Sun, 03 Apr 2005 15:48:50 +0200
User-Agent: Mozilla Thunderbird 1.0.2 (X11/20050324)
X-Accept-Language: de-DE, de, en-us, en
MIME-Version: 1.0
To: Alexander Nyberg <alexn@dsv.su.se>
CC: linux-kernel@vger.kernel.org
Subject: Re: 2.6.12-rc1-bk does not boot x86_64
References: <424FE590.5060507@gmail.com> <1112533321.2369.1.camel@localhost.localdomain>
In-Reply-To: <1112533321.2369.1.camel@localhost.localdomain>
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: 7bit
From: Michael Thonke <iogl64nx@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Thanks Alexander this sort this out.
No system boots w/o problems :-)

Alexander Nyberg wrote:

>>I tried the recent 2.6.12-rc1-bk5 snapshot from kernel.org.
>>When I want to boot my x86_64 system only a green line appears on screen.
>>The config is the same as in 2.6.12-rc1-bk4 which works flawlessly on my
>>system.
>>
>>I only saw the message that CPU0 and CPU1 where initialized. And then
>>there was
>>Brinnging up CPUs and it stopped.
>>
>>Its an Intel Pentium4 640 with (EMT64,HT,EIST,CIE enabled).
>>The graphic card is an Nvidia 6600GT PCIe device.
>>    
>>
>
>I had the same nasty surprise this morning, this will probably help:
>
>
>Well, this is a brown paper bag for someone.  The new protocol
>registration locking uses a rwlock to limit access to the protocol list.
>Unfortunately, the initialisation:
>
>static rwlock_t proto_list_lock;
>
>Only works to initialise the lock as unlocked on platforms whose unlock
>signal is all zeros.  On other platforms, they think it's already locked
>and hang forever.
>
>Signed-off-by: James Bottomley <James.Bottomley@SteelEye.com>
>
>
>===== net/core/sock.c 1.67 vs edited =====
>--- 1.67/net/core/sock.c	2005-03-26 17:04:35 -06:00
>+++ edited/net/core/sock.c	2005-04-02 13:37:20 -06:00
>@@ -1352,7 +1352,7 @@
> 
> EXPORT_SYMBOL(sk_common_release);
> 
>-static rwlock_t proto_list_lock;
>+static DEFINE_RWLOCK(proto_list_lock);
> static LIST_HEAD(proto_list);
> 
> int proto_register(struct proto *prot, int alloc_slab)
>
>
>-
>
>
>
>  
>

