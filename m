Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265404AbSJRTL2>; Fri, 18 Oct 2002 15:11:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265401AbSJRTKJ>; Fri, 18 Oct 2002 15:10:09 -0400
Received: from zcars04f.nortelnetworks.com ([47.129.242.57]:64411 "EHLO
	zcars04f.nortelnetworks.com") by vger.kernel.org with ESMTP
	id <S265568AbSJRSuV>; Fri, 18 Oct 2002 14:50:21 -0400
Message-ID: <3DB05918.40204@nortelnetworks.com>
Date: Fri, 18 Oct 2002 14:55:20 -0400
X-Sybari-Space: 00000000 00000000 00000000
From: Chris Friesen <cfriesen@nortelnetworks.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:0.9.8) Gecko/20020204
X-Accept-Language: en-us
MIME-Version: 1.0
To: Mark Mielke <mark@mark.mielke.cc>
Cc: John Myers <jgmyers@netscape.com>, Dan Kegel <dank@kegel.com>,
       Davide Libenzi <davidel@xmailserver.org>,
       Benjamin LaHaise <bcrl@redhat.com>,
       Shailabh Nagar <nagar@watson.ibm.com>,
       linux-kernel <linux-kernel@vger.kernel.org>,
       linux-aio <linux-aio@kvack.org>, Andrew Morton <akpm@digeo.com>,
       David Miller <davem@redhat.com>,
       Linus Torvalds <torvalds@transmeta.com>,
       Stephen Tweedie <sct@redhat.com>
Subject: Re: epoll (was Re: [PATCH] async poll for 2.5)
References: <Pine.LNX.4.44.0210151403370.1554-100000@blue1.dev.mcafeelabs.com> <3DAC9035.2010208@netscape.com> <3DADC5F8.60708@kegel.com> <3DAEF6DC.9000708@netscape.com> <20021018170024.GA13087@mark.mielke.cc>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Mark Mielke wrote:
>>>>>   while (read() == EAGAIN)
>>>>>       wait(POLLIN);
>>>>>
> 
> I find myself still not understanding this thread. Lots of examples of
> code that should or should not be used, but I would always choose:
> 
>    ... ensure file descriptor is blocking ...
>    for (;;) {
>        int nread = read(...);
>        ...
>    }
> 
> Over the above, or any derivative of the above.

The main point here is determining which of many open connections need servicing.

select() and poll() do not scale well, so this is where stuff like /dev/epoll comes in--to tell you 
which of those file descriptors need to be serviced.

Chris



-- 
Chris Friesen                    | MailStop: 043/33/F10
Nortel Networks                  | work: (613) 765-0557
3500 Carling Avenue              | fax:  (613) 765-2986
Nepean, ON K2H 8E9 Canada        | email: cfriesen@nortelnetworks.com

