Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262788AbSJRDMX>; Thu, 17 Oct 2002 23:12:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262793AbSJRDMX>; Thu, 17 Oct 2002 23:12:23 -0400
Received: from sccrmhc03.attbi.com ([204.127.202.63]:27072 "EHLO
	sccrmhc03.attbi.com") by vger.kernel.org with ESMTP
	id <S262788AbSJRDMW>; Thu, 17 Oct 2002 23:12:22 -0400
Message-ID: <3DAF8064.2080107@kegel.com>
Date: Thu, 17 Oct 2002 20:30:44 -0700
From: Dan Kegel <dank@kegel.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.0.1) Gecko/20020830
X-Accept-Language: de-de, en
MIME-Version: 1.0
To: "Charles 'Buck' Krasic" <krasic@acm.org>
CC: Davide Libenzi <davidel@xmailserver.org>,
       John Gardiner Myers <jgmyers@netscape.com>,
       Benjamin LaHaise <bcrl@redhat.com>,
       Shailabh Nagar <nagar@watson.ibm.com>,
       linux-kernel <linux-kernel@vger.kernel.org>,
       linux-aio <linux-aio@kvack.org>, Andrew Morton <akpm@digeo.com>,
       David Miller <davem@redhat.com>,
       Linus Torvalds <torvalds@transmeta.com>,
       Stephen Tweedie <sct@redhat.com>
Subject: Re: [PATCH] async poll for 2.5
References: <Pine.LNX.4.44.0210160618190.1548-100000@blue1.dev.mcafeelabs.com> <xu4fzv4ucll.fsf@brittany.cse.ogi.edu>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Charles 'Buck' Krasic wrote:
> On thinking about this a bit, I wonder if the evtmask isn't superflous
> in sys_epoll_addf? ... As you say, the normal usage will be to 
 > register for all events anyway.

I agree... but we might eventually have events that apps aren't
interested in.  No harm in letting app specify an interest mask once.

> Taking the idea further, I would prefer that ALL non-blocking sockets
> are automatically added to the epoll interest set if the application
> has already called epoll_create().

That would prevent apps from having more than one i/o readiness
notification event source.  This is a problem for modular
software, where you try to combine libraries in a multithreaded
program.

- Dan


