Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S273529AbRIUQol>; Fri, 21 Sep 2001 12:44:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S273525AbRIUQoe>; Fri, 21 Sep 2001 12:44:34 -0400
Received: from [208.129.208.52] ([208.129.208.52]:39436 "EHLO xmailserver.org")
	by vger.kernel.org with ESMTP id <S273529AbRIUQoU>;
	Fri, 21 Sep 2001 12:44:20 -0400
Message-ID: <XFMail.20010921094813.davidel@xmailserver.org>
X-Mailer: XFMail 1.5.0 on Linux
X-Priority: 3 (Normal)
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
In-Reply-To: <9oekvr$fs$1@post.home.lunix>
Date: Fri, 21 Sep 2001 09:48:13 -0700 (PDT)
From: Davide Libenzi <davidel@xmailserver.org>
To: <linux-kernel@ton.iguana.be (Ton Hospel)>
Subject: Re: [PATCH] /dev/epoll update ...
Cc: linux-kernel@vger.kernel.org
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On 21-Sep-2001 Ton Hospel wrote:
> In article <XFMail.20010919151147.davidel@xmailserver.org>,
>       Davide Libenzi <davidel@xmailserver.org> writes:
>> On 19-Sep-2001 Christopher K. St. John wrote:
>>> Davide Libenzi wrote:
>> Again :
>> 
>> 1)      select()/poll();
>> 2)      recv()/send();
>> 
>> vs :
>> 
>> 1)      if (recv()/send() == FAIL)
>> 2)              ioctl(EP_POLL);
>> 
> 
> mm, I don't really get the second one. What if the scenario is:
> In the place you are in your program, you now decide that a
> read is in order.  You try read, nothing there yet,
> the syscall returns, the data event happens and THEN you go into
> the ioctl ?
> 
> Possibilities seem:
> 1) You hang, having missed the only event that will happen
> 2) Just having data triggers the ioctl (maybe only the first time),
>    why not leaving out the initial read then and just do it afterwards
>    like select ?
> 3) It generates a fake event the first time you notify interest, but then
>    the startup case leads to doing the read uselessly twice.
> 
> Or is there a fourth way I'm missing this really works ?

That was a simplified function :

        while (recv()/send() == FAIL)
                ioctl(EP_POLL);

this is the right code.
If an event happens between the recv() and the ioctl() this is cached by the
driver and it'll be returned from ioctl().




- Davide

