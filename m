Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265016AbRFUQID>; Thu, 21 Jun 2001 12:08:03 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265018AbRFUQHx>; Thu, 21 Jun 2001 12:07:53 -0400
Received: from sncgw.nai.com ([161.69.248.229]:52407 "EHLO mcafee-labs.nai.com")
	by vger.kernel.org with ESMTP id <S265016AbRFUQHm>;
	Thu, 21 Jun 2001 12:07:42 -0400
Message-ID: <XFMail.20010621091050.davidel@xmailserver.org>
X-Mailer: XFMail 1.4.7 on Linux
X-Priority: 3 (Normal)
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
In-Reply-To: <NCBBLIEPOCNJOAEKBEAKCEPBPPAA.davids@webmaster.com>
Date: Thu, 21 Jun 2001 09:10:50 -0700 (PDT)
From: Davide Libenzi <davidel@xmailserver.org>
To: David Schwartz <davids@webmaster.com>
Subject: RE: Why use threads ( was: Alan Cox quote?)
Cc: linux-kernel@vger.kernel.org
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On 21-Jun-2001 David Schwartz wrote:
>       Okay, let's compare two servers.
> 
>       Server one is handling 10 file descriptors. The cost of a single call to
> poll is 3 microseconds. Assume that the server is coded to get back to
> 'poll' as quickly as it can, but due to load the code manages to call 'poll'
> every 100 microseconds, so the overhead of poll is 3% of the available CPU.

Maybe You read a paper by Richard Gooch but I think You read it wrong :

http://www.atnf.csiro.au/~rgooch/linux/docs/io-events.html

<quote>
The kernel has to scan your array of FDs and check which ones are active. This
takes approximately 3 microseconds (3 us) per FD on a Pentium 100 running Linux
2.1.x. Now you might think that 3 us is quite fast, but consider if you have an
array of 1000 FDs. This is now 3 milliseconds (3 ms), which is 30% of your
timeslice (each timeslice is 10 ms). If it happens that there is initially no
activity and you specified a timeout, the kernel will have to perform a second
scan after some activity occurs or the syscall times out. Ouch! If you have an
even bigger application (like a large http server), you can easily have 10000
FDs. Scanning times will then take 30 ms, which is three timeslices! This is
just way too much.
</quote>

Anyway there's no need to continue this ( quite long ) thread.




- Davide

