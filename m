Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S316971AbSGSVHr>; Fri, 19 Jul 2002 17:07:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317030AbSGSVHr>; Fri, 19 Jul 2002 17:07:47 -0400
Received: from w089.z209220022.nyc-ny.dsl.cnc.net ([209.220.22.89]:50824 "HELO
	yucs.org") by vger.kernel.org with SMTP id <S316971AbSGSVHq>;
	Fri, 19 Jul 2002 17:07:46 -0400
Subject: Re: more thoughts on a new jail() system call
From: Shaya Potter <spotter@cs.columbia.edu>
To: "Albert D. Cahalan" <acahalan@cs.uml.edu>
Cc: David Wagner <daw@mozart.cs.berkeley.edu>, linux-kernel@vger.kernel.org
In-Reply-To: <200207190306.g6J366956014@saturn.cs.uml.edu>
References: <200207190306.g6J366956014@saturn.cs.uml.edu>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Ximian Evolution 1.0.7 
Date: 19 Jul 2002 17:10:15 -0400
Message-Id: <1027113048.2634.62.camel@zaphod>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2002-07-18 at 23:06, Albert D. Cahalan wrote:
> >> sys_vhangup) NOT SURE -  Should be fine, right?
> >
> > Seems ok to me.
> 
> Have fun with devpts.

can you expand on why this might be a problem, as far I can tell the
syscall is in fs/open.c

it seems very simple to me

asmlinkage long sys_vhangup(void)
{
        if (capable(CAP_SYS_TTY_CONFIG)) {
                tty_vhangup(current->tty);
                return 0;
        }
        return -EPERM;
}

basically, we call tty_vhangup on the process's tty.

if tty_vhangup was the syscall, I could see this being a problem, but as
sys_vhangup can only operate on the what the task_struct has, how is it
a problem?

thanks,

shaya potter

