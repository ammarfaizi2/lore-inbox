Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965113AbVKGUrS@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965113AbVKGUrS (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 7 Nov 2005 15:47:18 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965325AbVKGUrS
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 7 Nov 2005 15:47:18 -0500
Received: from smtp.osdl.org ([65.172.181.4]:43656 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S965113AbVKGUrR (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 7 Nov 2005 15:47:17 -0500
Date: Mon, 7 Nov 2005 12:46:47 -0800
From: Andrew Morton <akpm@osdl.org>
To: Valdis.Kletnieks@vt.edu
Cc: patrakov@ums.usu.ru, linux-kernel@vger.kernel.org, sfrench@us.ibm.com,
       castet.matthieu@free.fr, greg@kroah.com, vojtech@suse.cz,
       dtor_core@ameritech.net
Subject: Re: 2.6.14-mm1
Message-Id: <20051107124647.212a670d.akpm@osdl.org>
In-Reply-To: <200511072021.jA7KL4kA030734@turing-police.cc.vt.edu>
References: <20051106182447.5f571a46.akpm@osdl.org>
	<436F7DAA.8070803@ums.usu.ru>
	<20051107115210.33e4f0bf.akpm@osdl.org>
	<200511072021.jA7KL4kA030734@turing-police.cc.vt.edu>
X-Mailer: Sylpheed version 1.0.4 (GTK+ 1.2.10; i386-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Valdis.Kletnieks@vt.edu wrote:
>
> On Mon, 07 Nov 2005 11:52:10 PST, Andrew Morton said:
> 
> > > 2) The PS/2 keyboard death on ppp traffic is still not fixed. 
> > > Reproducible even on slow GPRS if there's something else (e.g. glxgears) 
> > > that eats some CPU time. When keyboard is dead, events/0 consomes 100% 
> > > of CPU. Nothing in dmesg. If you outline some suspicious pieces of code, 
> > > I will insert printks there in order to debug this.
> > 
> > input guys cc'ed.
> 
> Getting myself on the cc: list, as I've seen this one on 2.6.14-rc5-mm1 (haven't
> nailed it on 14-mm1 *yet*, but only been up for 12 hours).  Also, some
> additional info:
> 
> The keyboard is dead, but other stuff still works - I've been able to issue
> commands by laborious cut-n-paste into an xterm window.  X is still up and
> responding, as are all the clients, so it's *not* a hard loop in events/0.
> 
> Also, I've had gkrellm running when it hits, and it will show incoming data
> rates on the modem of 3.5Mbytes/sec (as opposed to the 5K/sec you'd expect from
> a 56k modem).  A few times, I've had it go into auto-ambush on an iptables rule,
> with the same rule tripping several tens of thousands of times in a row,
> which makes me think it's got to do with a short packet (such as an inbound
> SYN packet) going into replicator mode and just being handed up from the
> device driver over and over, thousands of times....
> 
> alt-sysrq still works - I can sysrq-T to get traces, -S to sync, -B to reboot
> and so on, and the output gets through klogd and syslogd and into /var/adm/messages.

That sounds like softirq starvation.

Or maybe the input layer uses keventd services and keventd is stuck.

> I'm able to often trigger the bug by opening a new tab in Firefox, as that (a)
> involves small SYN+ACK packets coming back and (b) a Firefox bug causes it to
> chew CPU when displaying a page in a tab....
> 
> I'm willing to test-drive any debugging/patches needed, as this is probably the
> single biggest stability hit I have in -mm at the moment.
> 

I'd try hitting sysrq-p ten times, then take a look at the logs.
