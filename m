Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S274200AbRIXWJi>; Mon, 24 Sep 2001 18:09:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S274199AbRIXWJd>; Mon, 24 Sep 2001 18:09:33 -0400
Received: from pc-62-30-67-185-az.blueyonder.co.uk ([62.30.67.185]:26862 "EHLO
	kushida.jlokier.co.uk") by vger.kernel.org with ESMTP
	id <S274194AbRIXWJV>; Mon, 24 Sep 2001 18:09:21 -0400
Date: Mon, 24 Sep 2001 23:09:09 +0100
From: Jamie Lokier <lk@tantalophile.demon.co.uk>
To: Davide Libenzi <davidel@xmailserver.org>
Cc: "Eric W. Biederman" <ebiederm@xmission.com>, Dan Kegel <dank@kegel.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Gordon Oliver <gordo@pincoya.com>
Subject: Re: [PATCH] /dev/epoll update ...
Message-ID: <20010924230909.A10253@kushida.jlokier.co.uk>
In-Reply-To: <20010924225616.D9688@kushida.jlokier.co.uk> <XFMail.20010924150804.davidel@xmailserver.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <XFMail.20010924150804.davidel@xmailserver.org>; from davidel@xmailserver.org on Mon, Sep 24, 2001 at 03:08:04PM -0700
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Davide Libenzi wrote:
> > Well, memory move consists of 2 words: (a) file descriptor; (b) poll
> > state/edge flags.
> 
> 2-words * number-of-ready-fds == pretty-high-cache-drain

Perhaps there is a cache issue, but note it is the number of _new_ ready
fds (since the last sample), not the number currently ready.

> > That will be completely swamped by the system calls and so on needed to
> > processes each of the file descriptors.  I.e. no scalability problem here.
> 
> The other issue is that by keeping infos in file* you'll have to scan each fd
> to report the ready ones, that will make the method to fall back in O(n).

No, that would be silly.  You would queue signals exactly as they are
queued now (but collapsing multiple signals per fd into one).

> Anyway there's a pretty good patch ( http://www.luban.org/GPL/gpl.html ),
> that has been tested here :
> 
> http://www.xmailserver.org/linux-patches/nio-improve.html
> 
> that implement the signal-per-fd mechanism and it achieves a very good
> scalability too.

It has the bonus of requiring no userspace changes too.  Lovely!

-- Jamie

