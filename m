Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261297AbUKBWRU@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261297AbUKBWRU (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 2 Nov 2004 17:17:20 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262017AbUKBWOi
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 2 Nov 2004 17:14:38 -0500
Received: from smtp.Lynuxworks.com ([207.21.185.24]:19216 "EHLO
	smtp.lynuxworks.com") by vger.kernel.org with ESMTP id S261925AbUKBWJC
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 2 Nov 2004 17:09:02 -0500
Date: Tue, 2 Nov 2004 14:08:35 -0800
To: Ingo Molnar <mingo@elte.hu>
Cc: Bill Huey <bhuey@lnxw.com>, Michal Schmidt <xschmi00@stud.feec.vutbr.cz>,
       linux-kernel@vger.kernel.org, Lee Revell <rlrevell@joe-job.com>,
       Rui Nuno Capela <rncbc@rncbc.org>, Mark_H_Johnson@Raytheon.com,
       "K.R. Foley" <kr@cybsft.com>, Adam Heath <doogie@debian.org>,
       Florian Schmidt <mista.tapas@gmx.net>,
       Thomas Gleixner <tglx@linutronix.de>,
       Fernando Pablo Lopez-Lezcano <nando@ccrma.Stanford.EDU>,
       Karsten Wiese <annabellesgarden@yahoo.de>
Subject: Re: [patch] Real-Time Preemption, -RT-2.6.9-mm1-V0.5 (networking problems)
Message-ID: <20041102220835.GA21683@nietzsche.lynx.com>
References: <20041027001542.GA29295@elte.hu> <417F7D7D.5090205@stud.feec.vutbr.cz> <20041027134822.GA7980@elte.hu> <417FD9F2.8060002@stud.feec.vutbr.cz> <20041028115719.GA9563@elte.hu> <20041030000234.GA20986@nietzsche.lynx.com> <20041102085650.GA3973@nietzsche.lynx.com> <20041102093758.GA28014@elte.hu> <20041102110810.GA11393@nietzsche.lynx.com> <20041102114522.GA7874@elte.hu>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="3V7upXqbjpZ4EhLz"
Content-Disposition: inline
In-Reply-To: <20041102114522.GA7874@elte.hu>
User-Agent: Mutt/1.5.6+20040907i
From: Bill Huey (hui) <bhuey@lnxw.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--3V7upXqbjpZ4EhLz
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Tue, Nov 02, 2004 at 12:45:22PM +0100, Ingo Molnar wrote:
> * Bill Huey <bhuey@lnxw.com> wrote:
> > getting closer...
> > 
> > http:590 BUG: lock held at task exit time!
> >  [c03f9e84] {r:0,a:-1,kernel_sem.lock}
> >  .. held by:              http/  590 [dc0508a0, 121]
> >  ... acquired at:  __schedule+0x3ac/0x850
> 
> hm. Something called do_exit() with the BKL held which is a no-no. Do
> you have a stacktrace, is this sys_exit() or some other code calling
> do_exit()?

Attached:

bill


--3V7upXqbjpZ4EhLz
Content-Type: application/x-troff
Content-Disposition: attachment; filename=t
Content-Transfer-Encoding: quoted-printable

http:601 BUG: lock held at task exit time!=0A [c03f9e84] {r:0,a:-1,kernel_s=
em.lock}=0A.. held by:              http/  601 [dbe76920, 124]=0A... acquir=
ed at:  __schedule+0x3ac/0x850=0Ahttp/601: BUG in __up_write at lib/rwsem-g=
eneric.c:1058=0A [<c0107503>] dump_stack+0x23/0x30 (20)=0A [<c020fb1e>] __u=
p_write+0x17e/0x4a0 (76)=0A [<c0210848>] up+0x78/0xd0 (36)=0A [<c0393296>] =
__schedule+0x786/0x850 (108)=0A [<c0124546>] do_exit+0x266/0x4d0 (40)=0A [<=
c01248f0>] do_group_exit+0x40/0xe0 (40)=0A [<c012e9d8>] get_signal_to_deliv=
er+0x268/0x3f0 (44)=0A [<c0106438>] do_signal+0x88/0x130 (200)=0A [<c010652=
7>] do_notify_resume+0x47/0x4c (12)=0A [<c01066a6>] work_notifysig+0x13/0x1=
5 (-8124)=0A---------------------------=0A| preempt count: 00000004 ]=0A| 4=
-level deep critical section nesting:=0A-----------------------------------=
-----=0A.. [<c0392b5f>] .... __schedule+0x4f/0x850=0A.....[<c0124546>] ..  =
 ( <=3D do_exit+0x266/0x4d0)=0A.. [<c02107f3>] .... up+0x23/0xd0=0A.....[<c=
0393296>] ..   ( <=3D __schedule+0x786/0x850)=0A.. [<c0395032>] .... _spin_=
lock+0x22/0x80=0A.....[<c020fdc1>] ..   ( <=3D __up_write+0x421/0x4a0)=0A..=
 [<c013a7bd>] .... print_traces+0x1d/0x60=0A.....[<c0107503>] ..   ( <=3D d=
ump_stack+0x23/0x30)=0A=0A
--3V7upXqbjpZ4EhLz--
