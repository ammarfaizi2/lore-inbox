Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S316994AbSFFQLk>; Thu, 6 Jun 2002 12:11:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S316999AbSFFQLk>; Thu, 6 Jun 2002 12:11:40 -0400
Received: from mail.epost.de ([64.39.38.76]:10738 "EHLO mail.epost.de")
	by vger.kernel.org with ESMTP id <S316994AbSFFQLj>;
	Thu, 6 Jun 2002 12:11:39 -0400
Message-ID: <3CFF8904.9010703@dlr.de>
Date: Thu, 06 Jun 2002 18:08:36 +0200
From: Martin Wirth <martin.wirth@dlr.de>
User-Agent: Mozilla/5.0 (Windows; U; Windows NT 5.0; de-DE; rv:0.9.4) Gecko/20011128 Netscape6/6.2.1
X-Accept-Language: de-DE
MIME-Version: 1.0
To: Rusty Russell <rusty@rustcorp.com.au>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] Futex Asynchronous Interface
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Rusty,

>if (this->page == page && this->offset == offset) {
> 			list_del_init(i);
> 			tell_waiter(this);
>+			unpin_page(this->page);
> 			num_woken++;
> 			if (num_woken >= num) break;
> 		}
> 	}
> 	spin_unlock(&futex_lock);
>+	unpin_page(page);
> 	return num_woken;

If I understand right you shouldn't unpin the page if you are not sure that
all waiters for a specific (page,offset)-combination are woken up and deleted
from the waitqueue. Otherwise a second call to futex_wake may look on the wrong
hash_queue or wake the wrong waiters.

In general, I think fast userspace synchronization primitives and asynchronous 
notification are different enough to keep them logically more separated. 
Your double use of the hashed wait queues and sys_call make the code difficult
to grasp and thus open for subtle error.

Martin

Martin 


