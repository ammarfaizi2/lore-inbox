Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S287408AbSBDSLi>; Mon, 4 Feb 2002 13:11:38 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S274862AbSBDSL3>; Mon, 4 Feb 2002 13:11:29 -0500
Received: from proxyscan.quakenet.org ([213.221.173.2]:53253 "EHLO
	grail.phat-pipe.net") by vger.kernel.org with ESMTP
	id <S287408AbSBDSLY>; Mon, 4 Feb 2002 13:11:24 -0500
From: "Darren Smith" <data@barrysworld.com>
To: "'Aaron Sethman'" <androsyn@ratbox.org>
Cc: "'Andrew Morton'" <akpm@zip.com.au>, "'Dan Kegel'" <dank@kegel.com>,
        "'Vincent Sweeney'" <v.sweeney@barrysworld.com>,
        <linux-kernel@vger.kernel.org>, <coder-com@undernet.org>,
        "'Kevin L. Mitchell'" <klmitch@mit.edu>
Subject: RE: [Coder-Com] Re: PROBLEM: high system usage / poor SMP network performance
Date: Mon, 4 Feb 2002 18:11:23 -0000
Message-ID: <000001c1ada7$5ad5cfb0$5c5a1e3e@wilma>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 7bit
X-Priority: 3 (Normal)
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook, Build 10.0.2616
In-Reply-To: <Pine.LNX.4.44.0202041239310.4584-100000@simon.ratbox.org>
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2600.0000
Importance: Normal
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I mean I added a usleep() before the poll in s_bsd.c for the undernet
2.10.10 code.

 timeout = (IRCD_MIN(delay2, delay)) * 1000;
 + usleep(100000); <- New Line
 nfds = poll(poll_fds, pfd_count, timeout);

And now we're using 1/8th the cpu! With no noticeable effects.

Regards

Darren.

-----Original Message-----
From: Aaron Sethman [mailto:androsyn@ratbox.org] 
Sent: 04 February 2002 17:41
To: Darren Smith
Cc: 'Andrew Morton'; 'Dan Kegel'; 'Vincent Sweeney';
linux-kernel@vger.kernel.org; coder-com@undernet.org; 'Kevin L.
Mitchell'
Subject: RE: [Coder-Com] Re: PROBLEM: high system usage / poor SMP
network performance


On Mon, 4 Feb 2002, Darren Smith wrote:

> Hi
>
> I've been testing the modified Undernet (2.10.10) code with Vincent
> Sweeney based on the simple usleep(100000) addition to s_bsd.c
>
> PRI NICE  SIZE    RES STATE  C   TIME   WCPU    CPU | # USERS
>  2   0 96348K 96144K poll   0  29.0H 39.01% 39.01%  |  1700 <- Without
> Patch
> 10   0 77584K 77336K nanslp 0   7:08  5.71%  5.71%  |  1500 <- With
> Patch
Were you not putting a delay argument into poll(), or perhaps not
letting
it delay long enough?  If you just do poll with a timeout of 0, its
going
to suck lots of cpu.

Regards,

Aaron



