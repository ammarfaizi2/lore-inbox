Return-Path: <linux-kernel-owner+w=401wt.eu-S964900AbWLTGF5@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964900AbWLTGF5 (ORCPT <rfc822;w@1wt.eu>);
	Wed, 20 Dec 2006 01:05:57 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964902AbWLTGF4
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 20 Dec 2006 01:05:56 -0500
Received: from ug-out-1314.google.com ([66.249.92.172]:7081 "EHLO
	ug-out-1314.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S964900AbWLTGFz (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 20 Dec 2006 01:05:55 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=c+3/6xtmY1oQZNT4ft2WXbR1KGgBmeL5PJO/PJVXUq6GZGffZyHmi+gFTdy9npd1rTgkGJ8Oda3qTUIC/+fB4nuoqe40RB7Zrag0sjyEzU8ZM2GA2a9IHN+6ZOtTiLUCpTq40XG80dUI7eVosjyjKOz9NrkhoDP73S7BFxrgNa8=
Message-ID: <787b0d920612192205v2d650361r4f737c41aa1d3a92@mail.gmail.com>
Date: Wed, 20 Dec 2006 01:05:54 -0500
From: "Albert Cahalan" <acahalan@gmail.com>
To: "Mike Galbraith" <efault@gmx.de>
Subject: Re: BUG: wedged processes, test program supplied
Cc: linux-kernel <linux-kernel@vger.kernel.org>
In-Reply-To: <1166593200.1614.8.camel@Homer.simpson.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
References: <787b0d920612191846t5a51a2e4ld4101b26ca7a8413@mail.gmail.com>
	 <1166593200.1614.8.camel@Homer.simpson.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 12/20/06, Mike Galbraith <efault@gmx.de> wrote:
> On Tue, 2006-12-19 at 21:46 -0500, Albert Cahalan wrote:
> > Somebody PLEASE try this...
>
> I was having enough fun with cloninator (which was whitespace munged
> btw).

Anything stuck? Besides refusing to die, that beast slays debuggers
left and right. I just need to add execve of /proc/self/exe and a massive
storm of signals on the alternate stack.

In the original post, I also mangled the recommended ps command:
ps -Ccloninator
-mwostat,ppid,pid,tid,nlwp,pending,sigmask,sigignore,caught,wchan

Leave out pid,tid,nlwp if you need to save screen space, like so:
ps -Ccloninator -mwostat,ppid,pending,sigmask,sigignore,caught,wchan

(note: procps versions prior to 3.2.7 are mostly fine, but will mess
up the PENDING column for any single-threaded processes you get)

This is fun to look at:
watch ps -Ccloninator fostat,ppid,wchan:9,comm

> > Normally, when a process dies it becomes a zombie.
> > If the parent dies (before or after the child), the child
> > is adopted by init. Init will reap the child.
> >
> > The program included below DOES NOT get reaped.
>
> While true wasn't a great test recommendation :)

Oh. I wanted to be sure you'd see the problem. Did you have
some... difficulty? A plain old ^C should make things stop.
The second test program is like the first, but missing SIGCHLD
from the clone flags, and hopefully not whitespace-mangled.

Note that the test program is not normally a fork bomb.
It self-limits itself to 42 tasks via a lock in shared memory.
If things are working OK, you should see no more than
about 60 tasks.
