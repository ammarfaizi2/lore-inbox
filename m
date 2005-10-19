Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751017AbVJSOuO@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751017AbVJSOuO (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 19 Oct 2005 10:50:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751019AbVJSOuO
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 19 Oct 2005 10:50:14 -0400
Received: from xproxy.gmail.com ([66.249.82.196]:58830 "EHLO xproxy.gmail.com")
	by vger.kernel.org with ESMTP id S1751017AbVJSOuM convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 19 Oct 2005 10:50:12 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:mime-version:content-type:content-transfer-encoding:content-disposition;
        b=DGn9tk9MKUSxsQSMkTa3VR2i8qeljT6SJb89ira3Q9PIrDhw4YpohEjR236PF9DSXunyG3aIv3vPrZOQcD2UWl8lrw0NL5CTl0VQZcsnDWWQDQpl0FbAVRkhWnIAAp+37Gkv/sCTNox17d5ADEozso2s/pCaEk1tcNnAIldSKFc=
Message-ID: <5bdc1c8b0510190750s377a2696kf9c323789b392664@mail.gmail.com>
Date: Wed, 19 Oct 2005 07:50:11 -0700
From: Mark Knecht <markknecht@gmail.com>
To: Ingo Molnar <mingo@elte.hu>
Subject: -rt10 build problem [WAS]Re: scsi_eh / 1394 bug - -rt7
Cc: Steven Rostedt <rostedt@goodmis.org>, Lee Revell <rlrevell@joe-job.com>,
       linux-kernel@vger.kernel.org, rmk@arm.linux.org.uk
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 10/19/05, Ingo Molnar <mingo@elte.hu> wrote:
>
> * Steven Rostedt <rostedt@goodmis.org> wrote:
>
> > > Attached scsi removable disk sda at scsi0, channel 0, id 0, lun 0
> > > usb 2-1: USB disconnect, address 2
> > > prev->state: 2 != TASK_RUNNING??
> > > scsi_eh_0/12648[CPU#0]: BUG in __schedule at kernel/sched.c:3326
> > >  [<c01048b9>] dump_stack+0x19/0x20 (20)
> > >  [<c011e766>] __WARN_ON+0x46/0x80 (12)
> > >  [<c02c0bf7>] __schedule+0x547/0x790 (84)
> > >  [<c012057a>] do_exit+0x26a/0x430 (28)
> > >  [<c010147b>] kernel_thread_helper+0xb/0x10 (1020129312)
> > >
> >
> > This is also a problem in the upstream kernel.  It's just that RT
> > catches it!  Here's the patch. I'll also write one for the upstream
> > kernel, although this patch would probably work there as well. But
> > I'll make it official.
> >
> > Ingo,
> >
> > Here's the patch.  The problem is similar to the pcmcia bug.  It seems
> > that the loop usually exits in the TASK_INTERRUPTIBLE state.
>
> thanks, applied and released in 2.6.14-rc4-rt10.
>
>         Ingo
>

Problem building 2.6.14-rc4-rt10. The only change to my config file
was to turn on a few options for Mac disks. I doubt that's involved
with this. I will send the .config file if requested.

Thanks for looking after this SCSI error. I'm anxious to see that go away.

Cheers,
Mark

  CC      kernel/pid.o
  CC      kernel/rcupdate.o
  CC      kernel/intermodule.o
kernel/intermodule.c:178: warning: `inter_module_register' is
deprecated (declared at kernel/intermodule.c:38)
kernel/intermodule.c:179: warning: `inter_module_unregister' is
deprecated (declared at kernel/intermodule.c:78)
kernel/intermodule.c:181: warning: `inter_module_put' is deprecated
(declared at kernel/intermodule.c:159)
  CC      kernel/extable.o
  CC      kernel/params.o
  CC      kernel/posix-timers.o
  CC      kernel/kthread.o
  CC      kernel/wait.o
  CC      kernel/kfifo.o
  CC      kernel/sys_ni.o
  CC      kernel/posix-cpu-timers.o
  CC      kernel/ktimers.o
kernel/ktimers.c: In function `check_ktimer_signal':
kernel/ktimers.c:1212: error: request for member `tv' in something not
a structure or union
kernel/ktimers.c:1212: error: request for member `tv' in something not
a structure or union
kernel/ktimers.c:1214: error: request for member `tv' in something not
a structure or union
kernel/ktimers.c:1214: error: request for member `tv' in something not
a structure or union
kernel/ktimers.c:1218: error: request for member `tv' in something not
a structure or union
kernel/ktimers.c:1218: error: request for member `tv' in something not
a structure or union
kernel/ktimers.c:1220: error: request for member `tv' in something not
a structure or union
kernel/ktimers.c:1220: error: request for member `tv' in something not
a structure or union
kernel/ktimers.c:1222: error: request for member `tv' in something not
a structure or union
kernel/ktimers.c:1222: error: request for member `tv' in something not
a structure or union
make[1]: *** [kernel/ktimers.o] Error 1
make: *** [kernel] Error 2
lightning linux #
