Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S268861AbRHBJg4>; Thu, 2 Aug 2001 05:36:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S268862AbRHBJgq>; Thu, 2 Aug 2001 05:36:46 -0400
Received: from stargate.gnyrf.net ([194.165.254.115]:38787 "HELO
	stargate.gnyrf.net") by vger.kernel.org with SMTP
	id <S268861AbRHBJge>; Thu, 2 Aug 2001 05:36:34 -0400
To: Neil Brown <neilb@cse.unsw.edu.au>
Subject: Re: resizing of raid5?
Message-ID: <996752017.3b693a9176078@stargate.gnyrf.net>
Date: Thu, 02 Aug 2001 13:33:37 +0200 (CEST)
From: Roger Abrahamsson <hyperion@gnyrf.net>
Cc: Linux Kernel <linux-kernel@vger.kernel.org>
In-Reply-To: <996657922.3b67cb02ba717@stargate.gnyrf.net> <15207.63232.611617.37794@notabene.cse.unsw.edu.au> <996685021.3b6834dd0829d@stargate.gnyrf.net> <15208.60042.84240.269386@notabene.cse.unsw.edu.au>
In-Reply-To: <15208.60042.84240.269386@notabene.cse.unsw.edu.au>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
User-Agent: IMP/PHP IMAP webmail program 2.2.5
X-Originating-IP: 212.32.163.13
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting Neil Brown <neilb@cse.unsw.edu.au>:

> 
> Hmm.  Your backup strategy is ????
> 
> Yes, you could it.  It would probably be slower that writting to tape
> and restoring, but if you don't have a tape......
> 
> You would find it very difficult to maintain safety in the event of
> failure during the re-org process, but if you are willing to risk that
> you could certainly write a fairly stright forward program to do it.
> 
> Suppose you are reconfiguring from a N drive array to an M drive
> array, and both the old and the new array use a chunk size of C.
> 
> Then choose a number X such that the staging area that you have
> (either RAM or some other drive) can contain (N-1)*(M-1)*C*X.
> 
> e.g. 64K chunks, 7 to 8 drives, 10 Gig disc space:
> 
>  X = floor (10240/6/7/64) = 3
> 
> If you don't have enough space to stage N*M*C you can still do it but
> it will be much more fiddly.
> 
> Then read X*N*M*C of the drive using the N drive layout into the
> staging area.  Then write it back out using the M drive layout.
> Repeat until done.
> You don't need to worry about calculating parity when writing out as
> you can get the raid5 module to do that automatically when you tell it
> about the new array.
> 
> If you (or anyone else) would like to try writting code to do this, I
> would be happy to review, comment, and test.  You could probably even
> do it reasonably well in perl...
> 
> NeilBrown
> -

Well, thats more or less how I had thought it. It would even be possible
(if you hack the md/raid5 code) to do a rebuild in a running system. If you
are really short on disk space, you only need to back up the first rows then.
Say if you go from N to M (M>N) size array then you would only  have to worry
about (N-1) / ((M-1)-(N-1)) rows before you would be having backup on disk in
the old rows..

Will look into this during the weekend a bit more and possibly begin to do some
code also, too much work at the moment to have time to play with this now
unfortunately. 

/Roger
