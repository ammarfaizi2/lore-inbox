Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751179AbWJEHOy@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751179AbWJEHOy (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 5 Oct 2006 03:14:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751181AbWJEHOy
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 5 Oct 2006 03:14:54 -0400
Received: from ug-out-1314.google.com ([66.249.92.174]:12862 "EHLO
	ug-out-1314.google.com") by vger.kernel.org with ESMTP
	id S1751179AbWJEHOx (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 5 Oct 2006 03:14:53 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=googlemail.com;
        h=received:message-id:date:from:user-agent:mime-version:to:cc:subject:references:in-reply-to:content-type:content-transfer-encoding:sender;
        b=dRX+GNxeuW035+IzKB6NIIrej8XTL3QjtPupmnDNotukpOjQdHJiR5hOd9NE2hLfQd2UDM25QyxqWlW085YQklOy3w71e96FIvmHInIpQbhFFDC78WeNqd+1zUNxKL6ZMiDvuinUFpsAPItOZSFMaq4gT7q2v+tbMxpSmVcERdc=
Message-ID: <4524B0E9.8010005@web.de>
Date: Thu, 05 Oct 2006 09:14:49 +0200
From: Markus Wenke <M.Wenke@web.de>
User-Agent: Mozilla/5.0 (Windows; U; Windows NT 5.1; de-AT; rv:1.8.0.6) Gecko/20060729 SeaMonkey/1.0.4
MIME-Version: 1.0
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
CC: linux-kernel@vger.kernel.org
Subject: Re: to many sockets ?
References: <4523CD4E.10806@web.de> <1159979587.25772.82.camel@localhost.localdomain>
In-Reply-To: <1159979587.25772.82.camel@localhost.localdomain>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Alan Cox schrieb:
> Ar Mer, 2006-10-04 am 17:03 +0200, ysgrifennodd Markus Wenke:
>   
>> Hi,
>>
>> I wrote a program which handles incomming sockets asynchron.
>> It can handle up to 140000 connections simultaneously while every 
>> connection send some bytes in both directions continuously.
>>     
>
> Armwavingly 64K x 2 per socket worst case for non tcp windowed buffering
>
> 128K per socket x 140000 connections
>
> 8750MB of RAM
>
> plus other overhead
>
> Assuming you kept the socket buffer limit to 64K by setting it or
> disabling window scaling you'd want a about 10GB of RAM for the sockets,
> buffering and resources. With tcp windows you'd need more.
The default values of my system are:
SO_SNDBUF = 16384
SO_RCVBUF = 87380

> If your data rates are always low, or the link is low latency you could
> set the send/receive socket buffer for each connection via setsockopt
> down to say 8K and come out needing perhaps 1GB or so instead.
>
I tried the same scenario with SO_SNDBUF = SO_RCVBUF = 8k, so that the 
max memory is ca. 2G
and the oom-killer kills my application at the same time (at 140000 
connections).

I can not see in the messages that the system is out of memory,
there is also no swap space used

You can download my /var/log/messages at 
http://hemaho.mine.nu/~biber/messages

May you can give me a hint which line/value in the log shows me,
that the system is out of memory?


Thanks in advance

Markus Wenke

