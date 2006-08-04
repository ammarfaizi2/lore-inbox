Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1161216AbWHDOTg@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161216AbWHDOTg (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 4 Aug 2006 10:19:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161218AbWHDOTf
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 4 Aug 2006 10:19:35 -0400
Received: from mailhub.sw.ru ([195.214.233.200]:57399 "EHLO relay.sw.ru")
	by vger.kernel.org with ESMTP id S1161216AbWHDOTf (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 4 Aug 2006 10:19:35 -0400
Message-ID: <44D35794.2040003@sw.ru>
Date: Fri, 04 Aug 2006 18:20:04 +0400
From: Kirill Korotaev <dev@sw.ru>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.13) Gecko/20060417
X-Accept-Language: en-us, en, ru
MIME-Version: 1.0
To: Andrew Morton <akpm@osdl.org>
CC: vatsa@in.ibm.com, mingo@elte.hu, nickpiggin@yahoo.com.au, sam@vilain.net,
       linux-kernel@vger.kernel.org, dev@openvz.org, efault@gmx.de,
       balbir@in.ibm.com, sekharan@us.ibm.com, nagar@watson.ibm.com,
       haveblue@us.ibm.com, pj@sgi.com
Subject: Re: [RFC, PATCH 0/5] Going forward with Resource Management - A cpu
 controller
References: <20060804050753.GD27194@in.ibm.com> <20060803223650.423f2e6a.akpm@osdl.org>
In-Reply-To: <20060803223650.423f2e6a.akpm@osdl.org>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andrew,

> ug, I didn't know this.  Had I been there (sorry) I'd have disagreed with
> this whole strategy.
I wish you were here :/

> I thought the most recently posted CKRM core was a fine piece of code.  It
> provides the machinery for grouping tasks together and the machinery for
> establishing and viewing those groupings via configfs, and other such
> common functionality.  My 20-minute impression was that this code was an
> easy merge and it was just awaiting some useful controllers to come along.
the same thing does User BeanCounter patch.
The infrastructure is totally a separate question.
Moreover, as CKRM/UBC experience shows it is the most easiest code to agree on.
And as people agreed we need to speak about serious problems first,
not the interface one (at least, not at the moment when we have no working
resource controllers).

> And now we've dumped the good infrastructure and instead we've contentrated
> on the controller, wired up via some imaginative ab^H^Hreuse of the cpuset
> layer.
exactly. We have no workable controller.
So if there is no code we agreed on, whom is this infrastructure for?

> I wonder how many of the consensus-makers were familiar with the
> contemporary CKRM core?
I was familiar. And I can arise many arguable points in the CKRM infrastructure.

For example:
1. Should task-group be changeable after set/inherited once?
  Are you planning to recalculate resources on group change?
  e.g. shared memory or used kernel memory is hard to recalculate.
2. should task-group resource container manage all the resources as a whole?
  e.g. in OpenVZ tasks can belong to different CPU and UBC containers.
  It is more flexible and e.g. we used to put some vital kernel threads
  to a separate CPU group to decrease delays in service.
3. I also don't understand why normal binary interface like system call is not used.
   We have set_uid, sys_setrlimit and it works pretty good, does it?
4. do we want hierarchical grouping?

>>	- Design of individual resource controllers like memory and cpu
> 
> 
> Right.  We won't be controlling memory, numtasks, disk, network etc
> controllers via cpusets, will we?
I hope so :)

Thanks,
Kirill

