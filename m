Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261524AbVD0MNY@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261524AbVD0MNY (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 27 Apr 2005 08:13:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261525AbVD0MNY
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 27 Apr 2005 08:13:24 -0400
Received: from grendel.digitalservice.pl ([217.67.200.140]:41911 "HELO
	mail.digitalservice.pl") by vger.kernel.org with SMTP
	id S261524AbVD0MMu (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 27 Apr 2005 08:12:50 -0400
From: "Rafael J. Wysocki" <rjw@sisk.pl>
To: Andrew Morton <akpm@osdl.org>
Subject: Re: [BUG] 2.6.12-rc3: unkillable java process in TASK_RUNNING on AMD64
Date: Wed, 27 Apr 2005 14:12:51 +0200
User-Agent: KMail/1.7.1
Cc: ak@suse.de, linux-kernel@vger.kernel.org
References: <200504271152.15423.rjw@sisk.pl> <200504271305.10882.rjw@sisk.pl> <20050427045546.7c769a4f.akpm@osdl.org>
In-Reply-To: <20050427045546.7c769a4f.akpm@osdl.org>
MIME-Version: 1.0
Content-Type: Multipart/Mixed;
  boundary="Boundary-00=_DH4bCAx5osNWc68"
Message-Id: <200504271412.51565.rjw@sisk.pl>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

--Boundary-00=_DH4bCAx5osNWc68
Content-Type: text/plain;
  charset="iso-8859-2"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

On Wednesday, 27 of April 2005 13:55, Andrew Morton wrote:
> "Rafael J. Wysocki" <rjw@sisk.pl> wrote:
> >
> > On Wednesday, 27 of April 2005 12:19, Andrew Morton wrote:
> > > "Rafael J. Wysocki" <rjw@sisk.pl> wrote:
> > > >
> > > > Hi,
> > > > 
> > > > I'm having a problem with 2.6.12-rc3 and the Java VM (from SuSE 9.2)
> > > > on AMD64.  Namely, after trying to open a web page containing a Java
> > > > applet, my browser starts a java process that takes almost 100% of the CPU
> > > > (system load, according to gkrellm) and cannot be killed (even by root,
> > > > although it executes with a non-root UID).  Apparently, it is in TASK_RUNNING
> > > > (according to ps).
> > > > 
> > > > The problem is 100% reproducible (it is enough to visit
> > > > http://java.sun.com/docs/books/tutorial/getStarted/index.html to trigger it)
> > > > and it does not depend on the web browser used.
> > > > 
> > > > The Java JRE version is:
> > > > 
> > > > java version "1.4.2_06"
> > > > Java(TM) 2 Runtime Environment, Standard Edition (build 1.4.2_06-b03)
> > > > Java HotSpot(TM) Client VM (build 1.4.2_06-b03, mixed mode)
> > > > 
> > > > (I guess it's 32-bit, but I'm not quite sure) and I've installed it from the
> > > > SuSE 9.2 RPM.
> > > > 
> > > > It really is a show stopper to me, so please advise.
> > > 
> > > Where is it running?
> > > 
> > > You can tell this from a kernel profile, or by using sysrq-P five or ten
> > > times then looking at the output.
> > 
> > >From sysrq-P, I get this:
> > 
> > Pid: 11073, comm: java Not tainted 2.6.12-rc3
> > RIP: 0010:[<ffffffff8010f675>] <ffffffff8010f675>{retint_signal+20}
> > RSP: 0018:ffff810012d6ff58  EFLAGS: 00000282
> > RAX: 0000000000020000 RBX: ffff810010868820 RCX: ffff810012d6e000
> > RDX: 0000000000020000 RSI: 0000000000000000 RDI: ffff810012d6ff58
> > RBP: 000000a30c153a4a R08: ffff810012d6e000 R09: ffffffff804c6068
> > R10: 0000000000000001 R11: 0000000000000001 R12: ffffffff804ccd40
> > R13: ffff810010868820 R14: ffff81002cff2cf0 R15: ffffffff8010d3a7
> > FS:  00002aaaae6389c0(0000) GS:ffffffff8054a600(0063) knlGS:00000000556c9080
> > CS:  0010 DS: 002b ES: 002b CR0: 000000008005003b
> > CR2: 00002aaaaabab000 CR3: 0000000012930000 CR4: 00000000000006e0
> > 
> > Call Trace:<ffffffff8010f697>{retint_signal+54}
> > 
> > all the time.
> 
> All the time?  Exactly the same?

Well, to be precise (in the order of appearence):

RIP: 0010:[<ffffffff8010f666>] <ffffffff8010f666>{retint_signal+5}
Call Trace:<ffffffff8010f697>{retint_signal+54}

RIP: 0010:[<ffffffff8010f666>] <ffffffff8010f666>{retint_signal+5}
Call Trace:<ffffffff8010f697>{retint_signal+54}

RIP: 0010:[<ffffffff8010f666>] <ffffffff8010f666>{retint_signal+5}
Call Trace:<ffffffff8010f697>{retint_signal+54}

RIP: 0010:[<ffffffff8013f928>] <ffffffff8013f928>{__do_softirq+72}
Call Trace: <IRQ> <ffffffff80139a7b>{profile_tick+75} <ffffffff8013f9c5>{do_softirq+53}
	<ffffffff80111ab7>{do_IRQ+71} <ffffffff8010f5d5>{ret_from_intr+0}
	<EOI> <ffffffff8010d3a7>{__switch_to+263} <ffffffff8010f666>{retint_signal+5}
	<ffffffff8010f697>{retint_signal+54}

RIP: 0010:[<ffffffff8010f666>] <ffffffff8010f666>{retint_signal+5}
Call Trace:<ffffffff8010f697>{retint_signal+54}

RIP: 0010:[<ffffffff8010f666>] <ffffffff8010f666>{retint_signal+5}
Call Trace:<ffffffff8010f697>{retint_signal+54}

RIP: 0010:[<ffffffff8010e6a0>] <ffffffff8010e6a0>{do_notify_resume+48}
Call Trace:<ffffffff8010f697>{retint_signal+54}

RIP: 0010:[<ffffffff8010f675>] <ffffffff8010f675>{retint_signal+20}
Call Trace:<ffffffff8010f697>{retint_signal+54}


> If you could do something crude like hit sysrq-P 100 times then do
> `dmesg|grep RIP' we could possibly determine whether things are indeed stuck
> in that potential infinite loop in there. 

OK, the result is attached (I think things really are there).

> I assume you're using CONFIG_PREEMPT?

No ...

> It'd be interesting to know the interrupt rate and context switch rate
> which this is going on.

OK, but could you please tell me how to get these numbers?

Greets,
Rafael


-- 
- Would you tell me, please, which way I ought to go from here?
- That depends a good deal on where you want to get to.
		-- Lewis Carroll "Alice's Adventures in Wonderland"

--Boundary-00=_DH4bCAx5osNWc68
Content-Type: text/x-log;
  charset="iso-8859-2";
  name="sysrq-P-RIP.log"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
	filename="sysrq-P-RIP.log"

RIP: 0010:[<ffffffff8010f666>] <ffffffff8010f666>{retint_signal+5}
RIP: 0010:[<ffffffff8010f6a0>] <ffffffff8010f6a0>{retint_signal+63}
RIP: 0010:[<ffffffff8010f666>] <ffffffff8010f666>{retint_signal+5}
RIP: 0010:[<ffffffff8010e673>] <ffffffff8010e673>{do_notify_resume+3}
RIP: 0010:[<ffffffff8010f666>] <ffffffff8010f666>{retint_signal+5}
RIP: 0010:[<ffffffff8010f666>] <ffffffff8010f666>{retint_signal+5}
RIP: 0010:[<ffffffff8010f666>] <ffffffff8010f666>{retint_signal+5}
RIP: 0010:[<ffffffff8010f666>] <ffffffff8010f666>{retint_signal+5}
RIP: 0010:[<ffffffff8010f666>] <ffffffff8010f666>{retint_signal+5}
RIP: 0010:[<ffffffff8010f666>] <ffffffff8010f666>{retint_signal+5}
RIP: 0010:[<ffffffff8010e670>] <ffffffff8010e670>{do_notify_resume+0}
RIP: 0010:[<ffffffff8010f666>] <ffffffff8010f666>{retint_signal+5}
RIP: 0010:[<ffffffff8010f666>] <ffffffff8010f666>{retint_signal+5}
RIP: 0010:[<ffffffff8010f666>] <ffffffff8010f666>{retint_signal+5}
RIP: 0010:[<ffffffff8010f666>] <ffffffff8010f666>{retint_signal+5}
RIP: 0010:[<ffffffff80332d91>] <ffffffff80332d91>{__kfree_skb+1}
RIP: 0010:[<ffffffff8010f675>] <ffffffff8010f675>{retint_signal+20}
RIP: 0010:[<ffffffff8010e673>] <ffffffff8010e673>{do_notify_resume+3}
RIP: 0010:[<ffffffff8010f666>] <ffffffff8010f666>{retint_signal+5}
RIP: 0010:[<ffffffff8010f666>] <ffffffff8010f666>{retint_signal+5}
RIP: 0010:[<ffffffff8013f928>] <ffffffff8013f928>{__do_softirq+72}
RIP: 0010:[<ffffffff8010f666>] <ffffffff8010f666>{retint_signal+5}
RIP: 0010:[<ffffffff8010f6af>] <ffffffff8010f6af>{retint_signal+78}
RIP: 0010:[<ffffffff8010f675>] <ffffffff8010f675>{retint_signal+20}
RIP: 0010:[<ffffffff8010f666>] <ffffffff8010f666>{retint_signal+5}
RIP: 0010:[<ffffffff8010f666>] <ffffffff8010f666>{retint_signal+5}
RIP: 0010:[<ffffffff8010f666>] <ffffffff8010f666>{retint_signal+5}
RIP: 0010:[<ffffffff8010f666>] <ffffffff8010f666>{retint_signal+5}
RIP: 0010:[<ffffffff8010f666>] <ffffffff8010f666>{retint_signal+5}
RIP: 0010:[<ffffffff8010f666>] <ffffffff8010f666>{retint_signal+5}
RIP: 0010:[<ffffffff8010f666>] <ffffffff8010f666>{retint_signal+5}
RIP: 0010:[<ffffffff8010f666>] <ffffffff8010f666>{retint_signal+5}
RIP: 0010:[<ffffffff8010f666>] <ffffffff8010f666>{retint_signal+5}
RIP: 0010:[<ffffffff8010f666>] <ffffffff8010f666>{retint_signal+5}
RIP: 0010:[<ffffffff8010f666>] <ffffffff8010f666>{retint_signal+5}
RIP: 0010:[<ffffffff8010f666>] <ffffffff8010f666>{retint_signal+5}
RIP: 0010:[<ffffffff8010f683>] <ffffffff8010f683>{retint_signal+34}
RIP: 0010:[<ffffffff8010e673>] <ffffffff8010e673>{do_notify_resume+3}
RIP: 0010:[<ffffffff8010f666>] <ffffffff8010f666>{retint_signal+5}
RIP: 0010:[<ffffffff8010f666>] <ffffffff8010f666>{retint_signal+5}
RIP: 0010:[<ffffffff8010f666>] <ffffffff8010f666>{retint_signal+5}
RIP: 0010:[<ffffffff8010f666>] <ffffffff8010f666>{retint_signal+5}
RIP: 0010:[<ffffffff8010f666>] <ffffffff8010f666>{retint_signal+5}
RIP: 0010:[<ffffffff8010f666>] <ffffffff8010f666>{retint_signal+5}
RIP: 0010:[<ffffffff8010f666>] <ffffffff8010f666>{retint_signal+5}
RIP: 0010:[<ffffffff8010f666>] <ffffffff8010f666>{retint_signal+5}
RIP: 0010:[<ffffffff8010f666>] <ffffffff8010f666>{retint_signal+5}
RIP: 0010:[<ffffffff8010e670>] <ffffffff8010e670>{do_notify_resume+0}
RIP: 0010:[<ffffffff8010f666>] <ffffffff8010f666>{retint_signal+5}
RIP: 0010:[<ffffffff8010f6a0>] <ffffffff8010f6a0>{retint_signal+63}
RIP: 0010:[<ffffffff8010f666>] <ffffffff8010f666>{retint_signal+5}
RIP: 0010:[<ffffffff8010f666>] <ffffffff8010f666>{retint_signal+5}
RIP: 0010:[<ffffffff8010f666>] <ffffffff8010f666>{retint_signal+5}
RIP: 0010:[<ffffffff8010f666>] <ffffffff8010f666>{retint_signal+5}
RIP: 0010:[<ffffffff8010e6a0>] <ffffffff8010e6a0>{do_notify_resume+48}
RIP: 0033:[<00002aaaaac2dcd2>] [<00002aaaaac2dcd2>]
RIP: 0010:[<ffffffff8010f666>] <ffffffff8010f666>{retint_signal+5}
RIP: 0010:[<ffffffff8010e670>] <ffffffff8010e670>{do_notify_resume+0}
RIP: 0010:[<ffffffff8010f666>] <ffffffff8010f666>{retint_signal+5}
RIP: 0010:[<ffffffff8010f675>] <ffffffff8010f675>{retint_signal+20}
RIP: 0010:[<ffffffff8010f666>] <ffffffff8010f666>{retint_signal+5}
RIP: 0010:[<ffffffff8010f666>] <ffffffff8010f666>{retint_signal+5}
RIP: 0010:[<ffffffff8010f666>] <ffffffff8010f666>{retint_signal+5}
RIP: 0010:[<ffffffff8010f6af>] <ffffffff8010f6af>{retint_signal+78}
RIP: 0010:[<ffffffff8010f666>] <ffffffff8010f666>{retint_signal+5}
RIP: 0010:[<ffffffff8010f666>] <ffffffff8010f666>{retint_signal+5}
RIP: 0010:[<ffffffff8010f666>] <ffffffff8010f666>{retint_signal+5}
RIP: 0010:[<ffffffff8010f666>] <ffffffff8010f666>{retint_signal+5}
RIP: 0010:[<ffffffff8010e670>] <ffffffff8010e670>{do_notify_resume+0}
RIP: 0010:[<ffffffff8010e6a0>] <ffffffff8010e6a0>{do_notify_resume+48}
RIP: 0010:[<ffffffff8010f666>] <ffffffff8010f666>{retint_signal+5}
RIP: 0010:[<ffffffff8010f6af>] <ffffffff8010f6af>{retint_signal+78}
RIP: 0010:[<ffffffff8010e673>] <ffffffff8010e673>{do_notify_resume+3}
RIP: 0010:[<ffffffff8010f666>] <ffffffff8010f666>{retint_signal+5}
RIP: 0010:[<ffffffff8010f666>] <ffffffff8010f666>{retint_signal+5}
RIP: 0010:[<ffffffff8010f666>] <ffffffff8010f666>{retint_signal+5}
RIP: 0010:[<ffffffff8010f666>] <ffffffff8010f666>{retint_signal+5}
RIP: 0010:[<ffffffff8010f666>] <ffffffff8010f666>{retint_signal+5}
RIP: 0010:[<ffffffff8010f666>] <ffffffff8010f666>{retint_signal+5}
RIP: 0010:[<ffffffff8010f683>] <ffffffff8010f683>{retint_signal+34}
RIP: 0010:[<ffffffff8010f6af>] <ffffffff8010f6af>{retint_signal+78}
RIP: 0010:[<ffffffff8010f666>] <ffffffff8010f666>{retint_signal+5}
RIP: 0010:[<ffffffff8010f666>] <ffffffff8010f666>{retint_signal+5}
RIP: 0010:[<ffffffff8010f666>] <ffffffff8010f666>{retint_signal+5}
RIP: 0010:[<ffffffff8010f666>] <ffffffff8010f666>{retint_signal+5}
RIP: 0010:[<ffffffff8010f666>] <ffffffff8010f666>{retint_signal+5}
RIP: 0010:[<ffffffff8010e6a0>] <ffffffff8010e6a0>{do_notify_resume+48}
RIP: 0010:[<ffffffff8010f666>] <ffffffff8010f666>{retint_signal+5}
RIP: 0010:[<ffffffff8010f683>] <ffffffff8010f683>{retint_signal+34}
RIP: 0010:[<ffffffff8010f666>] <ffffffff8010f666>{retint_signal+5}
RIP: 0010:[<ffffffff8010f692>] <ffffffff8010f692>{retint_signal+49}
RIP: 0010:[<ffffffff8010f666>] <ffffffff8010f666>{retint_signal+5}
RIP: 0010:[<ffffffff8010f666>] <ffffffff8010f666>{retint_signal+5}
RIP: 0010:[<ffffffff8010f666>] <ffffffff8010f666>{retint_signal+5}
RIP: 0010:[<ffffffff8010f666>] <ffffffff8010f666>{retint_signal+5}
RIP: 0010:[<ffffffff8010e670>] <ffffffff8010e670>{do_notify_resume+0}
RIP: 0010:[<ffffffff8010f666>] <ffffffff8010f666>{retint_signal+5}
RIP: 0010:[<ffffffff8010f666>] <ffffffff8010f666>{retint_signal+5}
RIP: 0010:[<ffffffff8010f666>] <ffffffff8010f666>{retint_signal+5}
RIP: 0010:[<ffffffff8010f675>] <ffffffff8010f675>{retint_signal+20}
RIP: 0010:[<ffffffff8010f666>] <ffffffff8010f666>{retint_signal+5}
RIP: 0010:[<ffffffff8010f666>] <ffffffff8010f666>{retint_signal+5}
RIP: 0010:[<ffffffff8010f666>] <ffffffff8010f666>{retint_signal+5}
RIP: 0010:[<ffffffff8010f666>] <ffffffff8010f666>{retint_signal+5}
RIP: 0010:[<ffffffff8010f666>] <ffffffff8010f666>{retint_signal+5}
RIP: 0010:[<ffffffff8010f666>] <ffffffff8010f666>{retint_signal+5}
RIP: 0010:[<ffffffff8010f666>] <ffffffff8010f666>{retint_signal+5}
RIP: 0010:[<ffffffff8010f6af>] <ffffffff8010f6af>{retint_signal+78}
RIP: 0010:[<ffffffff8010f666>] <ffffffff8010f666>{retint_signal+5}
RIP: 0010:[<ffffffff8010f666>] <ffffffff8010f666>{retint_signal+5}
RIP: 0010:[<ffffffff8010f666>] <ffffffff8010f666>{retint_signal+5}
RIP: 0010:[<ffffffff8010f683>] <ffffffff8010f683>{retint_signal+34}
RIP: 0010:[<ffffffff8010e6a0>] <ffffffff8010e6a0>{do_notify_resume+48}
RIP: 0010:[<ffffffff8010f692>] <ffffffff8010f692>{retint_signal+49}
RIP: 0010:[<ffffffff8010f6af>] <ffffffff8010f6af>{retint_signal+78}
RIP: 0010:[<ffffffff8010e673>] <ffffffff8010e673>{do_notify_resume+3}
RIP: 0010:[<ffffffff801b1500>] <ffffffff801b1500>{vfs_ioctl+400}
RIP: 0010:[<ffffffff8010e670>] <ffffffff8010e670>{do_notify_resume+0}
RIP: 0010:[<ffffffff8010f692>] <ffffffff8010f692>{retint_signal+49}
RIP: 0010:[<ffffffff8010f666>] <ffffffff8010f666>{retint_signal+5}
RIP: 0010:[<ffffffff8010f666>] <ffffffff8010f666>{retint_signal+5}
RIP: 0010:[<ffffffff8010e670>] <ffffffff8010e670>{do_notify_resume+0}
RIP: 0010:[<ffffffff8010f666>] <ffffffff8010f666>{retint_signal+5}
RIP: 0010:[<ffffffff8010e670>] <ffffffff8010e670>{do_notify_resume+0}
RIP: 0010:[<ffffffff8010f6af>] <ffffffff8010f6af>{retint_signal+78}
RIP: 0010:[<ffffffff8010e670>] <ffffffff8010e670>{do_notify_resume+0}
RIP: 0010:[<ffffffff8010f666>] <ffffffff8010f666>{retint_signal+5}
RIP: 0010:[<ffffffff8010f666>] <ffffffff8010f666>{retint_signal+5}
RIP: 0010:[<ffffffff8010f675>] <ffffffff8010f675>{retint_signal+20}
RIP: 0010:[<ffffffff8010f666>] <ffffffff8010f666>{retint_signal+5}
RIP: 0010:[<ffffffff8010f683>] <ffffffff8010f683>{retint_signal+34}
RIP: 0010:[<ffffffff8010e6a0>] <ffffffff8010e6a0>{do_notify_resume+48}
RIP: 0010:[<ffffffff8010f666>] <ffffffff8010f666>{retint_signal+5}
RIP: 0010:[<ffffffff8010e673>] <ffffffff8010e673>{do_notify_resume+3}
RIP: 0010:[<ffffffff8010f666>] <ffffffff8010f666>{retint_signal+5}
RIP: 0010:[<ffffffff8010f675>] <ffffffff8010f675>{retint_signal+20}
RIP: 0010:[<ffffffff8010f666>] <ffffffff8010f666>{retint_signal+5}
RIP: 0010:[<ffffffff8010f666>] <ffffffff8010f666>{retint_signal+5}
RIP: 0010:[<ffffffff8010e670>] <ffffffff8010e670>{do_notify_resume+0}
RIP: 0010:[<ffffffff8010f666>] <ffffffff8010f666>{retint_signal+5}

--Boundary-00=_DH4bCAx5osNWc68--
