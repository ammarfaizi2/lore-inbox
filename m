Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751073AbVKUVrh@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751073AbVKUVrh (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 21 Nov 2005 16:47:37 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751076AbVKUVrh
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 21 Nov 2005 16:47:37 -0500
Received: from zrtps0kp.nortelnetworks.com ([47.140.192.56]:56542 "EHLO
	zrtps0kp.nortelnetworks.com") by vger.kernel.org with ESMTP
	id S1751073AbVKUVrg (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 21 Nov 2005 16:47:36 -0500
Message-ID: <4382406D.1040508@nortel.com>
Date: Mon, 21 Nov 2005 15:47:25 -0600
From: "Christopher Friesen" <cfriesen@nortel.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.6) Gecko/20040115
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Alexey Kuznetsov <kuznet@ms2.inr.ac.ru>
CC: Herbert Xu <herbert@gondor.apana.org.au>, netdev@vger.kernel.org,
       linux-kernel@vger.kernel.org, davem@davemloft.net
Subject: Re: netlink nlmsg_pid supposed to be pid or tid?
References: <438220C3.4040602@nortel.com> <E1EeIcx-0006i3-00@gondolin.me.apana.org.au> <20051121213549.GA28187@ms2.inr.ac.ru>
In-Reply-To: <20051121213549.GA28187@ms2.inr.ac.ru>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
X-OriginalArrivalTime: 21 Nov 2005 21:47:26.0511 (UTC) FILETIME=[29BD23F0:01C5EEE5]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Alexey Kuznetsov wrote:
> Hello!
> 
> 
>>I tend to agree with you here that tgid makes more sense.
> 
> 
> I agree, apparently netlink_autobind was missed when sed'ing pid->tgid.
> Of course, it does not matter, but tgid is nicer choice from user's viewpoint.

I'm glad you agree, but I'm not sure what you mean by "it does not matter".

TIPC wants the user to fill in the pid to use in the nlmsghdr portion of 
a particular message.

When an NPTL child thread uses getpid() to specify the pid, it never 
receives a response to this request.  Running the same code on the 
parent works, and running the same code under Linuxthreads works.

Using gettid() works, but it also means that only the thread that issued 
the request can read the reply.

Chris
