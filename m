Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S274818AbRIUU3T>; Fri, 21 Sep 2001 16:29:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S274819AbRIUU3K>; Fri, 21 Sep 2001 16:29:10 -0400
Received: from c007-h014.c007.snv.cp.net ([209.228.33.221]:61665 "HELO
	c007.snv.cp.net") by vger.kernel.org with SMTP id <S274818AbRIUU3G>;
	Fri, 21 Sep 2001 16:29:06 -0400
X-Sent: 21 Sep 2001 20:29:24 GMT
Message-ID: <3BABA15A.57255E63@distributopia.com>
Date: Fri, 21 Sep 2001 15:21:46 -0500
From: "Christopher K. St. John" <cks@distributopia.com>
X-Mailer: Mozilla 4.61 [en] (X11; I; Linux 2.0.36 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
CC: Davide Libenzi <davidel@xmailserver.org>
Subject: Re: /dev/yapoll : Re: [PATCH] /dev/epoll update ...
In-Reply-To: <XFMail.20010921131017.davidel@xmailserver.org>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Davide Libenzi wrote:
> 
> By reporting the initial state of the connection will
> make /dev/epoll to be a hybrid interface
>

 Yes, but you need that anyway (see below)


> and looks pretty crappy to me.
>

 Talk to the people who wrote the paper (and won
"Outstanding Paper" for it at Usenix). The paper
is quite convincing, so I'm afraid I'll have to
disagree. But as I said, I'll know more when I've
tested further.


 It turns out that a hybrid interface is needed
in any case to handle overload. When the queues
start to fill up, you need to back off and start
basically doing something like a plain-old-poll()
instead. Ref the paper. Here's a link to a kernel
list dicussion that covers similiar ground:

  http://kt.linuxcare.com/kernel-traffic/kt20001113_93.epl

 Also, merging events for the same fd, which
everyone seems to agree is a good thing, is
in fact a "hybrid" approach, right? Since 
you're now tracking state (albeit only between
calls to ioctl(EP_POLL).

 I intend to use some of the original Linux
/dev/poll code, as well as some of yours, but
it's a new patch with a new name.


-- 
Christopher St. John cks@distributopia.com
DistribuTopia http://www.distributopia.com
