Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263285AbTDGG5W (for <rfc822;willy@w.ods.org>); Mon, 7 Apr 2003 02:57:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263286AbTDGG5W (for <rfc822;linux-kernel-outgoing>); Mon, 7 Apr 2003 02:57:22 -0400
Received: from abraham.CS.Berkeley.EDU ([128.32.37.170]:24838 "EHLO
	mx2.cypherpunks.ca") by vger.kernel.org with ESMTP id S263285AbTDGG5V (for <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 7 Apr 2003 02:57:21 -0400
To: linux-kernel@vger.kernel.org
Path: not-for-mail
From: daw@mozart.cs.berkeley.edu (David Wagner)
Newsgroups: isaac.lists.linux-kernel
Subject: Re: [PATCH] new syscall: flink
Date: 7 Apr 2003 06:43:40 GMT
Organization: University of California, Berkeley
Distribution: isaac
Message-ID: <b6r6ms$tuj$1@abraham.cs.berkeley.edu>
References: <3E907A94.9000305@kegel.com> <1049663559.1602.46.camel@dhcp22.swansea.linux.org.uk> <b6qo2a$ecl$1@cesium.transmeta.com> <b6r24v$f50$1@cesium.transmeta.com>
NNTP-Posting-Host: mozart.cs.berkeley.edu
X-Trace: abraham.cs.berkeley.edu 1049697820 30675 128.32.153.211 (7 Apr 2003 06:43:40 GMT)
X-Complaints-To: news@abraham.cs.berkeley.edu
NNTP-Posting-Date: 7 Apr 2003 06:43:40 GMT
X-Newsreader: trn 4.0-test74 (May 26, 2000)
Originator: daw@mozart.cs.berkeley.edu (David Wagner)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

H. Peter Anvin wrote:
>Here is a better piece of sample code that actually shows a
>permissions violation happening:
>
>[...]
>mkdir("testdir", 0700)                  = 0
>open("testdir/testfile", O_WRONLY|O_CREAT|O_TRUNC, 0666) = 3
>write(3, "Ansiktsburk\n", 12)           = 12
>close(3)                                = 0
>open("testdir/testfile", O_RDONLY)      = 3
>chmod("testdir", 0)                     = 0
>open("/proc/self/fd/3", O_RDWR)         = 4
>write(4, "Tjo fidelittan hatt!\n", 21)  = 21

You're right!  Good point. I retract the comments in my previous email.
(I did try an experiment like this, but apparently not the right one.)

My conclusion: /proc/*/fd is a security hole.  It should be fixed.
Do you agree?
