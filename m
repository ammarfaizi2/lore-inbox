Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964959AbWDDCOt@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964959AbWDDCOt (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 3 Apr 2006 22:14:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964957AbWDDCOt
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 3 Apr 2006 22:14:49 -0400
Received: from x35.xmailserver.org ([69.30.125.51]:2477 "EHLO
	x35.xmailserver.org") by vger.kernel.org with ESMTP id S964959AbWDDCOs
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 3 Apr 2006 22:14:48 -0400
X-AuthUser: davidel@xmailserver.org
Date: Mon, 3 Apr 2006 19:14:46 -0700 (PDT)
From: Davide Libenzi <davidel@xmailserver.org>
X-X-Sender: davide@alien.or.mcafeemobile.com
To: Michael Kerrisk <mtk-manpages@gmx.net>
cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       michael.kerrisk@gmx.net
Subject: Re: POLLRDHUP inconsistency between poll() and epoll
In-Reply-To: <20134.1144115394@www102.gmx.net>
Message-ID: <Pine.LNX.4.64.0604031911370.30048@alien.or.mcafeemobile.com>
References: <Pine.LNX.4.64.0603261624110.15079@alien.or.mcafeemobile.com>
 <20134.1144115394@www102.gmx.net>
X-GPG-FINGRPRINT: CFAE 5BEE FD36 F65E E640  56FE 0974 BF23 270F 474E
X-GPG-PUBLIC_KEY: http://www.xmailserver.org/davidel.asc
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII; format=flowed
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 4 Apr 2006, Michael Kerrisk wrote:

> Davide,
>
> While playing about with the new POLLRDHUP flag, I've noticed
> an inconsistency, which may or may not be intentional...
>
> When a POLLRDHUP condition occurs, epoll_wait() tells us about
> the condition, regardless of whether or not we specified
> (E)POLLRDHUPP in the 'events' flag given to epoll_ctl()
> EPOLL_CTL_ADD.  In this respect, POLLRDHUP is treated just like
> POLLHUP and POLLERR.  This seems perfectly reasonable.
>
> By contrast, poll() will only tell us that POLLRDHUP occurred
> if we specified POLLRDHUP in the file descriptor 'events' mask
> given to the poll() call.  In other words, poll() treats
> POLLRDHUP differently from POLLHUP and POLLERR.  This seems
> a little strange.
>
> Is this difference really intended?  If it is, what is the
> reason for the difference?

No. It is definitely better to keep behaviour consistent with poll/select. 
I'll submit a patch ASAP. Thank you spotting this out!



- Davide


