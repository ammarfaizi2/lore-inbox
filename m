Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S311750AbSCUN1u>; Thu, 21 Mar 2002 08:27:50 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S311782AbSCUN1k>; Thu, 21 Mar 2002 08:27:40 -0500
Received: from adsl-196-233.cybernet.ch ([212.90.196.233]:42731 "HELO
	mailphish.drugphish.ch") by vger.kernel.org with SMTP
	id <S311750AbSCUN1a>; Thu, 21 Mar 2002 08:27:30 -0500
Message-ID: <3C99DFB9.2090800@drugphish.ch>
Date: Thu, 21 Mar 2002 14:27:21 +0100
From: Roberto Nibali <ratz@drugphish.ch>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:0.9.9) Gecko/20020306
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Jens Axboe <axboe@suse.de>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [PATCH][CFT] CD-MRW (Mt Rainier) support
In-Reply-To: <20020321131201.GF2109@suse.de>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello Jens,

> diff -ur -X /usr/src/exclude /opt/kernel/linux-2.4.19-pre4/drivers/ide/ide-cd.c linux/drivers/ide/ide-cd.c
> --- /opt/kernel/linux-2.4.19-pre4/drivers/ide/ide-cd.c	Thu Mar 21 12:53:28 2002
> +++ linux/drivers/ide/ide-cd.c	Thu Mar 21 13:38:34 2002
> @@ -292,9 +292,13 @@
>   *			  correctly reporting tray status -- from
>   *			  Michael D Johnson <johnsom@orst.edu>
>   *
> + * 4.60  Mar 21, 2002	- Add mt rainier support
> + *			- Bump timeout value for packet commands
> + *			- Odd stuff

Do you think you've fixed that oops too? I can reproduce this on 
2.4.19-pre2-ac3 kernel by setting 'append = "hdb=noprobe hdb=cdrom"'
in lilo.conf and after booting doing a 'cat /dev/hdb | od' without
having a medium in the DVD drive. BTW 2.5.x crashes horribly when I 
enable this append line in /etc/lilo.conf. I haven't had time to track 
this down yet, so you might as well give it a whirl. I've got 
CONFIG_BLK_DEV_PIIX=y and CONFIG_PIIX_TUNING=y. More of the .config upon 
request.

Unable to handle kernel NULL pointer dereference at virtual address 00000063
c01a9300
*pde = 00000000
Oops: 0000
CPU:    0
EIP:    0010:[<c01a9300>]    Not tainted
Using defaults from ksymoops -t elf32-i386 -a i386
EFLAGS: 00010246
eax: c02a86ac   ebx: 00000000   ecx: 00000006   edx: 00000004
esi: 00000005   edi: c02a86ac   ebp: 00000001   esp: df1f5edc
ds: 0018   es: 0018   ss: 0018
Process modprobe (pid: 584, stackpage=df1f5000)
Stack: c02a86ac 00000286 e285a820 c01a9347 c02a86ac c01a5e03 00000004 
c02a86ac
        00000007 c02a86ac df975e00 c02a86ac 00000001 e285799d c02a86ac 
e285a820
        00000001 e2854000 00000001 00000001 000068a0 c0115c1d df1f4000 
08053c1b
Call Trace: [<e285a820>] [<c01a9347>] [<c01a5e03>] [<e285799d>] 
[<e285a820>]
    [<c0115c1d>] [<e2854060>] [<c0106bb3>] [<c020002b>]
Code: f6 43 63 08 75 06 f6 43 6a 02 74 0e be 07 00 00 00 57 e8 15

 >>EIP; c01a9300 <config_drive_xfer_rate+b0/e4>   <=====
Trace; e285a820 <[ide-cd]ide_cdrom_driver+0/50>
Trace; c01a9346 <piix_dmaproc+12/2c>
Trace; c01a5e02 <ide_register_subdriver+9e/fc>
Trace; e285799c <[ide-cd]init_module+94/196>
Trace; e285a820 <[ide-cd]ide_cdrom_driver+0/50>
Trace; c0115c1c <sys_init_module+504/5a8>
Trace; e2854060 <[ide-cd]__module_license+0/0>
Trace; c0106bb2 <system_call+32/38>
Trace; c020002a <number+12a/43c>
Code;  c01a9300 <config_drive_xfer_rate+b0/e4>
00000000 <_EIP>:
Code;  c01a9300 <config_drive_xfer_rate+b0/e4>   <=====
    0:   f6 43 63 08               testb  $0x8,0x63(%ebx)   <=====
