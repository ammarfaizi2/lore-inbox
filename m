Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265525AbTFZKVW (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 26 Jun 2003 06:21:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265530AbTFZKVW
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 26 Jun 2003 06:21:22 -0400
Received: from mail.gmx.net ([213.165.64.20]:63665 "HELO mail.gmx.net")
	by vger.kernel.org with SMTP id S265525AbTFZKVV (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 26 Jun 2003 06:21:21 -0400
Message-Id: <5.2.0.9.2.20030626122539.00cea738@pop.gmx.net>
X-Mailer: QUALCOMM Windows Eudora Version 5.2.0.9
Date: Thu, 26 Jun 2003 12:39:54 +0200
To: Helge Hafting <helgehaf@aitel.hist.no>
From: Mike Galbraith <efault@gmx.de>
Subject: Re: O(1) scheduler & interactivity improvements
Cc: Bill Davidsen <davidsen@tmr.com>, linux-kernel@vger.kernel.org
In-Reply-To: <3EFAC408.4020106@aitel.hist.no>
References: <20030623164743.GB1184@hh.idb.hist.no>
 <5.2.0.9.2.20030624215008.00ce73b8@pop.gmx.net>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; format=flowed
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

At 11:59 AM 6/26/2003 +0200, Helge Hafting wrote:
>Mike Galbraith wrote:
>
>>ponders obnoxious ($&#!...;) irman process_load...
>>Too many random sleeper tasks steadily becoming runnable can DoS lower 
>>priority tasks accidentally, but the irman process_load kind of DoS seems 
>>to indicate a very heavy favoritism toward cooperating threads.
>>It seems to me that any thread group who's members sleep longer than they 
>>run, and always has one member runnable is absolutely guaranteed to cause 
>>terminal DoS.  Even if there isn't _always_ a member runnable, waking a 
>>friend and waiting for him to do something seems like a very likely thing 
>>for threaded process to do, which gives the threaded process a huge 
>>advantage because the cumulative sleep_avg pool will become large simply 
>>because it's members spend a lot of time jabbering back and forth.
>
>How about _removing_ the io-wait bonus for waiting on pipes then?

That's been done.

>If you wait for disk io, someone else gets to use
>the cpu for their work.  So you get a boost for
>giving up your share of time, waiting
>for that slow device.
>
>But if you wait for a pipe, you wait for some other
>cpu hog to do the first part of _your_ work.
>I.e. nobody else benefitted from your waiting,
>so you don't get any boost either.
>
>This solves the problem of someone artifically
>dividing up a job, using token passing
>to get unfair priority.

For pipes.

         -Mike 

