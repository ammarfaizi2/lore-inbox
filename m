Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262153AbTCMEQ3>; Wed, 12 Mar 2003 23:16:29 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262158AbTCMEQ3>; Wed, 12 Mar 2003 23:16:29 -0500
Received: from mail.gmx.net ([213.165.64.20]:40003 "HELO mail.gmx.net")
	by vger.kernel.org with SMTP id <S262153AbTCMEQ1>;
	Wed, 12 Mar 2003 23:16:27 -0500
Message-Id: <5.2.0.9.2.20030313051931.00c94ef8@pop.gmx.net>
X-Mailer: QUALCOMM Windows Eudora Version 5.2.0.9
Date: Thu, 13 Mar 2003 05:31:45 +0100
To: Con Kolivas <kernel@kolivas.org>
From: Mike Galbraith <efault@gmx.de>
Subject: Re: 2.5.64-mm2->4 hangs on contest
Cc: linux kernel mailing list <linux-kernel@vger.kernel.org>,
       Andrew Morton <akpm@digeo.com>
In-Reply-To: <5.2.0.9.2.20030313042854.00c56550@pop.gmx.net>
References: <200303131222.12588.kernel@kolivas.org>
 <5.2.0.9.2.20030312132025.00c97520@pop.gmx.net>
 <5.2.0.9.2.20030312113354.00c8dcc0@pop.gmx.net>
 <5.2.0.9.2.20030312132025.00c97520@pop.gmx.net>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; format=flowed
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

At 04:39 AM 3/13/2003 +0100, Mike Galbraith wrote:
>At 12:22 PM 3/13/2003 +1100, Con Kolivas wrote:
>>On Wed, 12 Mar 2003 23:30, Mike Galbraith wrote:
>> > At 10:19 PM 3/12/2003 +1100, Con Kolivas wrote:
>> > >On Wed, 12 Mar 2003 21:37, Mike Galbraith wrote:
>> > > > >Is this in addition to your previous errr hack or instead of?
>> > > >
>> > > > Instead of.  The buttugly patch destroyed interactivity.  This one
>> > > > cures starvation, and interactivity is really nice.
>> > >
>> > >Ok that fixes the "getting stuck in process load" but it still hangs on
>> > >contest. I'll just have to give mm5 a go and see if whatever problem that
>> > > was went away in the mean time.
>> >
>> > (%$&#!!)
>>
>>No need to curse. Turns out this is an unrelated bug with the anticipatory
>>scheduler which akpm is onto. Your fix worked fine for the scheduler based
>>hang.
>
>Nope (drat), not quite.  I fixed the parse Mem: booboo, and see occasional 
>hangs doing complete irman test runs.  The process load works fine, but 
>the other two loads will hang once in a while.

Well shoot, that was easy to "fix".  If you want to give it a try, set the 
#if 0 to #if 1.  Instead of _moving_ the decay to prevent high switch rate 
tasks from getting too much boost, you need to add it instead.  This may 
not be the right fix, but it works for me.  X still retains it's boost just 
fine.

         -Mike 

