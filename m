Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S289769AbSAOXxT>; Tue, 15 Jan 2002 18:53:19 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S289768AbSAOXur>; Tue, 15 Jan 2002 18:50:47 -0500
Received: from x35.xmailserver.org ([208.129.208.51]:52493 "EHLO
	x35.xmailserver.org") by vger.kernel.org with ESMTP
	id <S289770AbSAOXua>; Tue, 15 Jan 2002 18:50:30 -0500
X-AuthUser: davidel@xmailserver.org
Date: Tue, 15 Jan 2002 15:56:29 -0800 (PST)
From: Davide Libenzi <davidel@xmailserver.org>
X-X-Sender: davide@blue1.dev.mcafeelabs.com
To: Ed Tomlinson <tomlins@cam.org>
cc: Ingo Molnar <mingo@elte.hu>, lkml <linux-kernel@vger.kernel.org>,
        Dave Jones <davej@suse.de>
Subject: Re: [patch] O(1) scheduler-H6/H7/I0 and nice +19
In-Reply-To: <20020115234814.DB1E729905@oscar.casa.dyndns.org>
Message-ID: <Pine.LNX.4.40.0201151555070.960-100000@blue1.dev.mcafeelabs.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 15 Jan 2002, Ed Tomlinson wrote:

> The 2.4.17-I0 patch makes things much better here.  Does this one
> suffer from the same bugs that the 2.5.2 version has?
>
>   PID USER     PRI  NI  SIZE  RSS SHARE STAT %CPU %MEM   TIME COMMAND
>   790 ed        44  19 14320  13M   640 R N  69.4  2.7 166:18 setiathome
>  7676 ed         0   0 14908  14M 11036 R    16.7  2.8   0:13 kmail
>  5703 root       0 -10 82596  23M  1808 R <  11.2  4.6   2:23 XFree86
>  7725 ed         0   0  1016 1016   776 R     1.3  0.1   0:00 top
>  5803 ed         0   0  3764 3764  2904 R     0.5  0.7   0:15 gkrellm
>  7720 ed         0   0  9752 9752  7856 R     0.3  1.8   0:04 kdeinit
>  5725 ed         0   0  7524 7520  6888 S     0.1  1.4   0:01 kdeinit
>     1 root       0   0   520  472   452 S     0.0  0.0   0:07 init
>     2 root       0   0     0    0     0 SW    0.0  0.0   0:00 keventd
>     3 root      17  19     0    0     0 SWN   0.0  0.0   0:00 ksoftirqd_CPU0
>     4 root       0   0     0    0     0 SW    0.0  0.0   0:00 kswapd
>     5 root      25   0     0    0     0 SW    0.0  0.0   0:00 bdflush
>     6 root       0   0     0    0     0 SW    0.0  0.0   0:02 kupdated
>     7 root      12   0     0    0     0 SW    0.0  0.0   0:00 khubd
>    18 root       0   0     0    0     0 SW    0.0  0.0   0:00 kreiserfsd
>    60 root       0   0     0    0     0 SW    0.0  0.0   0:00 mdrecoveryd
>   219 root       0   0     0    0     0 SW    0.0  0.0   0:00 usb-storage-0
>   220 root       0   0     0    0     0 SW    0.0  0.0   0:00 scsi_eh_0
>   234 root       0   0   648  644   528 S     0.0  0.1   0:00 syslogd
>   238 root      -2   0  1344 1344  1264 S     0.0  0.2   0:00 watchdog
>   243 root       0   0  1184 1176   456 S     0.0  0.2   0:00 klogd
>   249 daemon     0   0   472  460   380 S     0.0  0.0   0:00 portmap
>
> Major difference from older version of the patch is that top shows many
> processes with PRI 0.   I am not sure this is intended?
>
> Thanks
> Ed Tomlinson
>
> On January 14, 2002 10:27 pm, Davide Libenzi wrote:
> > On Mon, 14 Jan 2002, Ed Tomlinson wrote:
> > > On January 14, 2002 09:33 pm, Davide Libenzi wrote:
> > > > try to replace :
> > > >
> > > > PRIO_TO_TIMESLICE() and RT_PRIO_TO_TIMESLICE() with :
> > > >
> > > > #define NICE_TO_TIMESLICE(n)    (MIN_TIMESLICE + ((MAX_TIMESLICE - \
> > > > 	MIN_TIMESLICE) * ((n) + 20)) / 39)
> > > >
> > > >
> > > > NICE_TO_TIMESLICE(p->__nice)
> > >
> > > Not sure about this change.  gkrellm shows the compile getting about 40%
> > > cpu.  Best result here seems to be with a larger range of timeslices.  ie
> > > 1-15 ((10*HZ)/1000...) instead lets the compile get 80% of the cpu.
> > > wonder if this might be the way to go?

The above macro is wrong, this is right :

#define NICE_TO_TIMESLICE(n)    (MIN_TIMESLICE + ((MAX_TIMESLICE - \
	MIN_TIMESLICE) * (19 - (n))) / 39)




- Davide


