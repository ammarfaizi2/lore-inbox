Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932082AbVLaBsR@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932082AbVLaBsR (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 30 Dec 2005 20:48:17 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932085AbVLaBsR
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 30 Dec 2005 20:48:17 -0500
Received: from smtp-7.smtp.ucla.edu ([169.232.46.137]:38573 "EHLO
	smtp-7.smtp.ucla.edu") by vger.kernel.org with ESMTP
	id S932082AbVLaBsR (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 30 Dec 2005 20:48:17 -0500
Date: Fri, 30 Dec 2005 17:48:15 -0800 (PST)
From: Chris Stromsoe <cbs@cts.ucla.edu>
To: Marcelo Tosatti <marcelo.tosatti@cyclades.com>
cc: linux-kernel@vger.kernel.org
Subject: Re: bad pmd filemap.c, oops; 2.4.30 and 2.4.32
In-Reply-To: <Pine.LNX.4.64.0512301610320.13624@potato.cts.ucla.edu>
Message-ID: <Pine.LNX.4.64.0512301732170.21145@potato.cts.ucla.edu>
References: <Pine.LNX.4.64.0512270844080.14284@potato.cts.ucla.edu>
 <20051228001047.GA3607@dmt.cnet> <Pine.LNX.4.64.0512281806450.10419@potato.cts.ucla.edu>
 <Pine.LNX.4.64.0512301610320.13624@potato.cts.ucla.edu>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII; format=flowed
X-Probable-Spam: no
X-Spam-Report: none
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I'm starting to suspect bad hardware.  Booting is now hanging (with 
2.4.27, 2.4.30 and 2.4.32) after scsi drivers load:

.....

Floppy drive(s): fd0 is 1.44M
FDC 0 is a National Semiconductor PC87306
Uniform Multi-Platform E-IDE driver Revision: 7.00beta4-2.4
ide: Assuming 33MHz system bus speed for PIO modes; override with 
idebus=xx
hda: TEAC CD-ROM CD-224E, ATAPI CD/DVD-ROM drive
ide0 at 0x1f0-0x1f7,0x3f6 on irq 14
hda: attached ide-cdrom driver.
hda: ATAPI 24X CD-ROM drive, 128kB Cache
Uniform CD-ROM driver Revision: 3.12
SCSI subsystem driver Revision: 1.00
scsi0 : Adaptec AIC7XXX EISA/VLB/PCI SCSI HBA DRIVER, Rev 6.2.36
         <Adaptec 3960D Ultra160 SCSI adapter>
         aic7899: Ultra160 Wide Channel A, SCSI Id=7, 32/253 SCBs

scsi1 : Adaptec AIC7XXX EISA/VLB/PCI SCSI HBA DRIVER, Rev 6.2.36
         <Adaptec 3960D Ultra160 SCSI adapter>
         aic7899: Ultra160 Wide Channel B, SCSI Id=7, 32/253 SCBs

scsi2 : Adaptec AIC7XXX EISA/VLB/PCI SCSI HBA DRIVER, Rev 6.2.36
         <Adaptec aic7899 Ultra160 SCSI adapter>
         aic7899: Ultra160 Wide Channel B, SCSI Id=7, 32/253 SCBs

blk: queue f7e46018, I/O limit 4095Mb (mask 0xffffffff)


If I wait several minutes (around 10 or 15 minutes), I get:

scsi0:0:0:0: Attempting to queue an ABORT message
CDB: 0x12 0x0 0x0 0x0 0xff 0x0
scsi0:0:0:0: Command already completed
aic7xxx_abort returns 0x2002
scsi0:0:0:0: Attempting to queue an ABORT message
CDB: 0x0 0x0 0x0 0x0 0x0 0x0
scsi0:0:0:0: Command already completed
aic7xxx_abort returns 0x2002
scsi0:0:0:0: Attempting to queue a TARGET RESET message
CDB: 0x12 0x0 0x0 0x0 0xff 0x0
scsi0:0:0:0: Is not an active device
aic7xxx_dev_reset returns 0x2002
scsi0:0:0:0: Attempting to queue an ABORT message
CDB: 0x0 0x0 0x0 0x0 0x0 0x0
scsi0:0:0:0: Command already completed
aic7xxx_abort returns 0x2002
scsi0:0:0:0: Attempting to queue an ABORT message
CDB: 0x0 0x0 0x0 0x0 0x0 0x0
scsi0:0:0:0: Command already completed
aic7xxx_abort returns 0x2002
scsi: device set offline - not ready or command retry failed after bus reset: host 0 channel 0 id 0 lun 0


The messages repeated for all 15 targets on scsi0.  It's looking like it 
will repeat for scsi1 as well.

How likely is it that a failing scsi controller contribute to the other 
problems I was seeing?


-Chris

On Fri, 30 Dec 2005, Chris Stromsoe wrote:

> I oopsed again last night with an identical EIP and Call Trace to the 
> oops from the 28th.  The new oops is below, the prior below that.  I'm 
> going to reboot the machine into UP and see if that helps.
>
> -Chris
>
> Unable to handle kernel paging request at virtual address c211ce80
> c0259bb3
> *pde = 020001e3
> Oops: 0002
> CPU:    2
> EIP:    0010:[alloc_skb+275/480]    Not tainted
> EFLAGS: 00010282
> eax: c211ce80   ebx: f5303680   ecx: f7eeb780   edx: 00000680
> esi: 000001f0   edi: 00000000   ebp: d348ddf0   esp: d348dddc
> ds: 0018   es: 0018   ss: 0018
> Process innfeed (pid: 25080, stackpage=d348d000)
> Stack: 000006bc 000001f0 ebabc980 eb0e64d8 eb0e6400 d348de68 c027b50b 
> 00000680
>       000001f0 000005a8 00000000 d348de54 00000000 00000000 00000001 
> 00000000
>       012815b5 00000000 00000000 d7a160a0 d348c000 636686ac 000c3dec 
> 000087c0
> Call Trace:    [tcp_sendmsg+2619/4512] [inet_sendmsg+65/80] 
> [sock_sendmsg+102/176] [sock_readv_writev+116/176] [sock_writev+79/96]
> Code: c7 00 01 00 00 00 8b 83 8c 00 00 00 c7 40 04 00 00 00 00 8b
> Using defaults from ksymoops -t elf32-i386 -a i386
>
>
>>> eax; c211ce80 <_end+1d3b380/38650560>
>>> ebx; f5303680 <_end+34f21b80/38650560>
>>> ecx; f7eeb780 <_end+37b09c80/38650560>
>>> ebp; d348ddf0 <_end+130ac2f0/38650560>
>>> esp; d348dddc <_end+130ac2dc/38650560>
>
> Code;  00000000 Before first symbol
> 00000000 <_EIP>:
> Code;  00000000 Before first symbol
>   0:   c7 00 01 00 00 00         movl   $0x1,(%eax)
> Code;  00000006 Before first symbol
>   6:   8b 83 8c 00 00 00         mov    0x8c(%ebx),%eax
> Code;  0000000c Before first symbol
>   c:   c7 40 04 00 00 00 00      movl   $0x0,0x4(%eax)
> Code;  00000013 Before first symbol
>  13:   8b 00                     mov    (%eax),%eax
>
>
> On Wed, 28 Dec 2005, Chris Stromsoe wrote:
>
>> Unable to handle kernel paging request at virtual address c22eee80
>> c0259bb3
>> *pde = 020001e3
>> Oops: 0002
>> CPU:    2
>> EIP:    0010:[alloc_skb+275/480]    Not tainted
>> EFLAGS: 00010282
>> eax: c22eee80   ebx: ccbdb480   ecx: 000006bc   edx: 00000680
>> esi: 000001f0   edi: 00000000   ebp: f663bdf0   esp: f663bddc
>> ds: 0018   es: 0018   ss: 0018
>> Process innfeed (pid: 526, stackpage=f663b000)
>> Stack: 000006bc 000001f0 ccbdb080 00000000 f7185800 f663be68 c027b50b 
>> 00000680
>>        000001f0 000005a8 00000000 f663be54 00000000 00000287 d84bec38 
>> d84bec34
>>        d84bec54 f663a000 00000000 d5fbd8a0 f663a000 586d4438 0002c774 
>> 000005a8
>> Call Trace:    [tcp_sendmsg+2619/4512] [inet_sendmsg+65/80] 
>> [sock_sendmsg+102/176] [sock_readv_writev+116/176] [sock_writev+79/96]
>> Code: c7 00 01 00 00 00 8b 83 8c 00 00 00 c7 40 04 00 00 00 00 8b Using 
>> defaults from ksymoops -t elf32-i386 -a i386
>> 
>>>> eax; c22eee80 <_end+1f0d380/38650560>
>>>> ebx; ccbdb480 <_end+c7f9980/38650560>
>>>> ebp; f663bdf0 <_end+3625a2f0/38650560>
>>>> esp; f663bddc <_end+3625a2dc/38650560>
>> 
>> Code;  00000000 Before first symbol
>> 00000000 <_EIP>:
>> Code;  00000000 Before first symbol
>>   0:   c7 00 01 00 00 00         movl   $0x1,(%eax)
>> Code;  00000006 Before first symbol
>>   6:   8b 83 8c 00 00 00         mov    0x8c(%ebx),%eax
>> Code;  0000000c Before first symbol
>>   c:   c7 40 04 00 00 00 00      movl   $0x0,0x4(%eax)
>> Code;  00000013 Before first symbol
>>  13:   8b 00                     mov    (%eax),%eax
>> -
>> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
>> the body of a message to majordomo@vger.kernel.org
>> More majordomo info at  http://vger.kernel.org/majordomo-info.html
>> Please read the FAQ at  http://www.tux.org/lkml/
>> 
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
>
