Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S286825AbRL1KkC>; Fri, 28 Dec 2001 05:40:02 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S286826AbRL1Kj6>; Fri, 28 Dec 2001 05:39:58 -0500
Received: from thebsh.namesys.com ([212.16.0.238]:32271 "HELO
	thebsh.namesys.com") by vger.kernel.org with SMTP
	id <S286825AbRL1Kjj>; Fri, 28 Dec 2001 05:39:39 -0500
Message-ID: <3C2C4B6A.2010705@namesys.com>
Date: Fri, 28 Dec 2001 13:37:30 +0300
From: Hans Reiser <reiser@namesys.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:0.9.7) Gecko/20011221
X-Accept-Language: en-us
MIME-Version: 1.0
To: Luigi Genoni <kernel@Expansa.sns.it>
CC: Nikita Danilov <Nikita@namesys.com>, linux-kernel@vger.kernel.org,
        Reiserfs mail-list <Reiserfs-List@namesys.com>
Subject: Re: [reiserfs-list] Re: reiserfs does not work with linux 2.4.17 on sparc64 CPUs
In-Reply-To: <Pine.LNX.4.33.0112281058130.30085-100000@Expansa.sns.it>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Luigi Genoni wrote:

>OK, here is my oops
>
>reiserfs: checking transaction log (device 08:14) ...
>Using r5 hash to sort names
>Unsupported unaligned load/store trap for kernel at <000000000059bae8>.
>              \|/ ____ \|/
>              "@'/ .. \`@"
>              /_| \__/ |_\
>                 \__U_/
>mount(38): Kernel does fpu/atomic unaligned load/store.
>TSTATE: 0000004411009603 TPC: 000000000059bae8 TNPC: 000000000059baec Y: 00000000    Not tainted
>g0: 000000000000ff00 g1: 0000000000000142 g2: 0000000000000001 g3: 0000000000000000
>g4: fffff80000000000 g5: 0000000000000002 g6: fffff8006f27c000 g7: 0000000000000140
>o0: 0000000000000000 o1: fffff8006f3241c4 o2: 0000000000000000 o3: 0000000000000073
>o4: 0000000000000073 o5: 0000000000000000 sp: fffff8006f27f1b1 ret_pc: 00000000004ae6dc
>l0: 0000000000000000 l1: fffff8006f1b8000 l2: fffff8006f1b8034 l3: 00000000005a9800
>l4: 00000000019cc780 l5: 00000000005ca7a0 l6: fffff8006f1ba001 l7: 0000000000030000
>i0: fffff8006f324000 i1: fffff8006f3241c4 i2: 0000000000000000 i3: 00000000004ae480
>i4: 0814000000000000 i5: 0000000000000800 i6: fffff8006f27f2a1 i7: 00000000004694b4
>Caller[00000000004694b4]
>Caller[0000000000469c10]
>Caller[000000000047d370]
>Caller[000000000047d688]
>Caller[000000000042da08]
>Caller[0000000000410af4]
>Caller[000000000001274c]
>Instruction DUMP: 9089c005  12600006  8219c005 <c3f25007> 80a1c001
>3267fffb  ce5a4000  81c3e008  8143e00a
>sys32_ioctl(hwclock:47): Unknown cmd fd(3) cmd(00004b50) arg(effff900)
>sys32_ioctl(hwclock:50): Unknown cmd fd(3) cmd(00004b50) arg(effff900)
>
>
>and here are some more data about my system:
>
>storm:{root}:~>cat /proc/cpuinfo
>cpu             : TI UltraSparc II  (BlackBird)
>fpu             : UltraSparc II integrated FPU
>promlib         : Version 3 Revision 25
>prom            : 3.25.0
>type            : sun4u
>ncpus probed    : 1
>ncpus active    : 1
>Cpu0Bogo        : 799.53
>Cpu0ClkTck      : 0000000017d77c6e
>MMU Type        : Spitfire
>
>storm:{root}:/proc>cat scsi/esp/0
>Sparc ESP Host Adapter:
>        PROM node               f006bef4
>        PROM name               SUNW,fas
>        ESP Model               Happy Meal FAS
>        DMA Revision            Rev HME/FAS
>        Live Targets            [ 0 1 6 ]
>
>Target #        config3         Sync Capabilities       Disconnect      Wide
>0               000000c3        [05,04]                 yes             yes
>1               000000c3        [05,04]                 yes             yes
>6               00000081        [05,04]                 yes             no
>
>storm:{root}:/proc>cat scsi/scsi
>Attached devices:
>Host: scsi0 Channel: 00 Id: 00 Lun: 00
>  Vendor: IBM      Model: DNES30917SUN9.0G Rev: SAD0
>  Type:   Direct-Access                    ANSI SCSI revision: 03
>Host: scsi0 Channel: 00 Id: 01 Lun: 00
>  Vendor: IBM      Model: DNES30917SUN9.0G Rev: SAD0
>  Type:   Direct-Access                    ANSI SCSI revision: 03
>Host: scsi0 Channel: 00 Id: 06 Lun: 00
>  Vendor: TOSHIBA  Model: XM5701TASUN12XCD Rev: 0997
>  Type:   CD-ROM                           ANSI SCSI revision: 02
>
>
>storm:{root}:~>cat /proc/meminfo
>        total:    used:    free:  shared: buffers:  cached:
>Mem:  1040752640 627818496 412934144        0 132423680 388440064
>Swap: 1077379072        0 1077379072
>MemTotal:      1016360 kB
>MemFree:        403256 kB
>MemShared:           0 kB
>Buffers:        129320 kB
>Cached:         379336 kB
>SwapCached:          0 kB
>Active:         170272 kB
>Inactive:       376720 kB
>HighTotal:           0 kB
>HighFree:            0 kB
>LowTotal:      1016360 kB
>LowFree:        403256 kB
>SwapTotal:     1052128 kB
>SwapFree:      1052128 kB
>
>storm:{root}:/proc>cat interrupts
>  0:     125738  timer:dead
>  3:     391330  ESP SCSI:7e0
>  5:       5209  Quattro:7d4, HAPPY MEAL:7e1
> 12:       3899  Zilog8530:7e8
> 13:          0  cs4231:7e4
> 15:          0  SYSIO UE:7f4, SYSIO CE:7f5, SYSIO SBUS Error:7f6
>
>storm:{root}:/proc>eeprom
>tpe-link-test?=true
>scsi-initiator-id=7
>keyboard-click?=false
>keymap: data not available.
>sbus-probe-list=e0123
>ttyb-rts-dtr-off=false
>ttyb-ignore-cd=true
>ttya-rts-dtr-off=false
>ttya-ignore-cd=true
>ttyb-mode=9600,8,n,1,-
>ttya-mode=9600,8,n,1,-
>mfg-mode=off
>diag-level=max
>#power-cycles=29
>system-board-serial#=5013132279188
>system-board-date=38bcfa61
>fcode-debug?=false
>output-device=screen
>input-device=keyboard
>load-base=16384
>boot-command=boot
>auto-boot?=true
>watchdog-reboot?=false
>diag-file: data not available.
>diag-device=net
>boot-file: data not available.
>boot-device=linux
>local-mac-address?=false
>ansi-terminal?=true
>screen-#columns=80
>screen-#rows=34
>silent-mode?=false
>use-nvramrc?=true
>nvramrc=devalias linux /sbus/SUNW,fas/sd@0,0:c
>
>security-mode=none
>security-password: data not available.
>security-#badlogins=0
>oem-logo: data not available.
>oem-logo?=false
>oem-banner: data not available.
>oem-banner?=false
>hardware-revision: data not available.
>last-hardware-update: data not available.
>diag-switch?=false
>name=options
>
>2.4.16 does work very well.
>
>Luigi
>
>On Thu, 27 Dec 2001, Nikita Danilov wrote:
>
>>Luigi Genoni writes:
>> > HI,
>> > I just upgraded to kernel 2.4.17 on a ultra2, sparc64, with 2 scsi disks.
>> >
>> > My system was on reiserfs,except for root partition, but the kernel 2.4.17
>> > is unable to mount reiserFS partitions.
>> > At boot i get an oops during the mount, but sincer I have no syslogd
>> > running I am not able to log it. Anyway the message talk about not been
>> > able to load a table map.
>>
>>Can you boot into single user, mount reiserfs partition manually and
>>send decoded oops trace to the reiserfs list
>>(Reiserfs-List@Namesys.COM)?
>>
>> >
>> > gone back (sig!) to 2.4.16
>> >
>> > on x86 processors, instead, reiserfs semms to work as usual
>> >
>> > Luigi
>> >
>>
>>Nikita.
>>--
>>Harry Popper---bespectacled philosopher
>>
>
>
>
can you make use of ksymoops?


