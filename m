Return-Path: <linux-kernel-owner+w=401wt.eu-S932310AbWLQSXe@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932310AbWLQSXe (ORCPT <rfc822;w@1wt.eu>);
	Sun, 17 Dec 2006 13:23:34 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932308AbWLQSXe
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 17 Dec 2006 13:23:34 -0500
Received: from rgminet01.oracle.com ([148.87.113.118]:31942 "EHLO
	rgminet01.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932310AbWLQSXd (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 17 Dec 2006 13:23:33 -0500
Message-ID: <45858B3A.5050804@oracle.com>
Date: Sun, 17 Dec 2006 10:23:54 -0800
From: Randy Dunlap <randy.dunlap@oracle.com>
User-Agent: Thunderbird 1.5.0.5 (X11/20060719)
MIME-Version: 1.0
To: "J.H." <warthog9@kernel.org>
CC: Andrew Morton <akpm@osdl.org>, Pavel Machek <pavel@ucw.cz>,
       kernel list <linux-kernel@vger.kernel.org>, hpa@zytor.com,
       webmaster@kernel.org
Subject: Re: [KORG] Re: kernel.org lies about latest -mm kernel
References: <20061214223718.GA3816@elf.ucw.cz>	 <20061216094421.416a271e.randy.dunlap@oracle.com>	 <20061216095702.3e6f1d1f.akpm@osdl.org>  <458434B0.4090506@oracle.com> <1166297434.26330.34.camel@localhost.localdomain>
In-Reply-To: <1166297434.26330.34.camel@localhost.localdomain>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
X-Brightmail-Tracker: AAAAAQAAAAI=
X-Brightmail-Tracker: AAAAAQAAAAI=
X-Whitelist: TRUE
X-Whitelist: TRUE
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

J.H. wrote:
> The problem has been hashed over quite a bit recently, and I would be
> curious what you would consider the real problem after you see the
> situation.

OK, thanks for the summary.

> The root cause boils down to with git, gitweb and the normal mirroring
> on the frontend machines our basic working set no longer stays resident
> in memory, which is forcing more and more to actively go to disk causing
> a much higher I/O load.  You have the added problem that one of the
> frontend machines is getting hit harder than the other due to several
> factors: various DNS servers not round robining, people explicitly
> hitting [git|mirrors|www|etc]1 instead of 2 for whatever reason and
> probably several other factors we aren't aware of.  This has caused the
> average load on that machine to hover around 150-200 and if for whatever
> reason we have to take one of the machines down the load on the
> remaining machine will skyrocket to 2000+.  
> 
> Since it's apparent not everyone is aware of what we are doing, I'll
> mention briefly some of the bigger points.
> 
> - We have contacted HP to see if we can get additional hardware, mind
> you though this is a long term solution and will take time, but if our
> request is approved it will double the number of machines kernel.org
> runs.
> 
> - Gitweb is causing us no end of headache, there are (known to me
> anyway) two different things happening on that.  I am looking at Jeff
> Garzik's suggested caching mechanism as a temporary stop-gap, with an
> eye more on doing a rather heavy re-write of gitweb itself to include
> semi-intelligent caching.  I've already started in on the later - and I
> just about have the caching layer put in.  But this is still at least a
> week out before we could even remotely consider deploying it.
> 
> - We've cut back on the number of ftp and rsync users to the machines.
> Basically we are cutting back where we can in an attempt to keep the
> load from spiraling out of control, this helped a bit when we recently
> had to take one of the machines down and instead of loads spiking into
> the 2000+ range we peaked at about 500-600 I believe.
> 
> So we know the problem is there, and we are working on it - we are
> getting e-mails about it if not daily than every other day or so.  If
> there are suggestions we are willing to hear them - but the general
> feeling with the admins is that we are probably hitting the biggest
> problems already.

I have (or had) no insight into the problem analysis, just that there
is a big problem.  Fortunately you and others know that too and
are working on it.

You asked what I (or anyone) would consider the real problem.
I can't really say since I have no performance/profile data to base
it on.  There has been some noise about (not) providing mirror services
for distros.  Is that a big cpu/memory consumer?  If so, then is that
something that kernel.org could shed over some N (6 ?) months?
I understand not dropping it immediately, but it seems to be more of
a convenience rather than something related to kernel development.


> - John 'Warthog9' Hawley
> Kernel.org Admin
> 
> On Sat, 2006-12-16 at 10:02 -0800, Randy Dunlap wrote:
>> Andrew Morton wrote:
>>> On Sat, 16 Dec 2006 09:44:21 -0800
>>> Randy Dunlap <randy.dunlap@oracle.com> wrote:
>>>
>>>> On Thu, 14 Dec 2006 23:37:18 +0100 Pavel Machek wrote:
>>>>
>>>>> Hi!
>>>>>
>>>>> pavel@amd:/data/pavel$ finger @www.kernel.org
>>>>> [zeus-pub.kernel.org]
>>>>> ...
>>>>> The latest -mm patch to the stable Linux kernels is: 2.6.19-rc6-mm2
>>>>> pavel@amd:/data/pavel$ head /data/l/linux-mm/Makefile
>>>>> VERSION = 2
>>>>> PATCHLEVEL = 6
>>>>> SUBLEVEL = 19
>>>>> EXTRAVERSION = -mm1
>>>>> ...
>>>>> pavel@amd:/data/pavel$
>>>>>
>>>>> AFAICT 2.6.19-mm1 is newer than 2.6.19-rc6-mm2, but kernel.org does
>>>>> not understand that.
>>>> Still true (not listed) for 2.6.20-rc1-mm1  :(
>>>>
>>>> Could someone explain what the problem is and what it would
>>>> take to correct it?
>>> 2.6.20-rc1-mm1 still hasn't propagated out to the servers (it's been 36
>>> hours).  Presumably the front page non-update is a consequence of that.
>> Agreed on the latter part.  Can someone address the real problem???

-- 
~Randy
