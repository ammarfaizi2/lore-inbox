Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261615AbVGaD6a@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261615AbVGaD6a (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 30 Jul 2005 23:58:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263146AbVGaD6a
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 30 Jul 2005 23:58:30 -0400
Received: from smtp203.mail.sc5.yahoo.com ([216.136.129.93]:59810 "HELO
	smtp203.mail.sc5.yahoo.com") by vger.kernel.org with SMTP
	id S261615AbVGaD5l (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 30 Jul 2005 23:57:41 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
  s=s1024; d=yahoo.com.br;
  h=Received:Message-ID:Date:From:User-Agent:X-Accept-Language:MIME-Version:To:CC:Subject:References:In-Reply-To:X-Enigmail-Version:X-Enigmail-Supports:Content-Type:Content-Transfer-Encoding;
  b=z6JGV9lbYcNyRmhGZnDigp5qpOtCvmNL05tGOp2Z3SXXjvhpJdzH1EXXWcyjMmuIyrZVpOOJ31csH3FPhWguclHJWEs2HxIHen2sBSktQQJMaXrtFklOzEuoFte0uD9fXI2qs3UHVa+vJiSqeNRK/iOHEHx3ADPW5gHSF03F3QA=  ;
Message-ID: <42EC5451.7010907@yahoo.com.br>
Date: Sun, 31 Jul 2005 01:32:17 -0300
From: "Francisco Figueiredo Jr." <fxjrlists@yahoo.com.br>
User-Agent: Mozilla Thunderbird 1.0.2 (X11/20050317)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Andrew Morton <akpm@osdl.org>
CC: linux-kernel@vger.kernel.org
Subject: Re: "seeing minute plus hangs during boot" - 2.6.12 and 2.6.13
References: <20050722182848.8028.qmail@web60715.mail.yahoo.com>	<105c793f05072507426fb6d4c9@mail.gmail.com>	<42E59E0E.5030306@yahoo.com.br>	<20050726003322.1bfe17ee.akpm@osdl.org>	<42E7A153.6060307@yahoo.com.br> <20050727105005.30768fe3.akpm@osdl.org> <42E85E6E.2020105@yahoo.com.br>
In-Reply-To: <42E85E6E.2020105@yahoo.com.br>
X-Enigmail-Version: 0.90.1.0
X-Enigmail-Supports: pgp-inline, pgp-mime
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

Francisco Figueiredo Jr. wrote:

>>>
>>>
> 
> 
> 
> Ok, nevermind. I just found that I didn't add the sysrq support when
> compiling my kernel :(
> 
> I will recompile it and send you stack trace.
> 
> Sorry for wasting your time, Andrew.
> 


Ok, now I have compiled sysrq support on my kernel build.

This is the output I get from dmesg:

dmesg
softirqd/1   S 00000002     0     5      1             6     4 (L-TLB)
df56bf98 00000046 df56bf88 00000002 00000001 00000000 df549f98 c0351b64
       0056bfb8 c03f54d4 00000000 df56a000 c0471fe0 c012335b 00000000
c13fb520
       00000001 0000014b 2b75eb4b 00000000 c146e520 c146a020 c146a148
00000246
Call Trace:
 [<c0351b64>] schedule+0x528/0xc87
 [<c012335b>] tasklet_action+0x63/0xc2
 [<c01235bd>] ksoftirqd+0xc0/0xc2
 [<c01234fd>] ksoftirqd+0x0/0xc2
 [<c013255c>] kthread+0xba/0xf0
 [<c01324a2>] kthread+0x0/0xf0
 [<c01010f1>] kernel_thread_helper+0x5/0xb
events/0      R running     0     6      1             7     5 (L-TLB)
events/1      S 00000002     0     7      1             8     6 (L-TLB)
df47bf38 00000046 df47bf28 00000002 00000001 c0126abd c13fbf60 c13fd118
       00000286 00000001 df503a00 000001f5 df503aa4 df503aa0 00000000
c13fb520
       00000001 00000efd 96972bf1 00000002 c146e520 df595a20 df595b48
00000082
Call Trace:
 [<c0126abd>] __mod_timer+0xa9/0xc3
 [<c012e1c1>] worker_thread+0x15d/0x264
 [<c0146c22>] cache_reap+0x0/0x1e1
 [<c0119b40>] default_wake_function+0x0/0x12
 [<c0119b40>] default_wake_function+0x0/0x12
 [<c012e064>] worker_thread+0x0/0x264
 [<c013255c>] kthread+0xba/0xf0
 [<c01324a2>] kthread+0x0/0xf0
 [<c01010f1>] kernel_thread_helper+0x5/0xb
khelper       S 00000002     0     8      1             9     7 (L-TLB)
df573f38 00000046 df573f24 00000002 00000001 00000001 df511de8 00000001
       df573f10 ffffffff c14b9a20 c13f3520 c14b9a20 00000000 c13fbe80
c13fb520
       00000001 00000e9c 1956ce84 00000002 c14b9a20 df6cf520 df6cf648
00000001
Call Trace:
 [<c012e1c1>] worker_thread+0x15d/0x264
 [<c012dd84>] __call_usermodehelper+0x0/0x61
 [<c0119b40>] default_wake_function+0x0/0x12
 [<c0119b40>] default_wake_function+0x0/0x12
 [<c012e064>] worker_thread+0x0/0x264
 [<c013255c>] kthread+0xba/0xf0
 [<c01324a2>] kthread+0x0/0xf0
 [<c01010f1>] kernel_thread_helper+0x5/0xb
kthread       S 00000002     0     9      1    12     147     8 (L-TLB)
df5bdf38 00000046 df5bdf28 00000002 00000001 00000001 df351f40 00000001
       df5bdf10 c0119b91 c14c2020 00000003 df59f824 df59f820 00000000
c13fb520
       00000001 0000019f f5c02b59 00000000 c146e520 df595520 df595648
00000082
Call Trace:
 [<c0119b91>] __wake_up_common+0x3f/0x5e
 [<c012e1c1>] worker_thread+0x15d/0x264
 [<c0132592>] keventd_create_kthread+0x0/0x71
 [<c0119b40>] default_wake_function+0x0/0x12
 [<c0119b40>] default_wake_function+0x0/0x12
 [<c012e064>] worker_thread+0x0/0x264
 [<c013255c>] kthread+0xba/0xf0
 [<c01324a2>] kthread+0x0/0xf0
 [<c01010f1>] kernel_thread_helper+0x5/0xb
kacpid        S 00000002     0    12      9           101       (L-TLB)
df5bff38 00000046 df5bff28 00000002 00000002 df507e8c c147cd40 00000000
       00000000 00000000 df507e80 df473a00 df473a24 df473a20 00000000
c13f3520
       00000000 000010d9 5eb712c5 00000001 c03a4bc0 df6cf020 df6cf148
00000082
Call Trace:
 [<c012e1c1>] worker_thread+0x15d/0x264
 [<c0236bee>] acpi_os_execute_deferred+0x0/0x1b
 [<c0119b40>] default_wake_function+0x0/0x12
 [<c0119b40>] default_wake_function+0x0/0x12
 [<c012e064>] worker_thread+0x0/0x264
 [<c013255c>] kthread+0xba/0xf0
 [<c01324a2>] kthread+0x0/0xf0
 [<c01010f1>] kernel_thread_helper+0x5/0xb
kblockd/0     S 00000002     0   101      9           102    12 (L-TLB)
c1605f38 00000046 c1605f24 00000002 00000002 00000080 00000080 00000000
       00000001 00000000 df69ba20 c13fb520 df69ba20 00000000 c13f3e80
c13f3520
       00000000 00000174 051d5e48 00000000 df69ba20 df595020 df595148
00000002
Call Trace:
 [<c012e064>] worker_thread+0x0/0x264
 [<c012e1c1>] worker_thread+0x15d/0x264
 [<c0119b40>] default_wake_function+0x0/0x12
 [<c0119b40>] default_wake_function+0x0/0x12
 [<c012e064>] worker_thread+0x0/0x264
 [<c013255c>] kthread+0xba/0xf0
 [<c01324a2>] kthread+0x0/0xf0
 [<c01010f1>] kernel_thread_helper+0x5/0xb
kblockd/1     S 00000002     0   102      9           145   101 (L-TLB)
c1607f38 00000046 c1607f28 00000002 00000001 051d669d 00000000 00000000
       00000001 00000100 00000080 00000080 00000000 00000000 c047fd4c
c13fb520
       00000001 00000161 051d9968 00000000 c146e520 df69ba20 df69bb48
df69be94
Call Trace:
 [<c012e064>] worker_thread+0x0/0x264
 [<c012e1c1>] worker_thread+0x15d/0x264
 [<c0119b40>] default_wake_function+0x0/0x12
 [<c0119b40>] default_wake_function+0x0/0x12
 [<c012e064>] worker_thread+0x0/0x264
 [<c013255c>] kthread+0xba/0xf0
 [<c01324a2>] kthread+0x0/0xf0
 [<c01010f1>] kernel_thread_helper+0x5/0xb
pdflush       S 00000002     0   145      9           146   102 (L-TLB)
c1609f78 00000046 c1609f64 00000002 00000002 c13fbe80 00000001 c1609f38
       df5956e0 00000000 df69b520 c13fb520 df69b520 00000000 c13f3e80
c13f3520
       00000000 000000d6 058d6c60 00000000 df69b520 df5daa20 df5dab48
00000002
Call Trace:
 [<c0144711>] pdflush+0x0/0x2c
 [<c01445f6>] __pdflush+0x82/0x19d
 [<c0144739>] pdflush+0x28/0x2c
 [<c0144711>] pdflush+0x0/0x2c
 [<c013255c>] kthread+0xba/0xf0
 [<c01324a2>] kthread+0x0/0xf0
 [<c01010f1>] kernel_thread_helper+0x5/0xb
pdflush       S 00000002     0   146      9           148   145 (L-TLB)
c160bf78 00000046 c160bf68 00000002 00000002 c03aabdc fffeeb11 fffec8e3
       c146e6e0 00000000 00000000 c160bf24 00000400 00000000 00000000
c13f3520
       00000000 00000966 f0c34ef0 00000001 c03a4bc0 df69b520 df69b648
00000093
Call Trace:
 [<c0144711>] pdflush+0x0/0x2c
 [<c01445f6>] __pdflush+0x82/0x19d
 [<c0144739>] pdflush+0x28/0x2c
 [<c0144711>] pdflush+0x0/0x2c
 [<c013255c>] kthread+0xba/0xf0
 [<c01324a2>] kthread+0x0/0xf0
 [<c01010f1>] kernel_thread_helper+0x5/0xb
kswapd0       S 00000002     0   147      1           810     9 (L-TLB)
c160df80 00000046 c160df70 00000002 00000002 c160c000 c012ee27 00000002
       c012ec86 df69b10c 00000282 c011ab4d 00000000 c011fcd6 c03a9060
c13f3520
       00000000 00001f47 058e3fea 00000000 c03a4bc0 df69b020 df69b148
00000246
Call Trace:
 [<c012ee27>] detach_pid+0x15/0x5a
 [<c012ec86>] attach_pid+0x26/0xd6
 [<c011ab4d>] set_cpus_allowed+0xc2/0x15b
 [<c011fcd6>] exit_fs+0x3b/0x108
 [<c0149d1e>] kswapd+0x11f/0x138
 [<c0132a02>] autoremove_wake_function+0x0/0x57
 [<c0102d8e>] ret_from_fork+0x6/0x14
 [<c0132a02>] autoremove_wake_function+0x0/0x57
 [<c0149bff>] kswapd+0x0/0x138
 [<c01010f1>] kernel_thread_helper+0x5/0xb
aio/0         S 00000002     0   148      9           149   146 (L-TLB)
c160ff38 00000046 c160ff24 00000002 00000002 00000080 00000080 00000000
       00000001 00000000 df662a20 c13fb520 df662a20 00000000 c13f3e80
c13f3520
       00000000 0000012c 058eb1f5 00000000 df662a20 df5da520 df5da648
00000002
Call Trace:
 [<c012e064>] worker_thread+0x0/0x264
 [<c012e1c1>] worker_thread+0x15d/0x264
 [<c0119b40>] default_wake_function+0x0/0x12
 [<c0119b40>] default_wake_function+0x0/0x12
 [<c012e064>] worker_thread+0x0/0x264
 [<c013255c>] kthread+0xba/0xf0
 [<c01324a2>] kthread+0x0/0xf0
 [<c01010f1>] kernel_thread_helper+0x5/0xb
aio/1         S 00000002     0   149      9           736   148 (L-TLB)
c1611f38 00000046 c1611f28 00000002 00000001 058eba93 00000000 00000000
       00000001 00000100 00000080 00000080 00000000 00000000 c047fd4c
c13fb520
       00000001 00000156 058eeb0b 00000000 c146e520 df662a20 df662b48
df662e94
Call Trace:
 [<c012e064>] worker_thread+0x0/0x264
 [<c012e1c1>] worker_thread+0x15d/0x264
 [<c0119b40>] default_wake_function+0x0/0x12
 [<c0119b40>] default_wake_function+0x0/0x12
 [<c012e064>] worker_thread+0x0/0x264
 [<c013255c>] kthread+0xba/0xf0
 [<c01324a2>] kthread+0x0/0xf0
 [<c01010f1>] kernel_thread_helper+0x5/0xb
kseriod       S 00000002     0   736      9           995   149 (L-TLB)
c1677f60 00000046 c1677f50 00000002 00000001 ffffffea c0401e48 00000000
       c0401e48 00000000 c02156f0 c0401e78 c02156c8 c027e2ab c0401e60
c13fb520
       00000001 00000cad d0e34170 00000000 c146e520 df662520 df662648
00000246
Call Trace:
 [<c02156f0>] kobject_put+0x1e/0x22
 [<c02156c8>] kobject_release+0x0/0xa
 [<c027e2ab>] driver_create_file+0x4b/0x59
 [<c0272746>] serio_thread+0x7b/0xef
 [<c0132a02>] autoremove_wake_function+0x0/0x57
 [<c0132a02>] autoremove_wake_function+0x0/0x57
 [<c02726cb>] serio_thread+0x0/0xef
 [<c013255c>] kthread+0xba/0xf0
 [<c01324a2>] kthread+0x0/0xf0
 [<c01010f1>] kernel_thread_helper+0x5/0xb
kirqd         S 00000002     0   810      1          1122   147 (L-TLB)
c16f5f94 00000046 c16f5f84 00000002 00000002 c16f5fa8 00000046 c16f5f98
       00000002 00000002 df662020 df662020 c011f39c df662020 df662020
c13f3520
       00000000 000005f1 ebc2437a 00000001 c03a4bc0 df662020 df662148
c13f3f60
Call Trace:
 [<c011f39c>] release_task+0xc5/0x156
 [<c0352a74>] schedule_timeout+0x54/0xa2
 [<c01274ce>] process_timeout+0x0/0x9
 [<c0114743>] balanced_irq+0x4c/0x81
 [<c01146f7>] balanced_irq+0x0/0x81
 [<c01010f1>] kernel_thread_helper+0x5/0xb
khubd         S 00000002     0   995      9                 736 (L-TLB)
df32df64 00000046 df32df54 00000002 00000002 00000282 c02176e9 00000000
       e0062cac 00000282 c1738d80 c1738d80 00000005 c02156f0 c14f149c
c13f3520
       00000000 00000683 ef580375 00000000 c03a4bc0 df2d5020 df2d5148
00000246
Call Trace:
 [<c02176e9>] rwsem_wake+0x59/0x13a
 [<c02156f0>] kobject_put+0x1e/0x22
 [<e004deec>] hub_thread+0x9e/0xe5 [usbcore]
 [<c0132a02>] autoremove_wake_function+0x0/0x57
 [<c0132a02>] autoremove_wake_function+0x0/0x57
 [<e004de4e>] hub_thread+0x0/0xe5 [usbcore]
 [<c013255c>] kthread+0xba/0xf0
 [<c01324a2>] kthread+0x0/0xf0
 [<c01010f1>] kernel_thread_helper+0x5/0xb
scsi_eh_0     S 00000002     0  1122      1          1123   810 (L-TLB)
df34ff68 00000046 df34ff58 00000002 00000001 00000000 00000001 df34ff28
       00000002 c14c2520 c14c264c df34ff38 00000000 00000000 df34ff98
c13fb520
       00000001 000006f7 ef5952f8 00000000 c146e520 c14c2520 c14c2648
00000001
Call Trace:
 [<c0351553>] __down_interruptible+0x94/0x119
 [<c0119b40>] default_wake_function+0x0/0x12
 [<c0119cf1>] complete+0x48/0x5d
 [<c03515eb>] __down_failed_interruptible+0x7/0xc
 [<c02bacb2>] .text.lock.scsi_error+0x3b/0x41
 [<c02ba703>] scsi_error_handler+0x0/0xd2
 [<c01010f1>] kernel_thread_helper+0x5/0xb
usb-storage   S C13F39D8     0  1123      1          1170  1122 (L-TLB)
df2bff50 00000046 c146aa20 c13f39d8 00000002 df2bff14 c01178bb 195a8560
       00000002 00000001 c146aa20 c13fb520 c146aa20 00000000 c13f3e80
c13f3520
       00000000 0000018e 195a872b 00000002 c146aa20 df2d5a20 df2d5b48
00000002
Call Trace:
 [<c01178bb>] activate_task+0x93/0xa7
 [<c0351553>] __down_interruptible+0x94/0x119
 [<c0119b40>] default_wake_function+0x0/0x12
 [<c0118255>] wake_up_process+0x1e/0x20
 [<c03515eb>] __down_failed_interruptible+0x7/0xc
 [<e0067a8c>] .text.lock.usb+0x17/0x83 [usb_storage]
 [<c0102d8e>] ret_from_fork+0x6/0x14
 [<e0066f27>] usb_stor_control_thread+0x0/0x1d7 [usb_storage]
 [<e0066f27>] usb_stor_control_thread+0x0/0x1d7 [usb_storage]
 [<c01010f1>] kernel_thread_helper+0x5/0xb
khpsbpkt      S 00000002     0  1170      1          1224  1123 (L-TLB)
df3f1f8c 00000046 df3f1f7c 00000002 00000002 00000000 c16a4bcc c043c380
       00f89f60 00f81f60 000000b7 c015d27b 00000080 00000000 00000069
c13f3520
       00000000 00000131 403a92a2 00000001 c03a4bc0 df532520 df532648
00000001
Call Trace:
 [<c015d27b>] __fput+0x136/0x1a1
 [<c0351553>] __down_interruptible+0x94/0x119
 [<c0119b40>] default_wake_function+0x0/0x12
 [<c0119cf1>] complete+0x48/0x5d
 [<c03515eb>] __down_failed_interruptible+0x7/0xc
 [<e008aa86>] .text.lock.ieee1394_core+0x1b/0x21 [ieee1394]
 [<e008a9b3>] hpsbpkt_thread+0x0/0x9c [ieee1394]
 [<c01010f1>] kernel_thread_helper+0x5/0xb
knodemgrd_0   S 00000002     0  1224      1          1312  1170 (L-TLB)
c1485f74 00000046 c1485f64 00000002 00000001 df2c6300 df2d0178 00000000
       c01952fe df594a00 000000d0 df2c6300 0000a1ff 00000000 c0195377
c13fb520
       00000001 0000054f 403ac756 00000001 c146e520 c16df020 c16df148
df2d0178
Call Trace:
 [<c01952fe>] sysfs_new_dirent+0x28/0x76
 [<c0195377>] sysfs_make_dirent+0x2b/0x98
 [<c0351553>] __down_interruptible+0x94/0x119
 [<c0119b40>] default_wake_function+0x0/0x12
 [<c03515eb>] __down_failed_interruptible+0x7/0xc
 [<e00913e0>] .text.lock.nodemgr+0x112/0x19e [ieee1394]
 [<e0090e43>] nodemgr_host_thread+0x0/0x178 [ieee1394]
 [<c01010f1>] kernel_thread_helper+0x5/0xb
udev          S 00000002     0  1312      1                1224 (NOTLB)
c1653f4c 00000082 c1653f3c 00000002 00000001 00000040 c1653f64 c1653f0c
       c016611b bfec96a8 c1653f0c 00000040 00000000 00000361 000241ed
c13fb520
       00000001 00001a7e 98f9769f 00000002 c146e520 df5da020 df5da148
c13fbf60
Call Trace:
 [<c016611b>] cp_new_stat+0x15f/0x17a
 [<c0352a74>] schedule_timeout+0x54/0xa2
 [<c01274ce>] process_timeout+0x0/0x9
 [<c01275c4>] sys_nanosleep+0xdd/0x18e
 [<c0102e85>] syscall_call+0x7/0xb



Thanks, Andrew.



- --
Regards,

Francisco Figueiredo Jr.
Npgsql Lead Developer
http://gborg.postgresql.org/project/npgsql
MonoBrasil Project Founder Member
http://monobrasil.softwarelivre.org


- -------------
"Science without religion is lame;
religion without science is blind."

                  ~ Albert Einstein
-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.6 (GNU/Linux)
Comment: Using GnuPG with Thunderbird - http://enigmail.mozdev.org

iQEVAwUBQuxUUP7iFmsNzeXfAQImgAgAlPs2iXwos80Qpnd23EU+TADa0lVIG44E
IFb1vRacT7GNE8d33UXFg39HkLLm/Po/0IPX4DeaM0W7Rty5JYijCCqEo9sX5w81
i15Vq1PGIcpLZugrDXij29EHz1KXK5fWRMdMxsD69Ey7sg2+/Tfp/tpPjsPtKrAn
31hA6reiRPtnr6IjCT3cXJ/0ephsMiCZeEJQP3P9kXWbRv2lmu3wQkH2RB2k20fK
A4cNz+j2tFaM0Pd/+f7LLqHI9qSPK0w2QaIf5VdUJjV7Dj+xNyFzavBpvI+v0nq/
ljECRvzGkptYAXIaNAbig/mVfENevzbzu6MN+jTrfulhCvGujs5oWw==
=Arox
-----END PGP SIGNATURE-----

	
	
		
_______________________________________________________ 
Yahoo! Acesso Grátis - Internet rápida e grátis. 
Instale o discador agora! http://br.acesso.yahoo.com/
