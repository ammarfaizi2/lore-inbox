Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S273904AbRISHLt>; Wed, 19 Sep 2001 03:11:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S273440AbRISHLj>; Wed, 19 Sep 2001 03:11:39 -0400
Received: from c007-h015.c007.snv.cp.net ([209.228.33.222]:12282 "HELO
	c007.snv.cp.net") by vger.kernel.org with SMTP id <S273326AbRISHLZ>;
	Wed, 19 Sep 2001 03:11:25 -0400
X-Sent: 19 Sep 2001 07:11:43 GMT
Message-ID: <3BA84367.239FA0B4@distributopia.com>
Date: Wed, 19 Sep 2001 02:04:07 -0500
From: "Christopher K. St. John" <cks@distributopia.com>
X-Mailer: Mozilla 4.61 [en] (X11; I; Linux 2.0.36 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
CC: Dan Kegel <dank@kegel.com>, davidel@xmailserver.org
Subject: Re: [PATCH] /dev/epoll update ...
In-Reply-To: <3BA80108.C830D602@kegel.com>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Dan Kegel wrote:
> 
> I'm getting ready to stress-test /dev/epoll finally.
> In porting my Poller_devpoll.{cc,h} to support /dev/epoll, I noticed
> the following issues:
> 

 Another issue to throw into the mix:

 The Banga, Mogul and Druschel[1] paper (which I understand
was the inspiration for the Solaris /dev/poll which was the
inspiration for /dev/epoll?) talks about having the poll
return the current state of new descriptors. As far as I can
tell, /dev/epoll only gives you events on state changes. So,
for example, if you accept() a new socket and add it to the
interest list, you (probably) won't get a POLLIN. That's
not fatal, but it's awkward.

 The BMD paper suggests making the behavior optional, but
I didn't see anything about it in the Solaris /dev/poll
manpage (and I don't have a copy of Solaris to try it out
on).

 My vote would be to always report the initial state, but
that would make the driver a little more complicated.

 What are the preferred semantics?


[1] http://citeseer.nj.nec.com/banga99scalable.html


-- 
Christopher St. John cks@distributopia.com
DistribuTopia http://www.distributopia.com
