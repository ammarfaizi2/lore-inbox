Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S274205AbRIXWQT>; Mon, 24 Sep 2001 18:16:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S274203AbRIXWQI>; Mon, 24 Sep 2001 18:16:08 -0400
Received: from [208.129.208.52] ([208.129.208.52]:54535 "EHLO xmailserver.org")
	by vger.kernel.org with ESMTP id <S274207AbRIXWP4>;
	Mon, 24 Sep 2001 18:15:56 -0400
Message-ID: <XFMail.20010924152011.davidel@xmailserver.org>
X-Mailer: XFMail 1.5.0 on Linux
X-Priority: 3 (Normal)
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
In-Reply-To: <20010924230909.A10253@kushida.jlokier.co.uk>
Date: Mon, 24 Sep 2001 15:20:11 -0700 (PDT)
From: Davide Libenzi <davidel@xmailserver.org>
To: Jamie Lokier <lk@tantalophile.demon.co.uk>
Subject: Re: [PATCH] /dev/epoll update ...
Cc: Gordon Oliver <gordo@pincoya.com>
Cc: Gordon Oliver <gordo@pincoya.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Dan Kegel <dank@kegel.com>,
        "Eric W. Biederman" <ebiederm@xmission.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On 24-Sep-2001 Jamie Lokier wrote:
> Davide Libenzi wrote:
>> > Well, memory move consists of 2 words: (a) file descriptor; (b) poll
>> > state/edge flags.
>> 
>> 2-words * number-of-ready-fds == pretty-high-cache-drain
> 
> Perhaps there is a cache issue, but note it is the number of _new_ ready
> fds (since the last sample), not the number currently ready.
> 
>> > That will be completely swamped by the system calls and so on needed to
>> > processes each of the file descriptors.  I.e. no scalability problem here.
>> 
>> The other issue is that by keeping infos in file* you'll have to scan each fd
>> to report the ready ones, that will make the method to fall back in O(n).
> 
> No, that would be silly.  You would queue signals exactly as they are
> queued now (but collapsing multiple signals per fd into one).
> 
>> Anyway there's a pretty good patch ( http://www.luban.org/GPL/gpl.html ),
>> that has been tested here :
>> 
>> http://www.xmailserver.org/linux-patches/nio-improve.html
>> 
>> that implement the signal-per-fd mechanism and it achieves a very good
>> scalability too.
> 
> It has the bonus of requiring no userspace changes too.  Lovely!

Sure you can avoid the scan, if you pick up one event at a time.
To be compared to /dev/epoll you need the signal-per-fd patch plus a method to
collect the whole event-set in a single system call ( see perfs ).




- Davide

