Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261825AbTGOEh0 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 15 Jul 2003 00:37:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261874AbTGOEh0
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 15 Jul 2003 00:37:26 -0400
Received: from imap.gmx.net ([213.165.64.20]:58817 "HELO mail.gmx.net")
	by vger.kernel.org with SMTP id S261825AbTGOEhZ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 15 Jul 2003 00:37:25 -0400
Message-Id: <5.2.1.1.2.20030715054158.01b19b48@pop.gmx.net>
X-Mailer: QUALCOMM Windows Eudora Version 5.2.1
Date: Tue, 15 Jul 2003 06:56:33 +0200
To: Davide Libenzi <davidel@xmailserver.org>
From: Mike Galbraith <efault@gmx.de>
Subject: Re: [patch] SCHED_SOFTRR starve-free linux scheduling policy  
   ...
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
In-Reply-To: <Pine.LNX.4.55.0307141015010.4828@bigblue.dev.mcafeelabs.co
 m>
References: <5.2.1.1.2.20030714174719.01bce3f8@pop.gmx.net>
 <5.2.1.1.2.20030714100438.01be5008@pop.gmx.net>
 <5.2.1.1.2.20030714063443.01bcc5f0@pop.gmx.net>
 <5.2.1.1.2.20030714063443.01bcc5f0@pop.gmx.net>
 <5.2.1.1.2.20030714100438.01be5008@pop.gmx.net>
 <5.2.1.1.2.20030714174719.01bce3f8@pop.gmx.net>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; format=flowed
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

At 10:22 AM 7/14/2003 -0700, Davide Libenzi wrote:
>On Mon, 14 Jul 2003, Mike Galbraith wrote:
>
> > Yes, and it worked fine.  No cpu load I tossed at it caused a skip.
>
>I tried yesterday a thud.c load and it did not get a single skip here
>either. It is interesting what thud.c can do to latency (let's not talk
>about irman because things get really nasty). With a simple `thud 5` the
>latency rised to more then one full second, as you can see by the graphs
>inside the SOFTRR page. No buffer size can cope with that.

Yes, thud is well named.  It's easy to kill, but not so easy to kill 
without hurting important dynamic response characteristics and/or 
interactivity.

For sound purposes, all you have to do is make damn sure that thud/others 
can't get to the queue where your sound client lives.  I'm using a very 
short term weighted slice_avg for that... your %cpu is calculated for each 
slice, and once you approach interactive status, it doubles for each 
priority you climb.  That makes it very hard indeed for a cpu hog to ever 
reach the top.  Almost nothing can touch xmms here.  It doesn't provide the 
nearly 100% guarantee that SOFT_RR does, but otoh, it's absolutely 
impossible to abuse.

(my best interactive effort combined that with non-linear decay, and 
throttled backboost to offset the fairness pain that X any friends feel... 
it's quite good, but [butt ugly and:] not quite good enough)

         -Mike 

