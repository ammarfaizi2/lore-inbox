Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030414AbWGHWyf@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030414AbWGHWyf (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 8 Jul 2006 18:54:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030415AbWGHWye
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 8 Jul 2006 18:54:34 -0400
Received: from main.gmane.org ([80.91.229.2]:45764 "EHLO ciao.gmane.org")
	by vger.kernel.org with ESMTP id S1030414AbWGHWye (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 8 Jul 2006 18:54:34 -0400
X-Injected-Via-Gmane: http://gmane.org/
To: linux-kernel@vger.kernel.org
From: Ask List <askthelist@gmail.com>
Subject: Re: Runnable threads on run queue
Date: Sat, 8 Jul 2006 22:54:24 +0000 (UTC)
Message-ID: <loom.20060709T005347-41@post.gmane.org>
References: <loom.20060708T220409-206@post.gmane.org> <200607081618.42093.chase.venters@clientec.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-Complaints-To: usenet@sea.gmane.org
X-Gmane-NNTP-Posting-Host: main.gmane.org
User-Agent: Loom/3.14 (http://gmane.org/)
X-Loom-IP: 66.237.13.5 (Mozilla/5.0 (Windows; U; Windows NT 5.1; en-US; rv:1.8.0.4) Gecko/20060508 Firefox/1.5.0.4)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Chase Venters <chase.venters <at> clientec.com> writes:

> 
> On Saturday 08 July 2006 15:18, Ask List wrote:
> > Have an issue maybe someone on this list can help with.
> >
> > At times of very high load the number of processes on the run queue drops
> > to 0 then jumps really high and then drops to 0 and back and forth. It
> > seems to last 10 seconds or so. If you look at this vmstat you can see an
> > example of what I mean. Now im not a linux kernel expert but i am thinking
> > it has something to do with the scheduling algorithm and locking of the run
> > queue. For this particular application I need all available threads to be
> > processed as fast as possible. Is there a way for me to elimnate this
> > behavior or at least minimize the window in which there are no threads on
> > the run queue? Is there a sysctl parameter I can use?
> 
> If there's a runnable task on the system, the run queue should never empty 
> except inside schedule(). The scheduler should then swap expired and active.
> 
> First question - what kernel are you running? Is it stock?
> 
> Second question - what's the application? Are you sure your threads just 
> aren't falling into interruptible sleep due to an app bug of some sort? Are 
> you observing misbehavior in the application (long pauses) or just in the 
> reporting?
> 
> Thanks,
> Chase
> 

The kernel version is a debian kernel source version 2.4.27-3 and it was
recompiled to support SMP, High Memory, etc. The application is SpamAssassin
version 3.1.1. It is possible there may be an app bug, however I do not know
this for certain. We have manipulated the configuration of the daemon to try and
aleviate the symptoms to no avail. We experience the issues if we use a mysql
backend for the bayes db or not. We are experiencing misbehavior in the
application in the sense of the time it takes for messages to be processed. It
normally takes tenths of a second to process incoming mail, however we notice
the processing time jump to over 10 seconds each time the run queue drops to 0
and then drops back down to tenths of a second when the queue fills back up.


