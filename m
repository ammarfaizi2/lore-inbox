Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263556AbUDFA26 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 5 Apr 2004 20:28:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263557AbUDFA26
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 5 Apr 2004 20:28:58 -0400
Received: from smtp103.mail.sc5.yahoo.com ([66.163.169.222]:22910 "HELO
	smtp103.mail.sc5.yahoo.com") by vger.kernel.org with SMTP
	id S263556AbUDFA25 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 5 Apr 2004 20:28:57 -0400
Message-ID: <4071F9C5.2030002@yahoo.com.au>
Date: Tue, 06 Apr 2004 10:28:53 +1000
From: Nick Piggin <nickpiggin@yahoo.com.au>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.6) Gecko/20040122 Debian/1.6-1
X-Accept-Language: en
MIME-Version: 1.0
To: vatsa@in.ibm.com
CC: rusty@au1.ibm.com, mingo@elte.hu, akpm@osdl.org,
       linux-kernel@vger.kernel.org, lhcs-devel@lists.sourceforge.net
Subject: Re: [Experimental CPU Hotplug PATCH] - Move migrate_all_tasks to
 CPU_DEAD handling
References: <20040405121824.GA8497@in.ibm.com>
In-Reply-To: <20040405121824.GA8497@in.ibm.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Srivatsa Vaddagiri wrote:
> Hi Rusty,
> 	migrate_all_tasks is currently run with rest of the machine stopped.
> It iterates thr' the complete task table, turning off cpu affinity of any task 
> that it finds affine to the dying cpu. Depending on the task table 
> size this can take considerable time. All this time machine is stopped, doing
> nothing.
> 
> I think Nick was working on reducing this time spent in migrating tasks
> by concentrating only on the tasks in the runqueue and catch up with sleeping
> tasks as and when they wake up (in try_to_wake_up). But this still can be 
> considerable time spent depending on the number of tasks in the dying CPU's 
> runqueue.

Hi Srivatsa,
First of all, if you're proposing this stuff for inclusion, you
should port it to the -mm tree, because I don't think Andrew
will want any other scheduler work going in just now. It wouldn't
be too hard.

I think my stuff is a bit orthogonal to what you're attempting.
And they should probably work well together. My "lazy migrate"
patch means the tasklist lock does not need to be held at all,
only the dying runqueue's lock.

