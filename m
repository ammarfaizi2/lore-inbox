Return-Path: <linux-kernel-owner+willy=40w.ods.org-S269090AbUIYXzv@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S269090AbUIYXzv (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 25 Sep 2004 19:55:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S269079AbUIYXzv
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 25 Sep 2004 19:55:51 -0400
Received: from viper.oldcity.dca.net ([216.158.38.4]:21737 "HELO
	viper.oldcity.dca.net") by vger.kernel.org with SMTP
	id S269448AbUIYXyq (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 25 Sep 2004 19:54:46 -0400
Subject: Re: [patch] voluntary-preempt-2.6.9-rc1-bk12-R5
From: Lee Revell <rlrevell@joe-job.com>
To: Duncan Sands <baldrick@free.fr>
Cc: Ingo Molnar <mingo@elte.hu>, Rui Nuno Capela <rncbc@rncbc.org>,
       Florian Schmidt <mista.tapas@gmx.net>, "K.R. Foley" <kr@cybsft.com>,
       linux-kernel <linux-kernel@vger.kernel.org>,
       felipe_alfaro@linuxmail.org
In-Reply-To: <200409252250.53703.baldrick@free.fr>
References: <20040903120957.00665413@mango.fruits.de>
	 <20040925203841.GB28001@elte.hu> <1096144856.3697.6.camel@krustophenia.net>
	 <200409252250.53703.baldrick@free.fr>
Content-Type: text/plain
Message-Id: <1096156450.3697.19.camel@krustophenia.net>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6 
Date: Sat, 25 Sep 2004 19:54:11 -0400
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 2004-09-25 at 16:50, Duncan Sands wrote:
> On Saturday 25 September 2004 22:40, Lee Revell wrote:
> > On Sat, 2004-09-25 at 16:38, Ingo Molnar wrote:
> > > * Lee Revell <rlrevell@joe-job.com> wrote:
> > > 
> > > > > since your lockups occur under X, could you try to disable DRI/DRM in
> > > > > your XConfig? Also, would it be possible to connect that box to another
> > > > > box via a serial line and enable the kernel's serial console via the
> > > > > 'console=ttyS0,38400 console=tty' boot option and run 'minicom' on that
> > > > > other box, set the serial line to 38400 baud there too and capture all
> > > > > kernel messages that occur when the lockups happens? Also enable the NMI
> > > > > watchdog via nmi_watchdog=1.
> > > > 
> > > > Rui brought up an interesting point on the alsa list.  Is this
> > > > procedure possible at all on a new laptop without a legacy serial
> > > > port?
> > > 
> > > well, netconsole should work.
> > > 
> > 
> > OK just to save everyone a google search here is the procedure:
> > 
> > http://technocrat.net/article.pl?sid=04/08/14/0236245&mode=thread
> 
> You may need this patch:
> 
> http://linux.bkbits.net:8080/linux-2.5/cset%4041470590n9GHsFJI2h0NeYTRXiyWMQ?nav=index.html|ChangeSet@-8w
> 

You know, this actually seems like an easier process than the serial
console.  Is there any good reason this isn't the "recommended" way to
diagnose lockups?  Unless they used to work at a telco ;-), most users
are more likely to have an ethernet crossover cable handy than a serial
cable.

Here's the netconsole mini-mini HOWTO.

load the module like:
    insmod netconsole \ 
    netconsole=source-port@source-ip/net-interface,dest-port@dest-ip/MAC-address

for example: 
    modprobe netconsole \
    netconsole=1234@69.44.153.169/eth0,4567@64.81.245.32/00:0A:8A:05:3D:80

then connect the other machine and run:
    netcat -u -l -p dest-port

to watch the output.

Lee

