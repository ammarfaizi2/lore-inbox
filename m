Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S264861AbRFTIpb>; Wed, 20 Jun 2001 04:45:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S264860AbRFTIpV>; Wed, 20 Jun 2001 04:45:21 -0400
Received: from ncc1701.cistron.net ([195.64.68.38]:4875 "EHLO
	ncc1701.cistron.net") by vger.kernel.org with ESMTP
	id <S264859AbRFTIpU>; Wed, 20 Jun 2001 04:45:20 -0400
From: miquels@cistron-office.nl (Miquel van Smoorenburg)
Subject: Re: Why can't I ptrace init (pid == 1) ?
Date: Wed, 20 Jun 2001 08:45:18 +0000 (UTC)
Organization: Cistron Internet Services B.V.
Message-ID: <9gpnqu$8lv$2@ncc1701.cistron.net>
In-Reply-To: <102490000.992966603@changeling.engr.sgi.com> <3B3060C0.B2D368C@idb.hist.no>
X-Trace: ncc1701.cistron.net 993026718 8895 195.64.65.67 (20 Jun 2001 08:45:18 GMT)
X-Complaints-To: abuse@cistron.nl
X-Newsreader: trn 4.0-test75 (Feb 13, 2001)
Originator: miquels@cistron-office.nl (Miquel van Smoorenburg)
To: linux-kernel@vger.kernel.org
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

In article <3B3060C0.B2D368C@idb.hist.no>,
Helge Hafting  <helgehaf@idb.hist.no> wrote:
>richard offer wrote:
>> 
>> In arch/i386/kernel/ptrace.c there is the following code ...
>> 
>>         ret = -EPERM;
>>         if (pid == 1)           /* you may not mess with init */
>>                 goto out_tsk;
>> 
>> What is the rationale for this ? Is this a real security decision or
>> an implementation detail (bad things will happen).
>
>I don't know why they did it, but ptracing init is definitely a added
>security risk.  If an intruder can't take over init, then a smart
>init can fight back.  Of course most inits aren't that smart, but
>at least they can log problems and such.  The intruder can't prevent
>that because init cannot be killed except by booting (which is
>noticeable),
>and it cannot be taken over with ptrace.  ptrace could otherwise
>be used to make init exec some other init that doesn't do the
>logging.  

You can exec another init anyway. Call 'telinit u' and init will
re-exec itself, so that's not tne reason.

The reason right now is I think that ptrace mucks around with
sibling relations and since init is a special 'father of all
processes' (or is that mother?) that would get the system into
trouble real soon.

Mike.

