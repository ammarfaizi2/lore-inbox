Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S274765AbRIUGBB>; Fri, 21 Sep 2001 02:01:01 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S274766AbRIUGAv>; Fri, 21 Sep 2001 02:00:51 -0400
Received: from smtp7.xs4all.nl ([194.109.127.133]:24556 "EHLO smtp7.xs4all.nl")
	by vger.kernel.org with ESMTP id <S274765AbRIUGAm>;
	Fri, 21 Sep 2001 02:00:42 -0400
Path: Home.Lunix!not-for-mail
Subject: Re: [PATCH] /dev/epoll update ...
Date: Fri, 21 Sep 2001 05:59:23 +0000 (UTC)
Organization: lunix confusion services
In-Reply-To: <XFMail.20010919151147.davidel@xmailserver.org>
NNTP-Posting-Host: kali.eth
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-Trace: quasar.home.lunix 1001051963 508 10.253.0.3 (21 Sep 2001 05:59:23
    GMT)
X-Complaints-To: abuse-0@ton.iguana.be
NNTP-Posting-Date: Fri, 21 Sep 2001 05:59:23 +0000 (UTC)
X-Newsreader: knews 1.0b.0
Xref: Home.Lunix mail.linux.kernel:113163
X-Mailer: Perl5 Mail::Internet v1.33
Message-Id: <9oekvr$fs$1@post.home.lunix>
From: linux-kernel@ton.iguana.be (Ton Hospel)
To: linux-kernel@vger.kernel.org
Reply-To: linux-kernel@ton.iguana.be (Ton Hospel)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

In article <XFMail.20010919151147.davidel@xmailserver.org>,
	Davide Libenzi <davidel@xmailserver.org> writes:
> On 19-Sep-2001 Christopher K. St. John wrote:
>> Davide Libenzi wrote:
> Again :
> 
> 1)      select()/poll();
> 2)      recv()/send();
> 
> vs :
> 
> 1)      if (recv()/send() == FAIL)
> 2)              ioctl(EP_POLL);
> 

mm, I don't really get the second one. What if the scenario is:
In the place you are in your program, you now decide that a
read is in order.  You try read, nothing there yet,
the syscall returns, the data event happens and THEN you go into
the ioctl ?

Possibilities seem:
1) You hang, having missed the only event that will happen
2) Just having data triggers the ioctl (maybe only the first time),
   why not leaving out the initial read then and just do it afterwards
   like select ?
3) It generates a fake event the first time you notify interest, but then
   the startup case leads to doing the read uselessly twice.

Or is there a fourth way I'm missing this really works ?
