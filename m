Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S274114AbRISRWS>; Wed, 19 Sep 2001 13:22:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S274115AbRISRWJ>; Wed, 19 Sep 2001 13:22:09 -0400
Received: from [208.129.208.52] ([208.129.208.52]:57606 "EHLO xmailserver.org")
	by vger.kernel.org with ESMTP id <S274114AbRISRVz>;
	Wed, 19 Sep 2001 13:21:55 -0400
Message-ID: <XFMail.20010919102538.davidel@xmailserver.org>
X-Mailer: XFMail 1.5.0 on Linux
X-Priority: 3 (Normal)
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
In-Reply-To: <3BA84367.239FA0B4@distributopia.com>
Date: Wed, 19 Sep 2001 10:25:38 -0700 (PDT)
From: Davide Libenzi <davidel@xmailserver.org>
To: "Christopher K. St. John" <cks@distributopia.com>
Subject: Re: [PATCH] /dev/epoll update ...
Cc: Dan Kegel <dank@kegel.com>, linux-kernel@vger.kernel.org
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On 19-Sep-2001 Christopher K. St. John wrote:
> Dan Kegel wrote:
>> 
>> I'm getting ready to stress-test /dev/epoll finally.
>> In porting my Poller_devpoll.{cc,h} to support /dev/epoll, I noticed
>> the following issues:
>> 
> 
>  Another issue to throw into the mix:
> 
>  The Banga, Mogul and Druschel[1] paper (which I understand
> was the inspiration for the Solaris /dev/poll which was the
> inspiration for /dev/epoll?) talks about having the poll
> return the current state of new descriptors. As far as I can
> tell, /dev/epoll only gives you events on state changes. So,
> for example, if you accept() a new socket and add it to the
> interest list, you (probably) won't get a POLLIN. That's
> not fatal, but it's awkward.

Being an event change notification you simply can't add the fd
to the "monitor" after you've issued the accept().
The skeleton for /dev/epoll usage is :

while (system_call(...) == FAIL) {

        wait_event();
}



- Davide

