Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S312711AbSDAX0X>; Mon, 1 Apr 2002 18:26:23 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S312713AbSDAX0N>; Mon, 1 Apr 2002 18:26:13 -0500
Received: from e31.co.us.ibm.com ([32.97.110.129]:34475 "EHLO
	e31.esmtp.ibm.com.") by vger.kernel.org with ESMTP
	id <S312711AbSDAX0H>; Mon, 1 Apr 2002 18:26:07 -0500
Date: Mon, 1 Apr 2002 15:25:45 -0800
From: Mike Kravetz <kravetz@us.ibm.com>
To: Chris Friesen <cfriesen@nortelnetworks.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Question about scheduler changes from 2.2 to 2.4
Message-ID: <20020401152545.A3288@w-mikek2.des.beaverton.ibm.com>
In-Reply-To: <3CA8E8D5.B8B648ED@nortelnetworks.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Apr 01, 2002 at 06:10:13PM -0500, Chris Friesen wrote:
> 
> In the 2.2 scheduler there was a section that checked if the previous process
> was still runnable and set it as the default next running process.  It looked
> like this:
> 
> 	if (prev->state == TASK_RUNNING)
> 	   goto still_running;
> still_running_back:
> 
> With another chunk of code under still_running that set "c" and "next".
> 
> In 2.4 this seems to have been removed.  Can someone explain why?  I'm porting
> some custom scheduler changes and want to make sure that I understand what's
> going on in 2.4.

In 2.2 and early 2.4 versions of the scheduler, the 'can_schedule'
macro rejected tasks that had the 'has_cpu' field set.  The logic
has been changed so that 'can_schedule' will return true for the
task which is still running on the current CPU.  Therefore, the
scan of all tasks on the runqueue will recognize/include the currently
running task.  This eliminates the need for the special 'still_running'
check noted above.

The logic should be the same as before.  The only difference would
be in the case where a task with identical goodness was found on the
runqueue before the current task.  In this case we would run the other
task instead of continuing with the current task.  In practice, this
doesn't happen enough to justify the special check.

-- 
Mike
