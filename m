Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264186AbTF0LTo (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 27 Jun 2003 07:19:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264188AbTF0LTo
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 27 Jun 2003 07:19:44 -0400
Received: from hermine.idb.hist.no ([158.38.50.15]:57105 "HELO
	hermine.idb.hist.no") by vger.kernel.org with SMTP id S264186AbTF0LTm
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 27 Jun 2003 07:19:42 -0400
Message-ID: <3EFC2D08.6000905@aitel.hist.no>
Date: Fri, 27 Jun 2003 13:39:52 +0200
From: Helge Hafting <helgehaf@aitel.hist.no>
Organization: AITeL, HiST
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.0.0) Gecko/20020623 Debian/1.0.0-0.woody.1
X-Accept-Language: no, en
MIME-Version: 1.0
To: Mike Galbraith <efault@gmx.de>
CC: Bill Davidsen <davidsen@tmr.com>, linux-kernel@vger.kernel.org
Subject: Re: O(1) scheduler & interactivity improvements
References: <3EFAC408.4020106@aitel.hist.no> <5.2.0.9.2.20030627071904.00c890e0@pop.gmx.net> <5.2.0.9.2.20030627110106.00cf6068@pop.gmx.net>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Mike Galbraith wrote:
> At 10:18 AM 6/27/2003 +0200, Helge Hafting wrote:
> 
[...]

 > (simple?  decode stack, find out where he was sleeping,
Complicated indeed, but why do that?
A process sleeping on a pipe will wake up in the kernel's
pipe reading code, won't it?  No need for guessing where
it was sleeping.  Code for transferring interactivity
bonus could go right there.

> 
> What I think kills the priority redistribution idea is _massive_ 
> complexity.  I don't see anything simple.  You would have to build the 
> logical connections between tasks, which currently doesn't exist.  

I must admit I don't know the details of the scheduler.  Still, Linus
tried a form of redistribution (the backboost thing).  It helped in some 
cases.
It seems to me that it got revoked because it did the wrong
thing at times, leading to starvation issus that didn't exist before.
It didn't go because it was overly complex or slow?

Helge Hafting

> Wakeups and task switches are extremely light weight operations, and no 
> decision you make at wakeup time has a ghost of a chance of not hurting 
> like hell.  Just using the monotonic_clock() in the wakeup/schedule 
> paths is fairly painful.  There is just no way you can run around 
> looking for and processing "who shot JR" information in those paths (no 
> way _I_ can imagine anyway) without absolutely destroying performance.
> 

