Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S274219AbRISWJK>; Wed, 19 Sep 2001 18:09:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S274214AbRISWJE>; Wed, 19 Sep 2001 18:09:04 -0400
Received: from [208.129.208.52] ([208.129.208.52]:54795 "EHLO xmailserver.org")
	by vger.kernel.org with ESMTP id <S274215AbRISWIw>;
	Wed, 19 Sep 2001 18:08:52 -0400
Message-ID: <XFMail.20010919151147.davidel@xmailserver.org>
X-Mailer: XFMail 1.5.0 on Linux
X-Priority: 3 (Normal)
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
In-Reply-To: <3BA912EA.F29B5AD9@distributopia.com>
Date: Wed, 19 Sep 2001 15:11:47 -0700 (PDT)
From: Davide Libenzi <davidel@xmailserver.org>
To: "Christopher K. St. John" <cks@distributopia.com>
Subject: Re: [PATCH] /dev/epoll update ...
Cc: Dan Kegel <dank@kegel.com>, linux-kernel@vger.kernel.org
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On 19-Sep-2001 Christopher K. St. John wrote:
> Davide Libenzi wrote:
>> 
>> >     - check new_socket_fd for readable, writable, and
>> >       error. if any true, then add new event to
>> >       event queue, as if the state had changed.
>> 
>> No it does't check. It's not needed for how it works.
>> 
> 
>  Yes, I see that it currently works that way. I'm
> suggesting that it's a needlessly awkward way to work.
> It also results in thousands of spurious syscalls a
> second as servers are forced to double check there
> isn't i/o to be done.

Again :

1)      select()/poll();
2)      recv()/send();

vs :

1)      if (recv()/send() == FAIL)
2)              ioctl(EP_POLL);


When there's no data/tx buffer full these will result in 2 syscalls while
if data is available/tx buffer ok the first method will result in 2 syscalls
while the second will never call the ioctl(). 
It looks very linear to me, with select()/poll() you're asking for a state while
with /dev/epoll you're asking for a state change.




- Davide

