Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S263401AbTCNR22>; Fri, 14 Mar 2003 12:28:28 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S263402AbTCNR21>; Fri, 14 Mar 2003 12:28:27 -0500
Received: from e32.co.us.ibm.com ([32.97.110.130]:29356 "EHLO
	e32.co.us.ibm.com") by vger.kernel.org with ESMTP
	id <S263401AbTCNR2Z>; Fri, 14 Mar 2003 12:28:25 -0500
Date: Fri, 14 Mar 2003 11:41:28 -0600
From: latten@austin.ibm.com
Message-Id: <200303141741.h2EHfSpm021569@faith.austin.ibm.com>
To: root@chaos.analogic.com
Subject: Re: eth0: Bus master arbitration failure
Cc: linux-kernel@vger.kernel.org
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


>On Thu, 13 Mar 2003 latten@austin.ibm.com wrote:
>
>> I was wondering if anyone knew if this had been resolved
>> or see this problem too. I am having the same problem. 
>> However, I am using 2.5.64 kernel and I have tried 
>> both an eepro100 and a 3com-tornado ethernet card.
>> 
>
>I think the problem is probably all those "printk()" calls
>within timing-sensitive code (really). A Bus master arbitration
>failure is supposed to result in a retry. It is not supposed to
>be fatal. For kicks, just comment out the printk() and see if
>the box starts to work. If that makes it work, an appropriate
>permanent fix would be to just keep track of the number of
>such failures just like the dropped-packet and collision count.
>
>If removing the printk() doesn't fix it, there may be a retained
>spin-lock on an error exit path.
>

I did go and take a look at that printk :-) and realized it was in
pcnet32.c and that it was my pcnet32 card complaining and not
my eepro100 or 3com card. Whew! Sorry about that mistake. 
I am going to try and install kdb and see if it will help 
locate where the lockup is occuring.

Thanks,
Joy
