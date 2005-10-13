Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932364AbVJMTqJ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932364AbVJMTqJ (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 13 Oct 2005 15:46:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932392AbVJMTqI
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 13 Oct 2005 15:46:08 -0400
Received: from gateway-1237.mvista.com ([12.44.186.158]:15358 "EHLO
	hermes.mvista.com") by vger.kernel.org with ESMTP id S932364AbVJMTqG
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 13 Oct 2005 15:46:06 -0400
Message-ID: <434EB936.3070600@mvista.com>
Date: Thu, 13 Oct 2005 12:44:54 -0700
From: George Anzinger <george@mvista.com>
Reply-To: george@mvista.com
Organization: MontaVista Software
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.6) Gecko/20050323 Fedora/1.7.6-1.3.2
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Serge Goodenko <s_goodenko@mail.ru>
Cc: linux-kernel@vger.kernel.org,
       high-res-timers-discourse@lists.sourceforge.net
Subject: Re: [PATCH] UML + High-Res-Timers on 2.4.25 kernel
References: <E1EPxwT-0009q3-00.s_goodenko-mail-ru@f24.mail.ru>
In-Reply-To: <E1EPxwT-0009q3-00.s_goodenko-mail-ru@f24.mail.ru>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Serge Goodenko wrote:
> ~
>>>is there any solution to this problem?
>>>or HRT patch is not supposed to work under UML at all?
>>>
>>
>>You might do better on the HRT list (cc'ed).
>>
>>I don't know what UML needs.  I would have thought that jiffies would be defined...  especially for 
>>things like do_fork.  Which patch are you using?

HRT (in all its versions) requires the availability of a hardware timer to provide an interrupt at 
timer expiry.  I am not sure how this is done in UML but my guess is that the host kernel would need 
to have HRT running on it.  Then the UML kernel(s) would transform the HRT requests into the proper 
user call to the host.
> 
> 
> Well, as far as I understood recently HRT patch is not what I exactly need. It provides just API for using in user space applications and I need to use High-Resolution timer in kernel (particulary in TCP/IP stack)...
> therefore my problem now is to find suitable hi-res timer patch for use in 2.4 kernel...

There are several 2.4 HRT patches on the HRT site, see signature below.

Still, these patches do not provide kernel access to the high-res timers.  This has been done in one 
case, but the interface is not really defined nor stable (i.e. we may change it in the next 
release...).  Look for HIGH_RES_TIMERS in the ipmi driver in the 2.6 kernel tree to see how to go 
about this.

> and I would be pleased if you could recommend me something...
> 
> thanks,
> 
> Serge, MIPT,
> Russia
> 
> 
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
> 

-- 
George Anzinger   george@mvista.com
HRT (High-res-timers):  http://sourceforge.net/projects/high-res-timers/
