Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261703AbVBHX6H@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261703AbVBHX6H (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 8 Feb 2005 18:58:07 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261704AbVBHX6G
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 8 Feb 2005 18:58:06 -0500
Received: from e1.ny.us.ibm.com ([32.97.182.141]:27520 "EHLO e1.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id S261703AbVBHX5u (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 8 Feb 2005 18:57:50 -0500
Message-ID: <42095222.5010700@watson.ibm.com>
Date: Tue, 08 Feb 2005 18:58:26 -0500
From: Shailabh Nagar <nagar@watson.ibm.com>
Reply-To: nagar@watson.ibm.com
User-Agent: Mozilla Thunderbird 0.8 (Windows/20040913)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Matthew Dobson <colpatch@us.ibm.com>
CC: Paul Jackson <pj@sgi.com>, dino@in.ibm.com, mbligh@aracnet.com,
       pwil3058@bigpond.net.au, frankeh@watson.ibm.com, dipankar@in.ibm.com,
       akpm@osdl.org, ckrm-tech@lists.sourceforge.net, efocht@hpce.nec.com,
       lse-tech@lists.sourceforge.net, hch@infradead.org, steiner@sgi.com,
       jbarnes@sgi.com, sylvain.jeaugey@bull.net, djh@sgi.com,
       linux-kernel@vger.kernel.org, Simon.Derr@bull.net, ak@suse.de,
       sivanich@sgi.com
Subject: Re: [Lse-tech] [PATCH] cpusets - big numa cpu and memory placement
References: <20041001164118.45b75e17.akpm@osdl.org>	<20041001230644.39b551af.pj@sgi.com>	<20041002145521.GA8868@in.ibm.com>	<415ED3E3.6050008@watson.ibm.com>	<415F37F9.6060002@bigpond.net.au>	<821020000.1096814205@[10.10.2.4]>	<20041003083936.7c844ec3.pj@sgi.com>	<834330000.1096847619@[10.10.2.4]>	<1097014749.4065.48.camel@arrakis>	<420800F5.9070504@us.ibm.com>	<20050208095440.GA3976@in.ibm.com>	<42090C42.7020700@us.ibm.com> <20050208124234.6aed9e28.pj@sgi.com> <420939B6.7010608@us.ibm.com>
In-Reply-To: <420939B6.7010608@us.ibm.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


>> As best as I can figure out, CKRM is a fair share scheduler with a
>> gussied up more modular architecture, so that the components to track
>> usage, control (throttle) tasks, and classify tasks are separate
>> plugins.  

 > I'm not an expert on CKRM, so I'll leave the refuting (or notrefuting)
 > of your claims as to CKRM's usefulness to someone with more background
 > and expertise on the subject.  Anyone want to pipe up and defend the
 > alleged "gussied up" fair-share scheduler?

Well, I'm not sure I want to minutely examine Paul's choice of words !
I would have thought that two OLS and one KS presentation would suffice 
to clarify what CKRM is and isn't but that doesn't seem to be the case 
:-) So here we go again

CKRM is both a resource management infrastructure AND
a set of controllers. The two are independent.

The infrastructure provides for
a) grouping of kernel objects (currently only tasks & sockets but can be 
extended to any others)
b) an external interface for manipulating attributes of the grouping 
such as shares, statistics and members
c) an internal interface for controllers to exploit this grouping 
information in whatever way it wants.

The controllers do whatever they want with the grouping info.
The IBM folks on the project have written ONE set of controllers for 
cpu, mem, io, net and numtasks which HAPPENS to be/aspire to be 
fair-share. Others are free to write ones which ignore share settings 
and be unfair, callous or whatever else they want.

We would love to have people write alternate controllers for the same 
resources (cpu,mem,io,net,numtasks) and others. The former will provide 
alternatives to our implementation, the latter will validate the 
architecture's utility.


>> I can find no significant and useful overlap on any of these
>> fronts, either the existing plugins or their infrastructure, with what
>> cpusets has and needs.
>> There are claims that CKRM has some generalized resource management
>> architecture that should be able to handle cpusets needs, but despite my
>> repeated (albeit not entirely successful) efforts to find documentation
>> and read source and my pleadings with Matthew and earlier on this
>> thread, I was never able to figure out what this meant, or find anything
>> that could profitably integrate with cpusets.

Rereading the earlier posts on the thread, I'd agree. There are some 
similarities in our interfaces but not enough to warrant a merger.


-- Shailabh