Code;  c01a9304 <config_drive_xfer_rate+b4/e4>
    4:   75 06                     jne    c <_EIP+0xc> c01a930c 
<config_drive_xfer_rate+bc/e4>
Code;  c01a9306 <config_drive_xfer_rate+b6/e4>
    6:   f6 43 6a 02               testb  $0x2,0x6a(%ebx)
Code;  c01a930a <config_drive_xfer_rate+ba/e4>
    a:   74 0e                     je     1a <_EIP+0x1a> c01a931a 
<config_drive_xfer_rate+ca/e4>
Code;  c01a930c <config_drive_xfer_rate+bc/e4>
    c:   be 07 00 00 00            mov    $0x7,%esi
Code;  c01a9310 <config_drive_xfer_rate+c0/e4>
   11:   57                        push   %edi
Code;  c01a9312 <config_drive_xfer_rate+c2/e4>
   12:   e8 15 00 00 00            call   2c <_EIP+0x2c> c01a932c 
<config_drive_xfer_rate+dc/e4>

  <1>Unable to handle kernel NULL pointer dereference at virtual address 
0000000ce2857543
*pde = 00000000
Oops: 0000
CPU:    0
EIP:    0010:[<e2857543>]    Not tainted
EFLAGS: 00010206
eax: e2857524   ebx: 00000000   ecx: df2a8000   edx: e285a820
esi: c02a86ac   edi: fffffff4   ebp: 00000340   esp: df2a9ef4
ds: 0018   es: 0018   ss: 0018
Process cat (pid: 582, stackpage=df2a9000)
Stack: c02a86ac df2164c0 dfe512bc c01a3b55 df2164c0 df3adbe0 c02a86ac 
dfe512a0
        00000340 c0136ea5 df2164c0 df3adbe0 df2164c0 df3adbe0 ffffffe9 
dffe7320
        00000000 c0136ff6 dfe512a0 df2164c0 df3adbe0 df2164c0 df3adbe0 
df2164c0
Call Trace: [<c01a3b55>] [<c0136ea5>] [<c0136ff6>] [<c0130f15>] 
[<c0130e2a>]
    [<c013115a>] [<c0106bb3>]
Code: 83 7b 0c 00 75 19 68 f0 01 00 00 68 00 00 01 00 e8 38 18 8d

 >>EIP; e2857542 <[ide-cd]ide_cdrom_open+1e/70>   <=====
Trace; c01a3b54 <ide_open+cc/fc>
Trace; c0136ea4 <do_open+94/14c>
Trace; c0136ff6 <blkdev_open+22/28>
Trace; c0130f14 <dentry_open+e0/188>
Trace; c0130e2a <filp_open+52/5c>
Trace; c013115a <sys_open+36/98>
Trace; c0106bb2 <system_call+32/38>
Code;  e2857542 <[ide-cd]ide_cdrom_open+1e/70>
00000000 <_EIP>:
Code;  e2857542 <[ide-cd]ide_cdrom_open+1e/70>   <=====
    0:   83 7b 0c 00               cmpl   $0x0,0xc(%ebx)   <=====
Code;  e2857546 <[ide-cd]ide_cdrom_open+22/70>
    4:   75 19                     jne    1f <_EIP+0x1f> e2857560 
<[ide-cd]ide_cdrom_open+3c/70>
Code;  e2857548 <[ide-cd]ide_cdrom_open+24/70>
    6:   68 f0 01 00 00            push   $0x1f0
Code;  e285754c <[ide-cd]ide_cdrom_open+28/70>
    b:   68 00 00 01 00            push   $0x10000
Code;  e2857552 <[ide-cd]ide_cdrom_open+2e/70>
   10:   e8 38 18 8d 00            call   8d184d <_EIP+0x8d184d> 
e3128d8e <END_OF_CODE+8ce4f0/????>

Cheers,
Roberto Nibali, ratz

