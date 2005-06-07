Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261864AbVFGNkY@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261864AbVFGNkY (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 7 Jun 2005 09:40:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261865AbVFGNkY
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 7 Jun 2005 09:40:24 -0400
Received: from odin2.bull.net ([192.90.70.84]:40875 "EHLO odin2.bull.net")
	by vger.kernel.org with ESMTP id S261864AbVFGNfI (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 7 Jun 2005 09:35:08 -0400
Subject: Re: RT : Large transfert with
	2.6.12rc5+realtime-preempt-2.6.12-rc5-V0.7.47-15
From: "Serge Noiraud" <serge.noiraud@bull.net>
To: "K.R. Foley" <kr@cybsft.com>
Cc: linux-kernel <linux-kernel@vger.kernel.org>, Ingo Molnar <mingo@elte.hu>
In-Reply-To: <429D97BE.4060905@cybsft.com>
References: <1117552050.19367.63.camel@ibiza.btsn.frna.bull.fr>
	 <429C8E4E.4010608@cybsft.com>
	 <1117609093.5580.6.camel@ibiza.btsn.frna.bull.fr>
	 <429D97BE.4060905@cybsft.com>
Content-Type: multipart/mixed; boundary="=-jvPDKAAM2Vqv+YzqXUTq"
Organization: BTS
Message-Id: <1118150604.10102.231.camel@ibiza.btsn.frna.bull.fr>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6-5.1.100mdk 
Date: Tue, 07 Jun 2005 15:23:25 +0200
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--=-jvPDKAAM2Vqv+YzqXUTq
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: quoted-printable

Le mer 01/06/2005 =E0 13:10, K.R. Foley a =E9crit :=20
> Serge Noiraud wrote:
> > Le mar 31/05/2005 =E0 18:18, K.R. Foley a =E9crit :
> >=20
> >>Serge Noiraud wrote:
> >>
> >>>I had the same problem with rc4+47-07, rc5+47-10,47-13
> >>>I reproduce this problem with a tg3 driver and with e1000 driver.
> >>>So I think it's not a driver problem.
> >>>
> >>>I try to copy an iso image from this machine to another one by scp.
> >>>after 35 to 45MB, the copy become stalled with no more transfert.
> >>>We can ping the target machine, all apparently is OK except the scp
> >>>which finish with timeout.
> >>>With ftp, the stalled state is about 100MB.
> >>>If I reboot with a standard kernel ( without RT ), no problem.
> >>>
> >>>Perhaps there is a progress, in 47-15, the size is now 135-140MB
> >>>
> >>>On this machine, we have an ide disk.
> >>>I have setup : hdparm=20
> >>>-sh-2.05b# hdparm /dev/hda
> >>>
> >>>/dev/hda:
> >>> multcount    =3D 16 (on)
> >>> IO_support   =3D  3 (32-bit w/sync)
> >>> unmaskirq    =3D  1 (on)
> >>> using_dma    =3D  1 (on)
> >>> keepsettings =3D  0 (off)
> >>> readonly     =3D  0 (off)
> >>> readahead    =3D 256 (on)
> >>> geometry     =3D 65535/16/63, sectors =3D 78165360, start =3D 0
> >>>
> >>
> >>Hi,
> >>
> >>I am not sure what might be causing this problem for you. I just tried=20
> >>to reproduce this on one of my systems but could not (scsi not ide). Th=
e=20
> >>first time it copied 450MB before the remote system ran out of space.=20
> >>After cleaning up a bit I got the whole 630MB without a hitch. Do you=20
> >>have the RT patch on both systems or just on the originating system? In=
=20
> >>my case its the latter. There is
> >=20
> >=20
> > The scp or ftp start on a RT machine.
> > The destination is an RT or Non RT machine, the problem is the same.
> > It's not a space problem, I have 4GB available on the destination path.
> > I can reproduce the phenomena at each try.
> > If I <CTRL C> the scp when it is stalled then relaunch the scp command,=
 the transfert restart without problem.
> > I'm trying to trace this problem but I don't know how to do this.
> > Has someone one method ?
> >=20
> >=20
>=20
> Do any of your logs provide any clues? Does this happen with just
> 2.6.12-rc5 and no rt-preempt patch? Does ifconfig provide any clues? How
> about netstat -a? What is the state of the connection?

I have no problem with a 2.6.12rc5 with no RT patch.

With the RT pach :
When I get the problem, netstat -a seems ok.
The connection is established.

I progress in my tests.
runlevel =3D 1

cp of the iso file to another one in the same directory : no problem
I reboot in single then start only lo ( loopback )
cd /tmp
scp F1.iso localhost:/tmp/F2.iso : no problem

In runlevel > 1

dd if=3D/dev/zero bs=3D4k | ssh localhost:/dev/null
it is OK after 1 hour.

sh-2.05b# dd if=3D/dev/zero bs=3D8k | ssh 192.168.44.112 dd of=3D/dev/null
root@192.168.44.112's password:=20
Read from remote host 192.168.44.112: Connection timed out
3565+0 records in
3564+0 records out
sh-2.05b#cat /proc/latency_trace
preemption latency trace v1.1.4 on 2.6.12-DAV06_dbg
--------------------------------------------------------------------
latency: 45 us, #64/64, CPU#0 | (M:rt VP:0, KP:1, SP:1 HP:1 #P:2)
    -----------------
    | task: ksoftirqd/0-3 (uid:0 nice:-10 policy:0 rt_prio:0)
    -----------------

                 _------=3D> CPU#
                / _-----=3D> irqs-off
               | / _----=3D> need-resched
               || / _---=3D> hardirq/softirq
               ||| / _--=3D> preempt-depth
               |||| /
               |||||     delay
   cmd     pid ||||| time  |   caller
      \   /    |||||   \   |   /
      dd-6389  0dn.2    2us : _raw_spin_lock (__up_mutex)
      dd-6389  0dn.3    2us : _raw_spin_lock (__up_mutex)
      dd-6389  0dn.4    3us : mutex_getprio (__up_mutex)
      dd-6389  0dn.4    4us : mutex_getprio <dd-6389> (73 73):
      dd-6389  0dn.4    4us : _raw_spin_unlock (__up_mutex)
      dd-6389  0dn.3    4us : preempt_schedule (__up_mutex)
      dd-6389  0dn.3    5us : _raw_spin_unlock (__up_mutex)
      dd-6389  0dn.2    5us : preempt_schedule (__up_mutex)
      dd-6389  0dn.2    5us : _raw_spin_unlock (__up_mutex)
      dd-6389  0dn.1    6us : preempt_schedule (__up_mutex)
      dd-6389  0dn.1    7us : smp_reschedule_interrupt (c0141a7a 0 0)
      dd-6389  0dn.1    8us < (608)
      dd-6389  0dnh1    9us : do_IRQ (c0141a7a 0 0)
      dd-6389  0d.h.   10us : _raw_spin_lock (__do_IRQ)
      dd-6389  0d.h1   11us : ack_lapic_irq (__do_IRQ)
      dd-6389  0d.h1   11us : redirect_hardirq (__do_IRQ)
      dd-6389  0d.h1   12us : _raw_spin_unlock (__do_IRQ)
      dd-6389  0d.h.   12us : handle_IRQ_event (__do_IRQ)
      dd-6389  0d.h.   12us : timer_interrupt (handle_IRQ_event)
      dd-6389  0d.h.   13us : _raw_spin_lock (timer_interrupt)
      dd-6389  0d.h1   13us : mark_offset_pmtmr (timer_interrupt)
      dd-6389  0d.h1   14us+: _raw_spin_lock (mark_offset_pmtmr)
      dd-6389  0d.h2   17us : _raw_spin_unlock (mark_offset_pmtmr)
      dd-6389  0d.h1   18us+: _raw_spin_lock_irqsave (timer_interrupt)
      dd-6389  0d.h2   20us : _raw_spin_unlock_irqrestore
(timer_interrupt)
      dd-6389  0d.h1   21us : do_timer (timer_interrupt)
      dd-6389  0d.h1   21us : _raw_spin_unlock (timer_interrupt)
      dd-6389  0d.h.   22us : _raw_spin_lock (__do_IRQ)
      dd-6389  0d.h1   22us : note_interrupt (__do_IRQ)
      dd-6389  0d.h1   23us : end_lapic_irq (__do_IRQ)
      dd-6389  0d.h1   23us : _raw_spin_unlock (__do_IRQ)
      dd-6389  0dnh1   23us : irq_exit (do_IRQ)
      dd-6389  0dn.2   24us : do_softirq (irq_exit)
      dd-6389  0d.s.   25us : __do_softirq (do_softirq)
      dd-6389  0d.s.   25us : wake_up_process (do_softirq)
      dd-6389  0d.s.   26us : try_to_wake_up (wake_up_process)
      dd-6389  0d.s.   26us : _raw_spin_lock (try_to_wake_up)
      dd-6389  0d.s1   27us : _raw_spin_unlock_irqrestore
(try_to_wake_up)
      dd-6389  0d.s.   27us : wake_up_process (do_softirq)
      dd-6389  0dn.1   28us < (608)
      dd-6389  0.n.1   29us : preempt_schedule (rt_up)
      dd-6389  0.n..   29us : preempt_schedule (pipe_writev)
      dd-6389  0dn..   29us : __schedule (preempt_schedule)
      dd-6389  0dn.1   30us : sched_clock (__schedule)
      dd-6389  0dn.1   31us : _raw_spin_lock_irq (__schedule)
      dd-6389  0dn.1   31us : _raw_spin_lock_irqsave (__schedule)
      dd-6389  0dn.2   32us : _raw_spin_unlock (__schedule)
      dd-6389  0dn.1   32us : preempt_schedule (__schedule)
      dd-6389  0dn.1   32us : _raw_spin_lock (__schedule)
      dd-6389  0dn.1   33us : preempt_schedule (_raw_spin_lock)
      dd-6389  0dn.2   34us : find_next_bit (__schedule)
      dd-6389  0d..2   36us+: trace_array (__schedule)
      dd-6389  0d..2   38us : trace_array <<...>-3> (69 6e):
      dd-6389  0d..2   38us : trace_array <dd-6389> (73 78):
      dd-6389  0d..2   39us+: trace_array (__schedule)
   <...>-3     0d..2   42us : __switch_to (__schedule)
   <...>-3     0d..2   42us : __schedule <dd-6389> (73 69):
   <...>-3     0d..2   43us : _raw_spin_unlock (__schedule)
   <...>-3     0d..1   43us : trace_stop_sched_switched (__schedule)
   <...>-3     0d..1   43us : trace_stop_sched_switched <<...>-3> (69
0):
   <...>-3     0d..1   44us : _raw_spin_lock_irqsave
(trace_stop_sched_switched)
   <...>-3     0d..1   45us : trace_stop_sched_switched (__schedule)


vim:ft=3Dhelp

... Week end ...

I progress in my test. I have the same problem with rc5+47-18

I reproduce the problem on only one machine with one ide disk:

dd if=3D/dev/zero b=3D4k | ssh 192.168.44.112 dd of=3D/dev/null

In all cases, this command duration in 18 minutes even when I launch it
several times.

It works fine with localhost.
The target machine can be everything.
I'm trying to test with rc6+47-25

all my infos are in the script command results dd-test.bz2
which include the dd command, lspci -vv, dmesg, config, mii-tool,
ifconfig


--=-jvPDKAAM2Vqv+YzqXUTq
Content-Disposition: attachment; filename=dd-test.bz2
Content-Type: application/x-bzip; name=dd-test.bz2
Content-Transfer-Encoding: base64

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
u0A=

--=-jvPDKAAM2Vqv+YzqXUTq--

