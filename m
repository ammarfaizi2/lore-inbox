Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S289117AbSBJBA0>; Sat, 9 Feb 2002 20:00:26 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S289115AbSBJBAJ>; Sat, 9 Feb 2002 20:00:09 -0500
Received: from pfaff.Stanford.EDU ([128.12.189.154]:22921 "EHLO pfaff")
	by vger.kernel.org with ESMTP id <S289061AbSBJA7x>;
	Sat, 9 Feb 2002 19:59:53 -0500
To: linux-kernel@vger.kernel.org
Subject: Re: ssh primer (was Re: pull vs push (was Re: [bk patch] Make cardbus  compile in -pre4))
In-Reply-To: <E16ZhzF-0000ST-00@gondolin.me.apana.org.au>
	<3C65C4C5.C287A3@mandrakesoft.com>
Reply-To: blp@cs.stanford.edu
From: Ben Pfaff <blp@cs.stanford.edu>
Date: 09 Feb 2002 16:59:46 -0800
In-Reply-To: <3C65C4C5.C287A3@mandrakesoft.com>
Message-ID: <873d0acfst.fsf@pfaff.stanford.edu>
User-Agent: Gnus/5.09 (Gnus v5.9.0) Emacs/21.1
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Jeff Garzik <jgarzik@mandrakesoft.com> writes:

> For those with multiple peer shells and no X-parented ssh-agent, you
> will need to run ssh-agent ONCE, like so:
> 
> 	ssh-agent > ~/tmp/ssh-agent.out
> 
> and then for each shell, you need to run:
> 
> 	eval `cat ~/tmp/ssh-agent.out`
> 
> and then run the ssh-add command from above.

I keep the following in my .bashrc and use the `agent' command to
initialize the ssh-agent.

# Allow `agent' to start the ssh-agent usefully on all running
# bash instances.  SIGQUIT was chosen because it is ignored by
# bash by default, even in non-interactive shells, so that a
# shell not trapping it by some chance won't be terminated.
if test -f ~/.ssh/agent; then 
    . ~/.ssh/agent
fi
function agent {
    killall -q ssh-agent
    ssh-agent > ~/.ssh/agent
    killall -QUIT bash >/dev/null 2>&1
    ssh-add ~/.ssh/identity
    ssh-add ~/.ssh/id_dsa
}
trap -- '. ~/.ssh/agent' SIGQUIT

-- 
"Be circumspect in your liaisons with women.
 It is better to be seen at the opera with a man
 than at mass with a woman."
--De Maintenon
