Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S131205AbRDKEkA>; Wed, 11 Apr 2001 00:40:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131219AbRDKEju>; Wed, 11 Apr 2001 00:39:50 -0400
Received: from [202.54.26.202] ([202.54.26.202]:30095 "EHLO hindon.hss.co.in")
	by vger.kernel.org with ESMTP id <S131205AbRDKEji>;
	Wed, 11 Apr 2001 00:39:38 -0400
X-Lotus-FromDomain: HSS
From: alad@hss.hns.com
To: Kurt Roeckx <Q@ping.be>
cc: Miquel van Smoorenburg <miquels@cistron-office.nl>,
        linux-kernel@vger.kernel.org
Message-ID: <65256A2B.001839FC.00@sandesh.hss.hns.com>
Date: Wed, 11 Apr 2001 10:01:49 +0530
Subject: Re: Let init know user wants to shutdown
Mime-Version: 1.0
Content-type: text/plain; charset=us-ascii
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org








Kurt Roeckx <Q@ping.be> on 04/11/2001 06:16:52 AM

To:   Miquel van Smoorenburg <miquels@cistron-office.nl>
cc:   linux-kernel@vger.kernel.org (bcc: Amol Lad/HSS)

Subject:  Re: Let init know user wants to shutdown




On Wed, Apr 11, 2001 at 01:38:30AM +0200, Kurt Roeckx wrote:
> On Tue, Apr 10, 2001 at 11:20:24PM +0000, Miquel van Smoorenburg wrote:
> >
> > the shutdown scripts
> > include "kill -15 -1; sleep 2; kill -9 -1". The "-1" means
> > "all processes except me". That means init will get hit with
> > SIGTERM occasionally during shutdown, and that might cause
> > weird things to happen.
>
> -1 mean everything but init.

>>> well. don't fight.. here is something from kernel/signal.c

asmlinkage int sys_kill(int pid, int sig){
...
...
return kill_something_info(sig,&info,pid)
}


int
kill_something_info(int sig, struct siginfo *info, int pid){
...
...
...
     if (pid == -1){
          for_each_task(p){(int
               if (p->pid >1 && p != current){
                    err = send_sig_info(sig,info,p);
                    ...
                    ...
               }
          }
     }

Amol


Oh, maybe you mean killall5 -TERM?

Which would send a SIGTERM to all processes but the one in his
own session.

(Hey look, you wrote that manpage.)


Kurt

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
Please read the FAQ at  http://www.tux.org/lkml/




