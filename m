Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267595AbUJBXPs@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267595AbUJBXPs (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 2 Oct 2004 19:15:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267601AbUJBXPr
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 2 Oct 2004 19:15:47 -0400
Received: from e1.ny.us.ibm.com ([32.97.182.101]:24212 "EHLO e1.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id S267595AbUJBXPo (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 2 Oct 2004 19:15:44 -0400
Message-ID: <415F34FF.8040806@watson.ibm.com>
Date: Sat, 02 Oct 2004 19:08:47 -0400
From: Hubertus Franke <frankeh@watson.ibm.com>
User-Agent: Mozilla/5.0 (Windows; U; Windows NT 5.1; en-US; rv:1.5b) Gecko/20030901 Thunderbird/0.2
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Andrew Morton <akpm@osdl.org>
CC: mef@CS.Princeton.EDU, nagar@watson.ibm.com,
       ckrm-tech@lists.sourceforge.net, pj@sgi.com, efocht@hpce.nec.com,
       mbligh@aracnet.com, lse-tech@lists.sourceforge.net, hch@infradead.org,
       steiner@sgi.com, jbarnes@sgi.com, sylvain.jeaugey@bull.net, djh@sgi.com,
       linux-kernel@vger.kernel.org, colpatch@us.ibm.com, Simon.Derr@bull.net,
       ak@suse.de, sivanich@sgi.com, llp@CS.Princeton.EDU
Subject: Re: [ckrm-tech] Re: [Lse-tech] [PATCH] cpusets - big numa cpu and
 memory placement
References: <NIBBJLJFDHPDIBEEKKLPCEFLCHAA.mef@cs.princeton.edu>	<415ED4A4.1090001@watson.ibm.com> <20041002134059.65b45e29.akpm@osdl.org>
In-Reply-To: <20041002134059.65b45e29.akpm@osdl.org>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



Andrew Morton wrote:
> Hubertus Franke <frankeh@watson.ibm.com> wrote:
> 
>>Marc, cpusets lead to physical isolation.
> 
> 
> Despite what Paul says, his customers *do not* "require" physical isolation
> [*].  That's like an accountant requiring that his spreadsheet be written
> in Pascal.  He needs slapping.
> 
> Isolation is merely the means by which cpusets implements some higher-level
> customer requirement.
> 
> I want to see a clearer description of what that higher-level requirement is.
> 
> Then I'd like to see some thought put into whether CKRM (with probably a new
> controller) can provide a good-enough implementation of that requirement.
> 

CKRM could do so. We already provide the name space and the class 
hierarchy. If a cpuset is associated with a class, then the class 
controller can sets the appropriate masks in the system.

The issue that Paul correctly pointed out is that if you associate the 
current task classes, i.e. set cpu and i/o shares then one MIGHT have 
conflicting directives to the system.
This can be avoided by not utilizing cpu shares at that point or live
with the potential share inbalance that will arrive from being forced 
into the various affinity constraints of the tasks.
But we already have to live with that anyway when resources create 
dependencies, such as to little memory can potentially impact obtained 
cpu share.

Alternatively, cpumem set could be introduced as a whole new classtype
that similar to the socket class type will have this one controller 
associated.

So to me cpumem sets as as concept is useful, so I won't be doing that 
whopping, but it can be integrated into CKRM as classtype/controller 
concept. Particularly for NUMA machine it makes sense in the absense of 
more sophisticated and (sub)optimal placement by the OS.

> Coming at this from the other direction: CKRM is being positioned as a
> general purpose resource management framework, yes?  Isolation is a simple
> form of resource management.  If the CKRM framework simply cannot provide
> this form of isolation then it just failed its first test, did it not?
> 

That's fair to say, I think it is feasible, by utilizing the guts of the 
cpumem set and wrapping the CKRM RCFS and class objects around it.

> [*] Except for the case where there is graphics (or other) hardware close
> to a particular node.  In that case it is obvious that CPU-group pinning is
> the only way in which to satisfy the top-level requirement of "make access
> to the graphics hardware be efficient".

Yipp ...  but it is also useful if one has limited faith in the system 
to always the right thing. If I have no control over where tasks go, I 
can potentially end up introducing heavy bus traffic (over NUMA link).
There's a good reason why in many HPC deployment, application try to by 
pass the OS ...

Hope this helps.


