Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261298AbUAUDTu (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 20 Jan 2004 22:19:50 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261563AbUAUDTu
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 20 Jan 2004 22:19:50 -0500
Received: from rrcs-central-24-123-144-118.biz.rr.com ([24.123.144.118]:42028
	"EHLO zso-proxy.zeusinc.com") by vger.kernel.org with ESMTP
	id S261298AbUAUDTs (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 20 Jan 2004 22:19:48 -0500
Subject: Re: TG3: very high CPU usage
From: Tom Sightler <ttsig@tuxyturvy.com>
To: Lincoln Dale <ltd@cisco.com>
Cc: JG <jg@cms.ac>, Andreas Hartmann <andihartmann@freenet.de>,
       Linux-Kernel <linux-kernel@vger.kernel.org>
In-Reply-To: <5.1.0.14.2.20040121100550.03cff190@171.71.163.14>
References: <20040119033527.GA11493@linux.comp>
	 <20040119033527.GA11493@linux.comp>
	 <5.1.0.14.2.20040121100550.03cff190@171.71.163.14>
Content-Type: text/plain
Message-Id: <1074655162.5834.16.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.5 (1.4.5-7) 
Date: Tue, 20 Jan 2004 22:19:22 -0500
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2004-01-20 at 18:13, Lincoln Dale wrote:
> At 11:33 PM 20/01/2004, JG wrote:
> >i have also two boxes (one with 2.6.0, the other one 2.6.1-mm2) equipped 
> >with netgear ga302t cards (x-over cable).
> >i don't see a very high cpu usage, but since upgrading to 2.6.x kernels i 
> >sometimes have really weird speed issues. i often only get transfer rates 
> >of about ~200-300 kilobytes/second...yes, and this over a gigabit 
> >interface, tested over ftp.
> >i'm also running a nfs server on the 2.6.1-mm2 box, the 2.6.0 pc is the 
> >client, but again, sometimes it's *very* slow. if i reboot my 2.6.1-mm2 
> >box (the other one is a server which can't be rebooted) it seems to be 
> >fine for some time.
> >
> >i didn't have such problems with 2.4.19 kernels on both pcs, there i got 
> >about 30-35MB/s over ftp without any problems, so i don't think it's 
> >hardware related.

I'm curious is the people seeing this problem happen to have preempt
enabled in their config.  I've noticed that my laptop, which also
happens to have a tg3 based 10/100/1000 card, uses tons of CPU during
trasfers, but only when preempt is enabled.

After looking into this, my Aironet wireless has exactly the same
problem.  When preempt is enabled a simple scp transfer running at
approximately maximum speed for 802.11b (7.5Mb/sec) uses almost 70% of
the CPU.  The tg3 driver doing the same scp at 40Mb/sec (100Mb ethernet)
uses > 90% of the CPU.

However, turning off preempt and my system runs at approximately the
same speed on wireless (7.5Mb/sec) but only about 5% CPU.  The tg3
driver with preempt disabled allows the scp to run at near wire speed
(95-100Mb/sec) and uses only a fraction of the CPU.

Just curious if this might be what others are seeing.

Later,
Tom


