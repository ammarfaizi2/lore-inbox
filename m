Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263338AbUDAX3n (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 1 Apr 2004 18:29:43 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263346AbUDAX3n
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 1 Apr 2004 18:29:43 -0500
Received: from rav-az.mvista.com ([65.200.49.157]:44067 "EHLO
	zipcode.az.mvista.com") by vger.kernel.org with ESMTP
	id S263338AbUDAX3l (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 1 Apr 2004 18:29:41 -0500
Subject: Re: epoll reporting events when it hasn't been asked to
From: Steven Dake <sdake@mvista.com>
Reply-To: sdake@mvista.com
To: Davide Libenzi <davidel@xmailserver.org>
Cc: Ben Mansell <ben@zeus.com>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
In-Reply-To: <Pine.LNX.4.44.0404011125510.2509-100000@bigblue.dev.mdolabs.com>
References: <Pine.LNX.4.44.0404011125510.2509-100000@bigblue.dev.mdolabs.com>
Content-Type: text/plain
Organization: MontaVista Software, Inc.
Message-Id: <1080862174.9534.112.camel@persist.az.mvista.com>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.5 
Date: Thu, 01 Apr 2004 16:29:35 -0700
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2004-04-01 at 12:28, Davide Libenzi wrote:
> On Thu, 1 Apr 2004, Ben Mansell wrote:
> 
> > > It is a feature. epoll OR user events with POLLHUP|POLLERR so that even if
> > > the user sets the event mask to zero, it can still know when something
> > > like those abnormal condition happened. Which problem do you see with this?
> > 
> > What should the application do if it gets events that it didn't ask for?
> > If you choose to ignore them, the next time epoll_wait() is called it
> > will return instantly with these same messages, so the app will spin and
> > eat CPU.
> 
> Shouldn't the application handle those exceptional conditions instead of 
> ignoring them?
> 
> 

If an exception occurs (example a socket is disconnected) the socket
should be removed from the fd list.  There is really no point in passing
in an excepted fd.

epoll works just like poll and the expected SUS behavior in this regard.

Thanks
-steve


