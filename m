Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261763AbUEWKBC@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261763AbUEWKBC (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 23 May 2004 06:01:02 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262003AbUEWKBC
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 23 May 2004 06:01:02 -0400
Received: from warden3-p.diginsite.com ([208.147.64.186]:11706 "HELO
	warden3.diginsite.com") by vger.kernel.org with SMTP
	id S261763AbUEWKA6 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 23 May 2004 06:00:58 -0400
From: David Lang <david.lang@digitalinsight.com>
To: Christian Borntraeger <linux-kernel@borntraeger.net>
Cc: linux-kernel@vger.kernel.org, Gergely Czuczy <phoemix@harmless.hu>,
       itk-sysadm@ppke.hu
Date: Sun, 23 May 2004 03:00:51 -0700 (PDT)
X-X-Sender: dlang@dlang.diginsite.com
Subject: Re: Linux 2.4 VS 2.6 fork VS thread creation time test
In-Reply-To: <200405231139.44096.linux-kernel@borntraeger.net>
Message-ID: <Pine.LNX.4.58.0405230247450.8199@dlang.diginsite.com>
References: <Pine.LNX.4.60.0405230914330.15840@localhost>
 <200405231139.44096.linux-kernel@borntraeger.net>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 23 May 2004, Christian Borntraeger wrote:

> Date: Sun, 23 May 2004 11:39:41 +0200
> From: Christian Borntraeger <linux-kernel@borntraeger.net>
> To: linux-kernel@vger.kernel.org
> Cc: Gergely Czuczy <phoemix@harmless.hu>, itk-sysadm@ppke.hu
> Subject: Re: Linux 2.4 VS 2.6 fork VS thread creation time test
>
> Gergely Czuczy wrote:
> > failed. As I told it above all the processes are teminated right after
> > creation, but there were a lot of defunct processes in the system, and
> > they were only gone when the parent termineted.
>
> Have you heard of wait, waitpid and pthread_join?

there really is some sort of problem with 2.6.6 in this area. I have an
app that I am trying to stress test on a dual opteron system and under a
heavy load something goes haywire and the children become zombies. on a
dual athlon the test manages 2500 forks/sec and can continue forever (Ok,
I only tested it to 11M forks at full speed :-), but the dual opteron box
manages 3500 connections/sec for a few thousand connections and then stops
reaping the children. if I attach strace to the parent at this point the
logjam is broken and strace shows the wait calls receiving and handleing
the sigchild

the prarent deals with sigchild by
handler{
while ( wait(...) >0);
signal(SIGCHLD, handler);
}

unfortunantly trying to leave strace attached while running the test slows
it down to ~1200 forks/sec and the problem never forms.

David Lang

-- 
"Debugging is twice as hard as writing the code in the first place.
Therefore, if you write the code as cleverly as possible, you are,
by definition, not smart enough to debug it." - Brian W. Kernighan
