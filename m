Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263199AbTDGCnl (for <rfc822;willy@w.ods.org>); Sun, 6 Apr 2003 22:43:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263202AbTDGCnl (for <rfc822;linux-kernel-outgoing>); Sun, 6 Apr 2003 22:43:41 -0400
Received: from abraham.CS.Berkeley.EDU ([128.32.37.170]:9989 "EHLO
	mx2.cypherpunks.ca") by vger.kernel.org with ESMTP id S263199AbTDGCnj (for <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 6 Apr 2003 22:43:39 -0400
To: linux-kernel@vger.kernel.org
Path: not-for-mail
From: daw@mozart.cs.berkeley.edu (David Wagner)
Newsgroups: isaac.lists.linux-kernel
Subject: Re: [PATCH] new syscall: flink
Date: 7 Apr 2003 02:29:58 GMT
Organization: University of California, Berkeley
Distribution: isaac
Message-ID: <b6qnr6$s4h$1@abraham.cs.berkeley.edu>
References: <3E907A94.9000305@kegel.com> <200304062156.37325.oliver@neukum.org> <1049663559.1602.46.camel@dhcp22.swansea.linux.org.uk> <b6qo2a$ecl$1@cesium.transmeta.com>
NNTP-Posting-Host: mozart.cs.berkeley.edu
X-Trace: abraham.cs.berkeley.edu 1049682598 28817 128.32.153.211 (7 Apr 2003 02:29:58 GMT)
X-Complaints-To: news@abraham.cs.berkeley.edu
NNTP-Posting-Date: 7 Apr 2003 02:29:58 GMT
X-Newsreader: trn 4.0-test74 (May 26, 2000)
Originator: daw@mozart.cs.berkeley.edu (David Wagner)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

H. Peter Anvin wrote:
>Alan Cox wrote:
>> Suppose I give you an O_RDONLY handle to a file which you then
>> flink and gain write access too ?
>
>This, I believe, is the real issue.  However, we already have that
>problem:

No, I don't think we already have that problem.  I think flink()
would introduce a new security hole not already present.


>  rfd = open("testfile", O_RDONLY|O_CREAT, 0666);
>  /* Now rfd is a read-only file descriptor */
>
>  sprintf(filebuf, "/proc/self/fd/%d", rfd);
>  wfd = open(filebuf, O_RDWR);

I don't think this is the same.  With /proc/self/fd, I can't escalate
privileges on a read-only fd.  You did the wrong test, because the user
already has write access to "testfile".  Change the above to make rfd a
read-only file descriptor to a file that I don't have write permission to,
and you'll find that the test all of a sudden fails.  (For instance, add
a chmod("testfile", 0444); between the two open()s, and see what happens.)

I think /proc/self/fd is doing the right thing.  /proc/self/fd doesn't
seem to be a security hole, unless I'm missing something.  I think flink()
would be a security risk, though.  Or did I overlook something?
