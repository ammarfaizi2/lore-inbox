Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S132037AbRDPTnG>; Mon, 16 Apr 2001 15:43:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131985AbRDPTmz>; Mon, 16 Apr 2001 15:42:55 -0400
Received: from m655-mp1-cvx1a.col.ntl.com ([213.104.70.143]:44185 "EHLO
	[213.104.70.143]") by vger.kernel.org with ESMTP id <S131983AbRDPTmj>;
	Mon, 16 Apr 2001 15:42:39 -0400
To: Andrew Morton <andrewm@uow.edu.au>
Cc: <linux-kernel@vger.kernel.org>
Subject: Re: [new PATCH] Re: 8139too: defunct threads
In-Reply-To: <Pine.LNX.4.33.0104150100210.13758-100000@dystopia.lab43.org>
	<3AD99CE4.E1ED7090@colorfullife.com> <3ADB2522.6A0C579C@uow.edu.au>
From: John Fremlin <chief@bandits.org>
Date: 16 Apr 2001 20:42:00 +0100
In-Reply-To: Andrew Morton's message of "Mon, 16 Apr 2001 10:00:18 -0700"
Message-ID: <m2u23ows1j.fsf@boreas.yi.org.>
User-Agent: Gnus/5.0807 (Gnus v5.8.7) XEmacs/21.1 (GTK)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

 Andrew Morton <andrewm@uow.edu.au> writes:

[...]

> None of these will work.  The problems with globally setting
> exit_signal to SIGCHLD are that
> 
> a) If the parent does waitpid(pid, status, __WCLONE), the
>    waitpid will fail.  request_module() does this.  I don't
>    know _why_ it does this.  Maybe it's bogus.  There is no
>    explanation.

waitpid doesn't work on cloned children unless you put in __WCLONE or
__WALL, so this was necessary to catch the child at all. If you set to
use SIGCHLD this will no longer be needed (if I understand correctly).

[...]

> So it seems that we must reparent the thread to init, and
> make sure that it delivers SIGCHLD to init when it exits.

Sounds good. Why isn't SIGCHLD a stronger default anyway.

[...]

> +	/* Set the exit signal to SIGCHLD so we signal init on exit */
> +	if (this_task->exit_signal ! 0) {

Tyop.

> +		printk(KERN_ERR "task `%s' exit_signal %d in daemonize()\n",
> +			this_task->comm, this_task->exit_signal);
> +	}
> +	this_task->exit_signal = SIGCHLD;
> +
> +	write_unlock_irq(&tasklist_lock);
>  }
>  
>  void __init init_idle(void)
> 

-- 

	http://www.penguinpowered.com/~vii
