Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S274196AbRIXWEH>; Mon, 24 Sep 2001 18:04:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S274192AbRIXWD5>; Mon, 24 Sep 2001 18:03:57 -0400
Received: from [208.129.208.52] ([208.129.208.52]:39686 "EHLO xmailserver.org")
	by vger.kernel.org with ESMTP id <S274186AbRIXWDw>;
	Mon, 24 Sep 2001 18:03:52 -0400
Message-ID: <XFMail.20010924150804.davidel@xmailserver.org>
X-Mailer: XFMail 1.5.0 on Linux
X-Priority: 3 (Normal)
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
In-Reply-To: <20010924225616.D9688@kushida.jlokier.co.uk>
Date: Mon, 24 Sep 2001 15:08:04 -0700 (PDT)
From: Davide Libenzi <davidel@xmailserver.org>
To: Jamie Lokier <lk@tantalophile.demon.co.uk>
Subject: Re: [PATCH] /dev/epoll update ...
Cc: "Eric W. Biederman" <ebiederm@xmission.com>, Dan Kegel <dank@kegel.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Gordon Oliver <gordo@pincoya.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On 24-Sep-2001 Jamie Lokier wrote:
> Davide Libenzi wrote:
>> > You could even keep the memory for the queued signal / event inside
> the file structure.
>> 
>> By keeping the event structure inside the file* require you to collect
>> these events ( read memory moves ) at peek time.
>> With /dev/epoll the event is directly dropped inside the mmaped area.
> 
> Well, memory move consists of 2 words: (a) file descriptor; (b) poll
> state/edge flags.

2-words * number-of-ready-fds == pretty-high-cache-drain


> That will be completely swamped by the system calls and so on needed to
> processes each of the file descriptors.  I.e. no scalability problem here.

The other issue is that by keeping infos in file* you'll have to scan each fd
to report the ready ones, that will make the method to fall back in O(n).
Anyway there's a pretty good patch ( http://www.luban.org/GPL/gpl.html ),
that has been tested here :

http://www.xmailserver.org/linux-patches/nio-improve.html

that implement the signal-per-fd mechanism and it achieves a very good scalability too.





- Davide

