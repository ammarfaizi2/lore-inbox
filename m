Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261566AbSJPWMO>; Wed, 16 Oct 2002 18:12:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261579AbSJPWMO>; Wed, 16 Oct 2002 18:12:14 -0400
Received: from abraham.CS.Berkeley.EDU ([128.32.37.170]:54289 "EHLO
	mx2.cypherpunks.ca") by vger.kernel.org with ESMTP
	id <S261566AbSJPWMN>; Wed, 16 Oct 2002 18:12:13 -0400
To: linux-kernel@vger.kernel.org
Path: not-for-mail
From: daw@mozart.cs.berkeley.edu (David Wagner)
Newsgroups: isaac.lists.linux-kernel
Subject: Re: can chroot be made safe for non-root?
Date: 16 Oct 2002 22:00:38 GMT
Organization: University of California, Berkeley
Distribution: isaac
Message-ID: <aokni6$9n9$1@abraham.cs.berkeley.edu>
References: <20021016015106.E30836@ma-northadams1b-3.bur.adelphia.net> <87n0pevq5r.fsf@ceramic.fifi.org> <aokl28$955$2@abraham.cs.berkeley.edu> <87elaqrqg4.fsf@ceramic.fifi.org>
NNTP-Posting-Host: mozart.cs.berkeley.edu
X-Trace: abraham.cs.berkeley.edu 1034805638 9961 128.32.153.211 (16 Oct 2002 22:00:38 GMT)
X-Complaints-To: news@abraham.cs.berkeley.edu
NNTP-Posting-Date: 16 Oct 2002 22:00:38 GMT
X-Newsreader: trn 4.0-test74 (May 26, 2000)
Originator: daw@mozart.cs.berkeley.edu (David Wagner)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Philippe Troin  wrote:
>daw@mozart.cs.berkeley.edu (David Wagner) writes:
>> Philippe Troin  wrote:
>> >  fd = open("/", O_RDONLY);
>> >  chroot("/tmp");
>> >  fchdir(fd);
>> >
>> >and you're out of the chroot.
>> 
>> Irrelevant.  If a process *wants* to voluntarily sandbox itself, it can
>> close all open file descriptors before sandboxing.
>
>You missed the point.
>
>If the process can be forced to run the above (possibly via a stack
>overflow), then it is out of the chroot.

Ahh, yes.  Exactly so.  My apologies for missing your point.

Still, I don't think this is a big deal.  The problem is that if
a chroot-ed process can call chroot() again, it can escape from the
chroot jail.  There is one obvious solution: simply don't allow chroot-ed
process to call chroot() again.  This is addressed in the link I posted
previously.

So I still think that chroot() could plausibly be made safe for non-root
users.
