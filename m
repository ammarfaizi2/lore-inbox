Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S264674AbSJOS4I>; Tue, 15 Oct 2002 14:56:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S264677AbSJOS4I>; Tue, 15 Oct 2002 14:56:08 -0400
Received: from to-velocet.redhat.com ([216.138.202.10]:37614 "EHLO
	touchme.toronto.redhat.com") by vger.kernel.org with ESMTP
	id <S264674AbSJOS4F>; Tue, 15 Oct 2002 14:56:05 -0400
Date: Tue, 15 Oct 2002 15:02:01 -0400
From: Benjamin LaHaise <bcrl@redhat.com>
To: Davide Libenzi <davidel@xmailserver.org>
Cc: Shailabh Nagar <nagar@watson.ibm.com>,
       linux-kernel <linux-kernel@vger.kernel.org>,
       linux-aio <linux-aio@kvack.org>, Andrew Morton <akpm@digeo.com>,
       David Miller <davem@redhat.com>,
       Linus Torvalds <torvalds@transmeta.com>,
       Stephen Tweedie <sct@redhat.com>
Subject: Re: [PATCH] async poll for 2.5
Message-ID: <20021015150201.K14596@redhat.com>
References: <3DAC5C11.4060507@watson.ibm.com> <Pine.LNX.4.44.0210151156420.1554-100000@blue1.dev.mcafeelabs.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <Pine.LNX.4.44.0210151156420.1554-100000@blue1.dev.mcafeelabs.com>; from davidel@xmailserver.org on Tue, Oct 15, 2002 at 12:00:30PM -0700
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Oct 15, 2002 at 12:00:30PM -0700, Davide Libenzi wrote:
> Something like this might work :
> 
> int sys_epoll_create(int maxfds);
> void sys_epoll_close(int epd);
> int sys_epoll_wait(int epd, struct pollfd **pevts, int timeout);
> 
> where sys_epoll_wait() return the number of events available, 0 for
> timeout, -1 for error.

There's no reason to make epoll_wait a new syscall -- poll events can 
easily be returned via the aio_complete mechanism (with the existing 
aio_poll experiment as a possible means for doing so).

		-ben
