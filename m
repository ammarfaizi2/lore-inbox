Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317579AbSGEVNB>; Fri, 5 Jul 2002 17:13:01 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317580AbSGEVNA>; Fri, 5 Jul 2002 17:13:00 -0400
Received: from abraham.CS.Berkeley.EDU ([128.32.247.199]:16647 "EHLO
	mx2.cypherpunks.ca") by vger.kernel.org with ESMTP
	id <S317579AbSGEVM7>; Fri, 5 Jul 2002 17:12:59 -0400
To: linux-kernel@vger.kernel.org
Path: not-for-mail
From: daw@mozart.cs.berkeley.edu (David Wagner)
Newsgroups: isaac.lists.linux-kernel
Subject: Re: prevent breaking a chroot() jail?
Date: 5 Jul 2002 21:00:55 GMT
Organization: University of California, Berkeley
Distribution: isaac
Message-ID: <ag51e7$rru$1@abraham.cs.berkeley.edu>
References: <1025877004.11004.59.camel@zaphod> <ag48ui$fb5$1@ncc1701.cistron.net> <1025879850.11004.75.camel@zaphod>
NNTP-Posting-Host: mozart.cs.berkeley.edu
X-Trace: abraham.cs.berkeley.edu 1025902855 28542 128.32.153.211 (5 Jul 2002 21:00:55 GMT)
X-Complaints-To: news@abraham.cs.berkeley.edu
NNTP-Posting-Date: 5 Jul 2002 21:00:55 GMT
X-Newsreader: trn 4.0-test74 (May 26, 2000)
Originator: daw@mozart.cs.berkeley.edu (David Wagner)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Shaya Potter  wrote:
>if one changed the semantics of chroot() to also do a chdir() to the new root,
>would that be fixed?

There are lots of other ways for root to escape from a chroot jail.
For example: Take control of another process using ptrace, mknod a new
device, use the loopback filesystem to create new devices, mount /proc and
modify /dev/kmem, bind to privileged ports and escape over the network,
kill servers and re-bind to their addresses, mount a new filesystem,
bang on IPC or shared memory, load a loadable kernel module, directly
access hardware with iopl(), and so on.

Moreover, note that chrooted root processes can do lots of other harm:
kill all the rest of the processes on the box, set the time of day,
set the local hostname, reboot your machine, use sysctl to turn on
some dangerous option (e.g., IP forwarding), renice other processes,
and the like.  This is probably not so good, either.

Chroot is a lot better than nothing, but it doesn't provide a
secure jail, especially not for root.  However, the following
tools are intended to provide a secure jail, and may be of interest
to you: SubDomain (http://www.immunix.org/subdomain.html), Janus
(http://www.cs.berkeley.edu/~daw/janus/), and BSD's jail() system call
come to mind.  Also, may I point you to the Linux Security Modules project
(http://lsm.immunix.org/)?  I think you may find it of interest.
