Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263294AbTJQDO3 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 16 Oct 2003 23:14:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263298AbTJQDO3
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 16 Oct 2003 23:14:29 -0400
Received: from rwcrmhc12.comcast.net ([216.148.227.85]:64434 "EHLO
	rwcrmhc12.comcast.net") by vger.kernel.org with ESMTP
	id S263294AbTJQDO2 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 16 Oct 2003 23:14:28 -0400
Subject: Re: decaying average for %CPU
From: Albert Cahalan <albert@users.sf.net>
To: Nick Piggin <piggin@cyberone.com.au>
Cc: Albert Cahalan <albert@users.sourceforge.net>,
       linux-kernel mailing list <linux-kernel@vger.kernel.org>
In-Reply-To: <3F8F5A53.50209@cyberone.com.au>
References: <1066358155.15931.145.camel@cube>
	 <3F8F5A53.50209@cyberone.com.au>
Content-Type: text/plain
Organization: 
Message-Id: <1066359629.15920.161.camel@cube>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.2.4 
Date: 16 Oct 2003 23:00:29 -0400
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2003-10-16 at 22:56, Nick Piggin wrote:
> Albert Cahalan wrote:
> 
> >The UNIX standard requires that Linux provide
> >some measure of a process's "recent" CPU usage.
> >Right now, it isn't provided. You might run a
> >CPU hog for a year, stop it ("kill -STOP 42")
> >for a few hours, and see that "ps" is still
> >reporting 99.9% CPU usage. This is because the
> >kernel does not provide a decaying average.
> 
> I think the kernel provides enough info for userspace to do
> the job, doesn't it?

I'm pretty sure not. Linux provides:

per-process start time
current time
per-process total (lifetime) CPU usage
units of time measurement (awkwardly)
boot time

>From that you can compute %CPU over the whole
life of the process. This does not meet the
requirements of the UNIX standard.

What we do for load average is about right,
except that per-process values can't all get
updated at the same time. So the algorithm
needs to be adjusted a bit to allow for that


