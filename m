Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S285730AbSALLlp>; Sat, 12 Jan 2002 06:41:45 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S285747AbSALLlg>; Sat, 12 Jan 2002 06:41:36 -0500
Received: from AGrenoble-101-1-1-156.abo.wanadoo.fr ([193.251.23.156]:2432
	"EHLO strider.virtualdomain.net") by vger.kernel.org with ESMTP
	id <S285730AbSALLlW> convert rfc822-to-8bit; Sat, 12 Jan 2002 06:41:22 -0500
Message-ID: <3C402279.1000708@wanadoo.fr>
Date: Sat, 12 Jan 2002 12:48:09 +0100
From: =?ISO-8859-15?Q?Fran=E7ois?= Cami <stilgar2k@wanadoo.fr>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:0.9.6) Gecko/20011120
X-Accept-Language: en-us, fr
MIME-Version: 1.0
To: Robert Love <rml@tech9.net>
Cc: timothy.covell@ashavan.org, mingo@elte.hu,
        Mike Kravetz <kravetz@us.ibm.com>,
        Linus Torvalds <torvalds@transmeta.com>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        Anton Blanchard <anton@samba.org>, george anzinger <george@mvista.com>,
        Davide Libenzi <davidel@xmailserver.org>,
        Rusty Russell <rusty@rustcorp.com.au>
Subject: Re: [patch] O(1) scheduler, -G1, 2.5.2-pre10, 2.4.17 (fwd)
In-Reply-To: <Pine.LNX.4.33.0201110142160.12174-100000@localhost.localdomain>	<3C3F5C43.7060300@wanadoo.fr> 	<200201112150.g0BLoESr004177@svr3.applink.net> <1010814327.2018.5.camel@phantasy>
Content-Type: text/plain; charset=ISO-8859-15; format=flowed
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Robert Love wrote:

> On Fri, 2002-01-11 at 16:46, Timothy Covell wrote:
> 
>> But, given the above case, what happens when you have Sendmail on
>> the first CPU and Squid is sharing the second CPU?  This is not optimal
>> either, or am I missing something?
> 
> Correct.  I sort of took the "optimal cache use" comment as 
> tongue-in-cheek.  If I am mistaken, correct me, but here is my 
> perception of the scenario:
> 
> 2 CPUs, 3 tasks.  1 task receives 100% of the CPU time on one CPU.  The 
> remaining two tasks share the second CPU.  The result is, of three 
> evenly prioritized tasks, one receives double as much CPU time as the 
> others.


Yes, but that makes sense if the one that receives double as much
CPU time as the others _needs_ that CPU time. For example, an idle
MTA _should_ not receive as much CPU time as an overworked proxy
server... Yet, unless someone changes the priority, they are treated
evenly by the scheduler. This is not so good in my mind.


> Aside from the cache utilization, this is not really "fair" -- the 
> problem is, the current design of load_balance (which is quite good) 
> just won't throw the tasks around so readily.  What could be done -- 
> cleanly -- to make this better?
> 
> 	Robert Love


Is it possible for the scheduler to take into account another parameter
than priority to decide an app' CPU affinity ? For example, size
in memory and %CPU. For example, if an app accounts for
80% of the total CPU utilisation, by all means it should stay
on the same CPU. That, in my mind, would have the effect that this
app would run faster (because of the cache) AND that the load on
the machine would decrease (having to bump that app from one
CPU to another is _not_ good).

Is this feasible, or am I dreaming ?

François Cami


