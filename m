Return-Path: <linux-kernel-owner+willy=40w.ods.org-S270711AbUJUSMQ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S270711AbUJUSMQ (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 21 Oct 2004 14:12:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S270746AbUJUSHy
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 21 Oct 2004 14:07:54 -0400
Received: from RT-soft-2.Moscow.itn.ru ([80.240.96.70]:16278 "HELO
	mail.dev.rtsoft.ru") by vger.kernel.org with SMTP id S270778AbUJUSFW
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 21 Oct 2004 14:05:22 -0400
Message-ID: <4177FB89.8030708@ru.mvista.com>
Date: Thu, 21 Oct 2004 22:10:17 +0400
From: "Eugeny S. Mints" <emints@ru.mvista.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.2.1) Gecko/20030225
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Scott Wood <scott@timesys.com>
CC: john cooper <john.cooper@timesys.com>, Esben Nielsen <simlo@phys.au.dk>,
       Ingo Molnar <mingo@elte.hu>, Thomas Gleixner <tglx@linutronix.de>,
       Jens Axboe <axboe@suse.de>, Rui Nuno Capela <rncbc@rncbc.org>,
       LKML <linux-kernel@vger.kernel.org>, Lee Revell <rlrevell@joe-job.com>,
       mark_h_johnson@raytheon.com, "K.R. Foley" <kr@cybsft.com>,
       Bill Huey <bhuey@lnxw.com>, Adam Heath <doogie@debian.org>,
       Florian Schmidt <mista.tapas@gmx.net>,
       Michal Schmidt <xschmi00@stud.feec.vutbr.cz>,
       Fernando Pablo Lopez-Lezcano <nando@ccrma.stanford.edu>,
       "Ext-Rt-Dev@Mvista. Com" <ext-rt-dev@mvista.com>
Subject: Re: [patch] Real-Time Preemption, -RT-2.6.9-rc4-mm1-U8
References: <Pine.OSF.4.05.10410211601500.11909-100000@da410.ifa.au.dk> <4177CD3C.9020201@timesys.com> <4177DA11.4090902@ru.mvista.com> <4177E89A.1090100@timesys.com> <20041021173302.GA26318@yoda.timesys>
In-Reply-To: <20041021173302.GA26318@yoda.timesys>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Scott Wood wrote:
> On Thu, Oct 21, 2004 at 12:49:30PM -0400, john cooper wrote:
> 
>>It would seem a mutex ownership list still needs to be maintained.
>>Doing so in unordered priority will give a small fixed insertion
>>time, but will require an exhaustive search in order to calculate
>>maximum priority. Doing so in priority order will require an
>>average of #mutex_owned / 2 for the insertion, and gives a fixed
>>time for maximum priority calculation. The latter appears to offer
>>a performance benefit to the degree the incoming priorities are
>>random.
> 
> 
> If you keep it in priority order, then you're paying the O(n) cost
> every time you acquire a lock.  If you keep it unordered and only
> search it when you need to recalculate a task's priority after a lock
> has been released (or priorities have been changed), you pay the cost
> much less often.  Plus, the number of locks held by any given thread
> should generally be very small.
As to locks held by any given thread - it's not always true - take a 
look at mm/filemap.c locks nesting map in comments.

                        Eugeny



