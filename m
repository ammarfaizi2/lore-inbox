Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262826AbTCKEVW>; Mon, 10 Mar 2003 23:21:22 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262828AbTCKEVW>; Mon, 10 Mar 2003 23:21:22 -0500
Received: from citi.umich.edu ([141.211.92.141]:61816 "HELO citi.umich.edu")
	by vger.kernel.org with SMTP id <S262826AbTCKEVV>;
	Mon, 10 Mar 2003 23:21:21 -0500
Date: Mon, 10 Mar 2003 23:32:02 -0500
From: Niels Provos <provos@citi.umich.edu>
To: Davide Libenzi <davidel@xmailserver.org>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Hanna Linder <hannal@us.ibm.com>, Janet Morgan <janetmor@us.ibm.com>,
       Marius Aamodt Eriksen <marius@citi.umich.edu>,
       Shailabh Nagar <nagar@watson.ibm.com>
Subject: Re: [patch, rfc] lt-epoll ( level triggered epoll ) ...
Message-ID: <20030311043202.GK2225@citi.citi.umich.edu>
References: <Pine.LNX.4.50.0303101139520.1922-100000@blue1.dev.mcafeelabs.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.50.0303101139520.1922-100000@blue1.dev.mcafeelabs.com>
User-Agent: Mutt/1.3.27i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Mar 10, 2003 at 12:15:25PM -0800, Davide Libenzi wrote:
> The LT epoll is by all means the fastest poll available and can be used
> wherever poll can be used. To test it I also ported thttpd to LT
> epoll and, so far, it didn't puke on my face. Niels and Marius also wrote
> a nice event library :
[...]
> that uses LT epoll, as long as poll and select. The usage pattern of an LT
I compared the performance of LT epoll using libevent against other
event mechanisms: select, poll and kqueue.

You can find the results at

  http://www.monkey.org/~provos/libevent/

As kqueue and epoll are not available on the same operating system,
you have to take the results qualitatively.  However, kqueue and epoll
are in the same ballpark.  Both outperform select and poll.

It seems that option 3) which implements both "edge" and "level"
triggered behavior is the best solution.  This is similar to kqueue
which supports both triggering modes.

Niels.
