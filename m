Return-Path: <linux-kernel-owner+willy=40w.ods.org-S935370AbWKZMiM@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S935370AbWKZMiM (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 26 Nov 2006 07:38:12 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S935371AbWKZMiM
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 26 Nov 2006 07:38:12 -0500
Received: from mx1.redhat.com ([66.187.233.31]:60310 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S935370AbWKZMiL (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 26 Nov 2006 07:38:11 -0500
Message-ID: <45698AA3.1020601@redhat.com>
Date: Sun, 26 Nov 2006 20:37:55 +0800
From: Eugene Teo <eteo@redhat.com>
Organization: Red Hat Asia Pacific
User-Agent: Thunderbird 1.5.0.8 (X11/20061107)
MIME-Version: 1.0
To: Al Viro <viro@ftp.linux.org.uk>
CC: lksctp-developers@lists.sourceforge.net, linux-kernel@vger.kernel.org
Subject: Re: [2.6 patch] net/sctp/socket.c: add missing sctp_spin_unlock_irqrestore
References: <456965D5.1000302@redhat.com> <20061126101254.GW3078@ftp.linux.org.uk>
In-Reply-To: <20061126101254.GW3078@ftp.linux.org.uk>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Al Viro wrote:
> On Sun, Nov 26, 2006 at 06:00:53PM +0800, Eugene Teo wrote:
>> This patch adds a missing sctp_spin_unlock_irqrestore when returning
>> from "if(space_left<addrlen)" condition.
>>                 if (copy_to_user(*to, &temp, addrlen)) {
>> -                       sctp_spin_unlock_irqrestore(&sctp_local_addr_lock,
>> -                                                   flags);
>> -                       return -EFAULT;
>> +                       err = -EFAULT;
>> +                       goto unlock;
> 
>> +       sctp_spin_unlock_irqrestore(&sctp_local_addr_lock, flags);
>> +       return err;
>>  }
> 
> You do realize that it's obviously still badly broken, don't you?
> copy_to_user() under a spinlock is a recipe for deadlock, especially
> if you've got interrupts disabled...

Realized. Back to drawing board.

Eugene
-- 
1024D/58DF8823 print 47B9 90F6 AE4A 9C51 37E0  D6E1 EA84 C6A2 58DF 8823
main(i) { putchar(182623909 >> (i-1) * 5&31|!!(i<7)<<6) && main(++i); }
