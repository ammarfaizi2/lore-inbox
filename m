Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262176AbVHAAYz@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262176AbVHAAYz (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 31 Jul 2005 20:24:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262187AbVHAAYz
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 31 Jul 2005 20:24:55 -0400
Received: from smtp200.mail.sc5.yahoo.com ([216.136.130.125]:46944 "HELO
	smtp200.mail.sc5.yahoo.com") by vger.kernel.org with SMTP
	id S262176AbVHAAYx (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 31 Jul 2005 20:24:53 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
  s=s1024; d=yahoo.com.br;
  h=Received:Message-ID:Date:From:User-Agent:X-Accept-Language:MIME-Version:To:CC:Subject:References:In-Reply-To:X-Enigmail-Version:X-Enigmail-Supports:Content-Type:Content-Transfer-Encoding;
  b=iul0Q/kjBVYfckr4/zR8KfL0xl1qHjQoTxmkr78Qw+HyREatO1C6d3nUQc/W8ZJkcw1A23yqH7HEY0gWF/xDT75M42UUWKPTpVhUCiP9vTyF37yYAPiN8Xv5Vjcq9IKGeupz35dFm0QboYDTtFfBtqkGfJ3Y/mKD0lPCs3w2XJU=  ;
Message-ID: <42ED73EE.4020208@yahoo.com.br>
Date: Sun, 31 Jul 2005 21:59:26 -0300
From: "Francisco Figueiredo Jr." <fxjrlists@yahoo.com.br>
User-Agent: Mozilla Thunderbird 1.0.2 (X11/20050317)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Greg KH <greg@kroah.com>
CC: Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org
Subject: Re: "seeing minute plus hangs during boot" - 2.6.12 and 2.6.13
References: <42E59E0E.5030306@yahoo.com.br> <20050726003322.1bfe17ee.akpm@osdl.org> <42E7A153.6060307@yahoo.com.br> <20050727105005.30768fe3.akpm@osdl.org> <42E85E6E.2020105@yahoo.com.br> <42EC5451.7010907@yahoo.com.br> <20050730222624.73337021.akpm@osdl.org> <42EC6BAB.5020106@yahoo.com.br> <20050730224437.4088ba70.akpm@osdl.org> <42EC73B2.8020400@yahoo.com.br> <20050731063819.GA28899@kroah.com>
In-Reply-To: <20050731063819.GA28899@kroah.com>
X-Enigmail-Version: 0.90.1.0
X-Enigmail-Supports: pgp-inline, pgp-mime
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

Greg KH wrote:

>>>>Now, I'm thinking it could be something like the udev hang which
>>>>disapeared with udev update to 058.
>>>>
>>>>I don't know what can be happening. I think it is because of some type
>>>>of timeout.
>>>>
>>>>If you think there is something else I can do, please let me know.
>>>>
>>>
>>>
>>>Greg said in another thread: "older versions of udev (< 058) can work
>>>_really slow_ with 2.6.12.  Please upgrade your version of udev and see if
>>>that solves the issue or not.".
>>>
>>>What version are you running?   Looks like 058, yes?
>>
>>
>>Yeap. It is 058.
> 
> 
> Hm, odd.  Well, as this is a udev issue, care to try 064?  We've fixed a
> lot of little bugs since 058 that might have caused this.
> 
> thanks,
> 

Hi Greg.

No luck. I installed 0.64 and I get the same hang on mounting
filesystems message.

Here is what I get with dmesg with 0.64:

dmesg
 4 (L-TLB)
df56bf98 00000046 df56bf88 00000002 00000001 c0476004 df56a000 c012f2dd
       c03a9380 c03a9480 c13fd020 c13fd04c 00000000 c012335b 00000000
c13fb520
       00000001 00000971 2d819d9f 00000000 c146e520 c146a020 c146a148
00000246
Call Trace:
 [<c012f2dd>] rcu_process_callbacks+0x5d/0x69
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
       00000001 00000ccd 0df51400 00000003 c146e520 df595a20 df595b48
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
df573f38 00000046 df573f24 00000002 00000001 00000001 c17b7de8 00000001
       df573f10 ffffffff df301520 c13f3520 df301520 00000000 c13fbe80
c13fb520
       00000001 00000204 17a8ee41 00000002 df301520 df6cf520 df6cf648
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
df5bdf38 00000046 df5bdf28 00000002 00000001 00000001 df393f40 00000001
       df5bdf10 c0119b91 df42a020 00000003 df59f824 df59f820 00000000
c13fb520
       00000001 0000019f f4136c6b 00000000 c146e520 df595520 df595648
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
       00000000 00001003 46a6eae8 00000001 c03a4bc0 df6cf020 df6cf148
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
c1605f38 00000046 c1605f24 00000002 00000002 052afe93 00000000 00000000
       00000001 00000000 df69ba20 c13fb520 df69ba20 00000000 c13f3e80
c13f3520
       00000000 00000171 052b5d95 00000000 df69ba20 df595020 df595148
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
c1607f38 00000046 c1607f28 00000002 00000001 052b66d1 00000000 00000000
       00000001 00000100 00000000 00000000 00000000 00000000 c047fd4c
c13fb520
       00000001 00000174 052b992c 00000000 c146e520 df69ba20 df69bb48
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
       00000000 000000d8 059b4ae7 00000000 df69b520 df5daa20 df5dab48
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
c160bf78 00000046 c160bf68 00000002 00000002 c03aabdc fffeeee0 fffeccb2
       c146e6e0 00000000 00000000 c160bf24 00000400 00000000 00000000
c13f3520
       00000000 00000462 3507d618 00000003 c03a4bc0 df69b520 df69b648
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
       00000000 00001e01 059c1c48 00000000 c03a4bc0 df69b020 df69b148
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
       00000000 00000176 059c9043 00000000 df662a20 df5da520 df5da648
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
c1611f38 00000046 c1611f28 00000002 00000001 059c9d6b 00000000 00000000
       00000001 00000100 00000080 00000080 00000000 00000000 c047fd4c
c13fb520
       00000001 00000162 059ccb3e 00000000 c146e520 df662a20 df662b48
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
c1653f60 00000046 c1653f50 00000002 00000001 ffffffea c0401e48 00000000
       c0401e48 00000000 c02156f0 c0401e78 c02156c8 c027e2ab c0401e60
c13fb520
       00000001 00000f39 d0da3f78 00000000 c146e520 df5da020 df5da148
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
c1695f94 00000046 c1695f84 00000002 00000001 c1695fa8 00000046 c1695f98
       00000002 00000001 df5dda20 df5dda20 c011f39c df5dda20 df5dda20
c13fb520
       00000001 00000675 15579db8 00000003 c146e520 df5dda20 df5ddb48
c13fbf60
Call Trace:
 [<c011f39c>] release_task+0xc5/0x156
 [<c0352a74>] schedule_timeout+0x54/0xa2
 [<c01274ce>] process_timeout+0x0/0x9
 [<c0114743>] balanced_irq+0x4c/0x81
 [<c01146f7>] balanced_irq+0x0/0x81
 [<c01010f1>] kernel_thread_helper+0x5/0xb
khubd         S 00000002     0   995      9                 736 (L-TLB)
df347f64 00000046 df347f54 00000002 00000002 00000282 c02176e9 00000000
       e0062cac 00000282 c1684880 c1684880 00000005 c02156f0 c16c269c
c13f3520
       00000000 000008d3 edaeb33c 00000000 c03a4bc0 c1719020 c1719148
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
df38ff68 00000046 df38ff58 00000002 00000001 00000000 00000001 df38ff28
       00000002 df42aa20 df42ab4c df38ff38 00000000 00000000 df38ff98
c13fb520
       00000001 00000d3b edaffec8 00000000 c146e520 df42aa20 df42ab48
00000001
Call Trace:
 [<c0351553>] __down_interruptible+0x94/0x119
 [<c0119b40>] default_wake_function+0x0/0x12
 [<c0119cf1>] complete+0x48/0x5d
 [<c03515eb>] __down_failed_interruptible+0x7/0xc
 [<c02bacb2>] .text.lock.scsi_error+0x3b/0x41
 [<c02ba703>] scsi_error_handler+0x0/0xd2
 [<c01010f1>] kernel_thread_helper+0x5/0xb
usb-storage   S C13F3560     0  1123      1          1170  1122 (L-TLB)
df323f50 00000046 c146aa20 c13f3560 00000002 df323f14 c01178bb 17ac7305
       00000002 00000001 c146aa20 c13fb520 c146aa20 00000000 c13f3e80
c13f3520
       00000000 00000186 17ac74c0 00000002 c146aa20 df301a20 df301b48
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
df3d5f8c 00000046 df3d5f7c 00000002 00000002 00000000 00000000 00000000
       00f89f60 00f81f60 000000b7 c13fb520 00000080 00000000 00000069
c13f3520
       00000000 0000013c 3e8fad7c 00000001 c03a4bc0 df300520 df300648
00000001
Call Trace:
 [<c0351553>] __down_interruptible+0x94/0x119
 [<c0119b40>] default_wake_function+0x0/0x12
 [<c0119cf1>] complete+0x48/0x5d
 [<c03515eb>] __down_failed_interruptible+0x7/0xc
 [<e008aa86>] .text.lock.ieee1394_core+0x1b/0x21 [ieee1394]
 [<e008a9b3>] hpsbpkt_thread+0x0/0x9c [ieee1394]
 [<c01010f1>] kernel_thread_helper+0x5/0xb
knodemgrd_0   S 00000002     0  1224      1          1336  1170 (L-TLB)
df2c3f74 00000046 df2c3f64 00000002 00000001 c16abca0 df3366f0 00000000
       c01952fe df594a00 000000d0 c16abca0 0000a1ff 00000000 c0195377
c13fb520
       00000001 00000505 3e8fe075 00000001 c146e520 df406020 df406148
df3366f0
Call Trace:
 [<c01952fe>] sysfs_new_dirent+0x28/0x76
 [<c0195377>] sysfs_make_dirent+0x2b/0x98
 [<c0351553>] __down_interruptible+0x94/0x119
 [<c0119b40>] default_wake_function+0x0/0x12
 [<c03515eb>] __down_failed_interruptible+0x7/0xc
 [<e00913e0>] .text.lock.nodemgr+0x112/0x19e [ieee1394]
 [<e0090e43>] nodemgr_host_thread+0x0/0x178 [ieee1394]
 [<c01010f1>] kernel_thread_helper+0x5/0xb
udev          S 00000002     0  1336      1                1224 (NOTLB)
c1713f4c 00000086 c1713f3c 00000002 00000002 00000040 c1713f64 c1713f0c
       c016611b bfc8a598 c1713f0c 00000040 00000000 00000361 000241ed
c13f3520
       00000000 0003e6ae 4b23fc5a 00000003 c03a4bc0 df662520 df662648
c13f3f60
Call Trace:
 [<c016611b>] cp_new_stat+0x15f/0x17a
 [<c0352a74>] schedule_timeout+0x54/0xa2
 [<c01274ce>] process_timeout+0x0/0x9
 [<c01275c4>] sys_nanosleep+0xdd/0x18e
 [<c0102e85>] syscall_call+0x7/0xb


Thanks for help.


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

iQEVAwUBQu1z7v7iFmsNzeXfAQLERwf/SfC3JX51I5EGoETI820LHnmLKutwPHjr
pHpw1E6h+ats7b1krRAoPWrJb3mFbQXFzcjtgxgrlY1KB1CCEZO9ZbPBvDJKP6de
vORMk030sNqSGP4BK2R6aVxyQtNT6JTVX1wJ6jryvZh1JIQT1a2zQ699MWQElN8N
tTJ8PS8FVEUkH8qqqUoYropi+GCkj3xQpYMDorfNWw30gwKNuzA2CQ9Tontbmfnk
00k87dQnF0lHuHdnnyxSFzFvkhDjSevKwjo9k5Gv/AmRSlMY/TCpTQm/fXTmpX2v
wDv5W9xKnzyYZmAoCIWZIp30+baL8BzhtbUeIIm6hBpkkut5La+vBw==
=rXuy
-----END PGP SIGNATURE-----

	
	
		
_______________________________________________________ 
Yahoo! Acesso Grátis - Internet rápida e grátis. 
Instale o discador agora! http://br.acesso.yahoo.com/
