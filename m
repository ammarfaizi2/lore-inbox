Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S275119AbRJJJMu>; Wed, 10 Oct 2001 05:12:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S275122AbRJJJMn>; Wed, 10 Oct 2001 05:12:43 -0400
Received: from femail13.sdc1.sfba.home.com ([24.0.95.140]:51393 "EHLO
	femail13.sdc1.sfba.home.com") by vger.kernel.org with ESMTP
	id <S275120AbRJJJMg>; Wed, 10 Oct 2001 05:12:36 -0400
Content-Type: text/plain; charset=US-ASCII
From: Rob Landley <landley@trommello.org>
Reply-To: landley@trommello.org
Organization: Boundaries Unlimited
To: Andrew Morton <akpm@zip.com.au>, BALBIR SINGH <balbir.singh@wipro.com>
Subject: Re: is reparent_to_init a good thing to do?
Date: Tue, 9 Oct 2001 16:26:18 -0400
X-Mailer: KMail [version 1.2]
Cc: lkml <linux-kernel@vger.kernel.org>
In-Reply-To: <3BC3118B.8050001@wipro.com> <3BC3223E.902FB7E@zip.com.au>
In-Reply-To: <3BC3223E.902FB7E@zip.com.au>
MIME-Version: 1.0
Message-Id: <01100916261802.09423@localhost.localdomain>
Content-Transfer-Encoding: 7BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tuesday 09 October 2001 12:13, Andrew Morton wrote:

> I think yes, more kernel threads need to use this function.  Most
> particularly, threads which are parented by a userspace application
> and which can terminate.  For example, the nfsd threads.
>
> Right now, it's probably the case that nfsd threads will turn
> into zombies when they terminate, *if* their parent is still
> running.   But of course, most kernel threads are parented
> by very short-lived userspace applications, so nobody has
> ever noticed.

Or long lived kernel threads from short lived login sessions.

You have a headless gateway box for your local subnet, administered via ssh 
from a machine on the local subnet.  So you SSH into the box through eth1, 
ifconfig eth0 down back up again.  If eth0 is an rtl8039too, this fires off a 
kernel thread (which, before reparent_to_init, was parented to your ssh login 
session).

Now exit the login session.  SSH does not exit until all the child processes 
exit, so it just hangs there until you kill it from another console window...

Rob

