Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S275752AbSIUQhV>; Sat, 21 Sep 2002 12:37:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S275769AbSIUQhV>; Sat, 21 Sep 2002 12:37:21 -0400
Received: from 198.216-123-194-0.interbaun.com ([216.123.194.198]:14754 "EHLO
	mail.harddata.com") by vger.kernel.org with ESMTP
	id <S275752AbSIUQhT>; Sat, 21 Sep 2002 12:37:19 -0400
Date: Sat, 21 Sep 2002 10:42:13 -0600
From: Wilton Wong <wwong@harddata.com>
To: Nicholas Henke <henken@seas.upenn.edu>
Cc: BProc-users@lists.sourceforge.net, linux-kernel@vger.kernel.org
Subject: Re: [BProc] related oops in 2.4.17 and 2.4.19
Message-ID: <20020921104213.B14274@harddata.com>
Reply-To: Wilton Wong <wwong@harddata.com>
References: <Pine.GSO.4.44.0209211211001.18289-200000@central.cis.upenn.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <Pine.GSO.4.44.0209211211001.18289-200000@central.cis.upenn.edu>; from henken@seas.upenn.edu on Sat, Sep 21, 2002 at 12:20:03 -0400
Organization: Hard Data Ltd.
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Are you running a symbois/LSI based SCSI controller ? just wondering, becaise
we had a whole bunch of "running short of DMA buffer" errors untill we switched
to the newer sym83cxx driver.. we woulget a whole bunch of these errors after a
random amount of disk activity and then boom we would oops.. 

- Wilton

On Sat, 21 Sep 2002, Nicholas Henke wrote:

> I am running both a 2.4.17 and 2.4.19 vanilla patched with bproc. I have 2
> oops traces from klogd, that appear to be related. I am not sure if this
> is a bproc or kernel issue. The kernels have been running on Dell 1550
> PIII Dual machines with 2GB ram and 2GB swap and IBM x330s with the same
> setups. I have seen about 20 machines toss this same oops in the last few
> days, all when under heavy load and memory pressure. After oopsing, the
> machine will remain resonsive and can run processes, baring ps, top,
> shutdown and reboot -- I am sure there are more that won't run :) I would
> greatly appreciate any help -- I have almost 200 machines running these
> kernels. The oopsing has not just started recently -- I have seen it all
> along, but have never been able to get the decoded info from klogd, and it
> is just now becoming a problem with so many machines oopsing.
> 
> Attached is one file with 2 oops reports from klogd.
> Nic
> 
> -- 
> Nicholas Henke
> Linux cluster system programmer
> University of Pennsylvania
> henken@seas.upenn.edu - 215.573.8149

Content-Description: oops traces
> -------- 2.4.17 --------------
> 
> Sep 19 18:49:10 node25 kernel: kernel BUG at page_alloc.c:84!
> Sep 19 18:49:10 node25 kernel: invalid operand: 0000
> Sep 19 18:49:10 node25 kernel: CPU:    1
> Sep 19 18:49:10 node25 kernel: EIP:    0010:[__free_pages_ok+169/832]    Not tainted
> Sep 19 18:49:10 node25 kernel: EIP:    0010:[<c013c0d9>]    Not tainted
> Sep 19 18:49:10 node25 kernel: EFLAGS: 00010286
> Sep 19 18:49:10 node25 kernel: eax: 0000001f   ebx: c1b3ffa0   ecx: c0288424   edx: 000036aa
> Sep 19 18:49:10 node25 kernel: esi: c1b3ffa0   edi: 00000000   ebp: 00000000   esp: c5d8dee0
> Sep 19 18:49:10 node25 kernel: ds: 0018   es: 0018   ss: 0018
> Sep 19 18:49:10 node25 kernel: Process ps (pid: 1326, stackpage=c5d8d000)
> Sep 19 18:49:10 node25 kernel: Stack: c025c74d 00000054 ea5a4a41 e947f35c e947f000 ea5a4000 bfff0018 0000090f
> Sep 19 18:49:10 node25 kernel:        c1b3ffa0 e947f90f e947f90f c0125607 c5d8c000 e947f000 f21a270c c1b3ffa0
> Sep 19 18:49:10 node25 kernel:        e0e9b980 f21a270c e9092000 e947f000 e947f000 c01691fa e9092000 bffff6e5
> Sep 19 18:49:10 node25 kernel: Call Trace: [access_process_vm+439/560] [proc_pid_environ+186/208] [proc_info_read+99/288] [filp_open+77/96] [sys_read+150/208]
> Sep 19 18:49:10 node25 kernel: Call Trace: [<c0125607>] [<c01691fa>] [<c0169653>] [<c01442ed>] [<c0144e76>]
> Sep 19 18:49:10 node25 kernel:    [sys_open+203/304] [system_call+51/56]
> Sep 19 18:49:10 node25 kernel:    [<c01446db>] [<c01078ab>]
> Sep 19 18:49:10 node25 kernel:
> Sep 19 18:49:10 node25 kernel: Code: 0f 0b 5e 5f 8b 43 18 a9 80 00 00 00 74 10 6a 56 68 4d c7 25
> Sep 20 04:02:14 node25 syslogd 1.4.1: restart.
> Sep 20 14:00:00 node25 sshd(pam_unix)[1655]: session opened for user bindu by (uid=0)
> Sep 20 14:27:10 node25 sshd(pam_unix)[1655]: session closed for user bindu
> Sep 20 15:22:51 node25 sshd(pam_unix)[1683]: session opened for user root by (uid=0)
> Sep 20 15:23:37 node25 sshd(pam_unix)[1731]: session opened for user henken by (uid=0)
> Sep 20 15:23:37 node25 sshd(pam_unix)[1731]: session closed for user henken
> Sep 20 15:23:44 node25 sshd(pam_unix)[1739]: session opened for user henken by (uid=0)
> Sep 20 15:23:44 node25 sshd(pam_unix)[1739]: session closed for user henken
> 
> ----------- 2.4.19 ------
> 
> Sep 21 10:15:34 node25.io.liniac.upenn.edu kernel: Warning - running *really* short on DMA buffers
> Sep 21 10:39:10 node25.io.liniac.upenn.edu last message repeated 156 times
> Sep 21 10:39:10 node25.io.liniac.upenn.edu kernel: Unable to handle kernel NULL pointer dereference at virtual address 00000010
> Sep 21 10:39:10 node25.io.liniac.upenn.edu kernel:  printing eip:
> Sep 21 10:39:10 node25.io.liniac.upenn.edu kernel: f89cee23
> Sep 21 10:39:10 node25.io.liniac.upenn.edu kernel: *pde = 00000000
> Sep 21 10:39:10 node25.io.liniac.upenn.edu kernel: Oops: 0000
> Sep 21 10:39:10 node25.io.liniac.upenn.edu kernel: CPU:    1
> Sep 21 10:39:10 node25.io.liniac.upenn.edu kernel: EIP:    0010:[<f89cee23>]    Not tainted
> Sep 21 10:39:10 node25.io.liniac.upenn.edu kernel: EFLAGS: 00010202
> Sep 21 10:39:10 node25.io.liniac.upenn.edu kernel: eax: 00000000   ebx: 00000000   ecx: 00000002   edx: f70c0000
> Sep 21 10:39:10 node25.io.liniac.upenn.edu kernel: esi: f70c0000   edi: 00000000   ebp: ffffffff   esp: daabbe8c
> Sep 21 10:39:10 node25.io.liniac.upenn.edu kernel: ds: 0018   es: 0018   ss: 0018
> Sep 21 10:39:10 node25.io.liniac.upenn.edu kernel: Process ps (pid: 2266, stackpage=daabb000)
> Sep 21 10:39:10 node25.io.liniac.upenn.edu kernel: Stack: c015f525 f70c0000 000002cc 000002cc 00000000 ffffffff 00000004 0000002c
> Sep 21 10:39:10 node25.io.liniac.upenn.edu kernel:        00000000 00000088 00000000 00000002 00000000 00000000 00000000 00000013
> Sep 21 10:39:10 node25.io.liniac.upenn.edu kernel:        00000000 00000000 00000000 004a190c 00000000 00000000 ffffffff 00000000
> Sep 21 10:39:10 node25.io.liniac.upenn.edu kernel: Call Trace:    [proc_pid_stat+629/752] [do_exit+719/736] [proc_info_read+99/288] [sys_read+150/272] [sys_open+87/160]
> Sep 21 10:39:10 node25.io.liniac.upenn.edu kernel: Call Trace:    [<c015f525>] [<c011f86f>] [<c015d0a3>] [<c013de76>] [<c013d827>]
> Sep 21 10:39:10 node25.io.liniac.upenn.edu kernel:   [system_call+51/56]
> Sep 21 10:39:10 node25.io.liniac.upenn.edu kernel:   [<c0108cfb>]
> Sep 21 10:39:10 node25.io.liniac.upenn.edu kernel:
> Sep 21 10:39:10 node25.io.liniac.upenn.edu kernel: Code: 8b 40 10 c3 90 8b 82 94 00 00 00 8b 40 7c c3 89 f6 f6 05 60
> 


 ----[   Wilton William Wong    ]---------------------------------------------
   11060-166 Avenue         Ph : 01-780-456-9771       High Performance UNIX
   Edmonton, Alberta        FAX: 01-780-456-9772        and Linux Solutions
   T5X 1Y3, Canada                   URL: http://www.harddata.com
 -------------------------------------------------------[ Hard Data Ltd. ]----

