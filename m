Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S284472AbRLEQpO>; Wed, 5 Dec 2001 11:45:14 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S284482AbRLEQpF>; Wed, 5 Dec 2001 11:45:05 -0500
Received: from smtp02.uc3m.es ([163.117.136.122]:40203 "HELO smtp.uc3m.es")
	by vger.kernel.org with SMTP id <S284472AbRLEQoy>;
	Wed, 5 Dec 2001 11:44:54 -0500
From: "Peter T. Breuer" <ptb@it.uc3m.es>
Message-Id: <200112051644.fB5GiWm19167@oboe.it.uc3m.es>
Subject: Re: Current NBD 'stuff'
In-Reply-To: <Pine.LNX.4.10.10112051058140.17617-100000@clements.sc.steeleye.com>
 from "Paul Clements" at "Dec 5, 2001 11:14:43 am"
To: Paul.Clements@steeleye.com
Date: Wed, 5 Dec 2001 17:44:32 +0100 (MET)
Cc: "linux kernel" <linux-kernel@vger.kernel.org>
X-Anonymously-To: 
Reply-To: ptb@it.uc3m.es
X-Mailer: ELM [version 2.4ME+ PL66 (25)]
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

"Paul Clements wrote:"
> On 4 Dec 2001, Edward Muller wrote:
> > Actually I am playing with ENBD now.
> Yep. I've looked at that too.
> > I think ENBD is targeted for inclusion in the kernel in 2.5, but it can
> > be found seperatly (sp) at http://www.it.uc3m.es/~ptb/nbd/
> > 
> > It looks much better than the nbd stuff that is currently in the kernel.
> 
> A word of caution on this. I played around with ENBD (as well as some
> others) about 6 months ago. I also did some performance testing with
> the different drivers and user-level utilities. What I found was that
> ENBD achieved only about 1/3 ~ 1/4 the throughput of NBD (even with
> multiple replication paths and various block sizes). YMMV.

It probably is much slower, because it does networking from userspace
(permitting things like ssl channels, automatic reconnects and other
fallover-like things). Nevertheless, I get about 18MB/s writing to
localhost on my 366MHz portable, and about 5MB/s doing raid resync
across NBD to scsi devices across 100BT. Come to think of it, maybe
that IS the speed of the scsi devices, they're a raid5 assembly running
as a raid0 component connected by NBD .... 

Here's the printout from the device itself in my max speed test on the
portable in my hands. It seems to be still running (kernel 2.4.3 plus
xfs)

   ...
   [b] B/s max:    18.6M   (0R+18.6MW)
   [b] Spectrum:   70%23   15%102  12%252
   ...
   
(uh, the last line is the size-of-sent-request spectrum, data in 1K blocks
- it looks like I thumped it with 16MB of data to write at once in the
test and varied the max limit continuously as I did so, but there was
only time for three limit changes)

Read is always fast, of course.

> I also looked at DRBD, which performed pretty well (comparable to NBD).

But then you are talking about kernel 2.2, not kernel 2.4, surely?
There is now a -pre for DRDB under kernels 2.4, but I didn't think
there was several months ago.

> > But that's mostly because Pavel doesn't have much time at the moment for
> > it AFAIK.
> 
> Yeah. I wish I had the time to develop/maintain a network block 
> device driver myself...but unfortunately I don't... :/

The real difficulty is in user space with the reconnect strategies and
what to do with the various weird tcp states you can get into. The
test above was trying to produce a classic deadlock to localhost, but
didn't "succeed".

Peter
