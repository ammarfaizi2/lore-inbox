Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261984AbULPSmx@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261984AbULPSmx (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 16 Dec 2004 13:42:53 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261980AbULPSmf
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 16 Dec 2004 13:42:35 -0500
Received: from prgy-npn1.prodigy.com ([207.115.54.37]:34688 "EHLO
	oddball.prodigy.com") by vger.kernel.org with ESMTP id S261977AbULPSmb
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 16 Dec 2004 13:42:31 -0500
Message-ID: <41C1D747.1040706@tmr.com>
Date: Thu, 16 Dec 2004 13:43:19 -0500
From: Bill Davidsen <davidsen@tmr.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.3) Gecko/20040913
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Phani Kandula <phani.lkml@gmail.com>
CC: linux-kernel@vger.kernel.org
Subject: Re: doubt about "switch" - default case in af_inet.c
References: <7d34f21904120905573ddb6d25@mail.gmail.com>
In-Reply-To: <7d34f21904120905573ddb6d25@mail.gmail.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Phani Kandula wrote:
> Hi all,
> 
> I'm a newbie to the Linux. I'm using 2.6.8 kernel. 
> In /usr/src/linux/net/ipv4/af_inet.c I came across this...
>  <code>
>      switch (sock->state) {
>      default:
>      //do something..
>          goto out;
>      case SS_CONNECTED:
>      //do something..
>          goto out;
>      case SS_CONNECTING:
>      //do something..
>          break;
>      case SS_UNCONNECTED:
>      //do something..
>          break;
>      }
>  </code>
> 
> Is there any advantage in having 'default' as the first case? 
> My understanding is that it will be useful only when 'default' is the
> most likely case (in general).
> 
> Even then, my doubt: How will compiler (say gcc) implement 'default'
> as the first value? Program is supposed to see all the cases and then
> decide 'default'. Is this correct?
> 
> So, is this the best way to do it? please clarify..

Just so. The compiler will check some or all of the cases first, and 
then take the default case. If you look at the code with and without 
optimization (use -S) you will see that it behaves the same way 
regardless of the placement of the default case. There is one exception, 
that is the one where control falls through from one case to another, 
and the default case is not last and lacks a break, such that the 
default winds up executing the code from the case(s) following.

Do I have to say that the code doing stuff like that is hard to read?

-- 
    -bill davidsen (davidsen@tmr.com)
"The secret to procrastination is to put things off until the
  last possible moment - but no longer"  -me
