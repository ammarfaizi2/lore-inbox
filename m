Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S274096AbRISQAA>; Wed, 19 Sep 2001 12:00:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S274072AbRISP7k>; Wed, 19 Sep 2001 11:59:40 -0400
Received: from erasmus.off.net ([64.39.30.25]:49156 "HELO erasmus.off.net")
	by vger.kernel.org with SMTP id <S274033AbRISP7c>;
	Wed, 19 Sep 2001 11:59:32 -0400
Date: Wed, 19 Sep 2001 11:59:56 -0400
From: Zach Brown <zab@zabbo.net>
To: Dan Kegel <dank@kegel.com>
Cc: "Christopher K. St. John" <cks@distributopia.com>,
        linux-kernel@vger.kernel.org, davidel@xmailserver.org
Subject: Re: [PATCH] /dev/epoll update ...
Message-ID: <20010919115956.E21777@erasmus.off.net>
In-Reply-To: <3BA80108.C830D602@kegel.com> <3BA84367.239FA0B4@distributopia.com> <3BA8BBC9.EA1D0636@kegel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2i
In-Reply-To: <3BA8BBC9.EA1D0636@kegel.com>; from dank@kegel.com on Wed, Sep 19, 2001 at 08:37:45AM -0700
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> Stevens [UNPV1, in chapter on nonblocking accept] suggests that readiness
> notifications from the OS should only be considered hints, and that user
> programs should behave properly even if the OS feeds it false readiness
> events.  

[ ... ]

> That said, the principle of least suprise would suggest that /dev/epoll should
> indeed return an accurate initial status.  There are a lot of programmers who
> don't agree with Stevens on this issue, and who write code that breaks if you
> feed it incorrect readiness events.

They're living a lie :)  A readiness event does not guarantee future
operations, it provides a hint of the status of things at the time the
event was generated.  Networking events can happen that change the status
of sockets from when readiness events come in and when the app tries to
react to them..

	- kernel gets ack, freeing tx queue space
	- the kernel wakes up the task with some POLL_OUT event
	- a packet comes in from the wire that resets the socket
	- the app sees poll_out and tries to write, and is surprised

there are many more situations like this.  readiness is _always_ only
a hint, and the app has to deal with this.

- z
