Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S263435AbSJGVbT>; Mon, 7 Oct 2002 17:31:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S263434AbSJGVbS>; Mon, 7 Oct 2002 17:31:18 -0400
Received: from crack.them.org ([65.125.64.184]:33549 "EHLO crack.them.org")
	by vger.kernel.org with ESMTP id <S263435AbSJGVbI>;
	Mon, 7 Oct 2002 17:31:08 -0400
Date: Mon, 7 Oct 2002 17:37:26 -0400
From: Daniel Jacobowitz <dan@debian.org>
To: linux-kernel@vger.kernel.org
Subject: Re: Is this racy?
Message-ID: <20021007213726.GA6191@nevyn.them.org>
Mail-Followup-To: linux-kernel@vger.kernel.org
References: <20021007145152.A4065@mail.harddata.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20021007145152.A4065@mail.harddata.com>
User-Agent: Mutt/1.5.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Oct 07, 2002 at 02:51:52PM -0600, Michal Jaegermann wrote:
> In fs/proc/array.c (2.4.20-pre9, 2.4.19 and likely many other
> versions) in function 'proc_pid_stat()' there is a code like that:
> 
> 	......
> 	read_lock(&tasklist_lock);
> 	ppid = task->pid ? task->p_opptr->pid : 0;
> 	read_unlock(&tasklist_lock);
> 	res = sprintf(buffer,"<long format string>",
> 		task->pid,
> 		......
> 		ppid,
> 		......
> 
> So assignment to ppid is locked but other reads from fiels of 'task'
> structure are not guarded that way.  Is this ok or if not we do not
> particularly care?  Function 'task_state()' in the same file seems
> to be more careful about this.

I think the lock is just so that p_opptr->pid doesn't change while
we're looking at it.

-- 
Daniel Jacobowitz
MontaVista Software                         Debian GNU/Linux Developer
