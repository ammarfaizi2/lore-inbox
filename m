Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262728AbTDRAPp (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 17 Apr 2003 20:15:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262706AbTDRAPn
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 17 Apr 2003 20:15:43 -0400
Received: from gateway-1237.mvista.com ([12.44.186.158]:15357 "EHLO
	av.mvista.com") by vger.kernel.org with ESMTP id S262726AbTDRAPe
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 17 Apr 2003 20:15:34 -0400
Message-ID: <3E9F464C.4050004@mvista.com>
Date: Thu, 17 Apr 2003 17:26:52 -0700
From: george anzinger <george@mvista.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.2) Gecko/20021202
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: "Mathur, Shobhit" <Shobhit_mathur@adaptec.com>
CC: linux-c-programming@vger.kernel.org, linux-serial@vger.kernel.org,
       linux-newbie@vger.kernel.org, linux-kernel@vger.kernel.org,
       linux-doc@vger.kernel.org
Subject: Re: linux-source debugging with kgdb-patch
References: <3E9EC548.117005DD@adaptec.com>
In-Reply-To: <3E9EC548.117005DD@adaptec.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Mathur, Shobhit wrote:
> 
> 
> Hello,
> 
> BACKGROUND:
> 
> I was keen to see kgdb running  for  purely academic reasons. Thus,
> I made a setup of 2 machines for source-level debugging of the
> linux-kernel. The procedure mentioned on the web-site
> [ kgdb.sourceforge.net] has  been adhered to.  I was able to
> successfully configure the setup. Also, I decided to use "ddd" front-end
> on gdb [local m/c]  for debugging  the kgdb-patched kernel on the remote
> machine, which is the usual setup for such debugging-efforts.
>     The m/c to be debugged stops with the message "Waiting for
> connection from remote gdb..." until the "target remote" command is run
> from the "gdb" prompt of "ddd", upon which the m/c to be debugged
> continues it's bootup till it shows the command-prompt.
> 
> PROBLEM:
> 
> I was interested in setting a break-point in start_kernel thru' "ddd"
> such that the boot-up  of the m/c to be debugged could be analysed
> step-by-step remotely. Though, I am able to set the breakpoint in
> start_kernel(),
> the commands "run" or "continue" on the "gdb" prompt, only throw up the
> following errors :
> 
> (gdb) info break
> Num Type           Disp Enb Address    What
> 7   breakpoint      keep  y   0xc027e7f0 in start_kernel at
> init/main.c:614
> (gdb) run

The "run" command should not be used.  Kgdb/gdb debugging of the 
kernel is more like attaching to a running program than running it. 
When you use the run command you are telling gdb to, among other 
things, transfer conrol to the beginning of the program, which in the 
case of the kernel, is where the boot loader jumps on boot.  In the 
kernel this code in is memory that is released to free memory on the 
way up.

If you make this mistake often I recommend the following gdb macro:

define hook-run
echo "run is not available for kernel debugging \n"
p .
end

The "p ." will error out the command and snach you from the jaws of 
reboot/ fsck :)

This macro should be in .gdbinit file in the same directory as the 
vmlinux file.


> warning: shared library handler failed to enable breakpoint
> warning: Cannot insert breakpoint 7:
> Cannot access memory at address 0xc027e7f0
> 
> QUESTION:
> 
> I very strongly suspect that this exercise follows a particular sequence
> of steps to get it right. Either I am missing some step or I am not
> following the "order".  In either case, I would be glad to receive some
> help/comments on my academic endeavour to be able to remotely debug the
> kernel.
> 
> - Kindly let me know a solution
> 
> - TIA
> 
> - Shobhit Mathur
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
> 

-- 
George Anzinger   george@mvista.com
High-res-timers:  http://sourceforge.net/projects/high-res-timers/
Preemption patch: http://www.kernel.org/pub/linux/kernel/people/rml

