Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261875AbUEEASo@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261875AbUEEASo (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 4 May 2004 20:18:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261867AbUEEASo
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 4 May 2004 20:18:44 -0400
Received: from mtagate2.uk.ibm.com ([195.212.29.135]:24245 "EHLO
	mtagate2.uk.ibm.com") by vger.kernel.org with ESMTP id S261830AbUEEASj
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 4 May 2004 20:18:39 -0400
Message-ID: <409832D2.2020507@watson.ibm.com>
Date: Tue, 04 May 2004 20:18:26 -0400
From: Shailabh Nagar <nagar@watson.ibm.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.6b) Gecko/20031205 Thunderbird/0.4
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Marcelo Tosatti <marcelo.tosatti@cyclades.com>
CC: linux-kernel <linux-kernel@vger.kernel.org>,
       ckrm-tech <ckrm-tech@lists.sourceforge.net>
Subject: Re: [ckrm-tech] Re: [RFC] Revised CKRM release
References: <4090BBF1.6080801@watson.ibm.com> <20040504173529.GE11346@logos.cnet>
In-Reply-To: <20040504173529.GE11346@logos.cnet>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Marcelo Tosatti wrote:
> On Thu, Apr 29, 2004 at 04:25:21AM -0400, Shailabh Nagar wrote:
> 
>>The Class-based Resource Management project is happy to release the
>>first bits of a working prototype following a major revision of its
>>interface and internal organization.
>>
>>The basic concepts and motivation of CKRM remain the same as described
>>in the overview at http://ckrm.sf.net. Privileged users can define
>>classes consisting of groups of kernel objects (currently tasks and
>>sockets) and specify shares for these classes. Resource controllers,
>>which are independent of each other, can regulate and monitor the
>>resources consumed by classes e.g the CPU controller will control the
>>CPU time received by a class etc. Optional classification engines,
>>implemented as kernel modules, can assist in the automatic
>>classification of the kernel objects (tasks/sockets currently) into
>>classes.
> 
> 
> Cool!
> 
> 
>>New in this release are the following:
>>
>>rbce.ckrm-E12:
>>
>>Two classification engines (CE) to assist in automatic classification
>>of tasks and sockets. The first one, rbce, implements a rule-based
>>classification engine which is generic enough for most users. The
>>second, called crbce, is a variant of rbce which additionally provides
>>information on significant kernel events (where a task/socket could
>>get reclassified) to userspace as well as reports per-process wait
>>times for cpu, memory, io etc. Such information can be used by user
>>level tools to reclassify tasks to new classes, change class shares
>>etc.
> 
> 
> It sounds to me the classification engine can be moved to userspace? 
> 
> Such "classification" sounds a better suited to be done there.

I suppose it could. However, one of our design objectives was to 
support multi-threaded server apps where each thread (task) changes 
its class fairly rapidly (say every time it starts doing work on 
behalf of a more/less important transaction). Doing a transition to 
userspace and back may be too costly for such a scenario.

There might also be some concerns with keeping the reclassify 
operation atomic wrt deletion of the target class...but we haven't 
thought this through for userspace classification.



> 
> Note: I haven't read the code yet.
>

Why just read when you can test as well :-) We just released a testing 
tarball at http://ckrm.sf.net.. any inputs, bugs will be most welcome !



Looking forward to more inputs,
-- Shailabh
