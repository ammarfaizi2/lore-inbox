Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S135724AbRD2La7>; Sun, 29 Apr 2001 07:30:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S135727AbRD2Lau>; Sun, 29 Apr 2001 07:30:50 -0400
Received: from jim.southcom.com.au ([203.39.132.182]:10245 "EHLO
	jim.southcom.com.au") by vger.kernel.org with ESMTP
	id <S135724AbRD2Lal>; Sun, 29 Apr 2001 07:30:41 -0400
Date: Sun, 29 Apr 2001 21:27:35 +1000 (EST)
From: Jim Woodward <jim@jim.southcom.com.au>
To: Michael Mauch <michael.mauch@gmx.de>
cc: Linux Kernel <linux-kernel@vger.kernel.org>
Subject: Re: /proc/interrupts vs. /proc/stat (and reality)
In-Reply-To: <20010429124718.A1175@elmicha.333200002251-0001.dialin.t-online.de>
Message-ID: <Pine.LNX.4.33.0104292109110.1905-100000@jim.southcom.com.au>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 29 Apr 2001, Michael Mauch wrote:

> Hi,
>
> my /proc/interrupts doesn't show all the interrupts that have been used,
> /proc/stat (and hence procinfo) does. All of the devices work without
> problems.
>
> % cat /proc/interrupts /proc/stat && procinfo
>            CPU0
>   0:     476919          XT-PIC  timer
>   1:      12333          XT-PIC  keyboard
>   2:          0          XT-PIC  cascade
>   3:        221          XT-PIC
>   5:       8388          XT-PIC  soundblaster
>   7:          0          XT-PIC  parport0
>   8:         67          XT-PIC  rtc
>  10:         53          XT-PIC  advansys, ncr53c8xx
>  11:      35704          XT-PIC  HiSax
>  12:      49384          XT-PIC  PS/2 Mouse
>  14:         29          XT-PIC  ide0
>  15:      39616          XT-PIC  ide1
> NMI:          0
> ERR:          0
> cpu  25315 461 35481 415662
> cpu0 25315 461 35481 415662
> page 331823 243999
> swap 2 0
> intr 622904 476919 12333 0 221 160 8388 30 0 67 0 53 35704 49384 0 29 39616 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0
> disk_io: (2,0):(34,34,37,0,0) (3,0):(5,5,10,0,0) (8,0):(8,8,16,0,0)
> ctxt 2581888
> btime 988535311
> processes 1291
> Linux 2.4.4-pre4 (root@elmicha) (gcc 2.95.3 20010315 ) #2 1CPU [elmicha.(none)]
>
> Memory:      Total        Used        Free      Shared     Buffers      Cached
> Mem:        384352      319980       64372           0        4816      137528
> Swap:       939752         260      939492
>
> Bootup: Sun Apr 29 11:08:31 2001    Load average: 0.05 0.13 0.10 6/103 1292
>
> user  :       0:04:13.15   5.3%  page in :   331823
> nice  :       0:00:04.61   0.1%  page out:   243999
> system:       0:05:54.82   7.4%  swap in :        2
> idle  :       1:09:16.62  87.2%  swap out:        0
> uptime:       1:19:29.19         context :  2581892
>
> irq  0:    476920 timer                 irq  7:         0 parport0
> irq  1:     12333 keyboard              irq  8:        67 rtc
> irq  2:         0 cascade [4]           irq 10:        53 advansys, ncr53c8xx
> irq  3:       221                       irq 11:     35704 HiSax
> irq  4:       160                       irq 12:     49384 PS/2 Mouse
> irq  5:      8388 soundblaster          irq 14:        29 ide0
> irq  6:        30                       irq 15:     39616 ide1
>
>
> So IRQ 3 doesn't know it's getting serviced by the serial module, IRQ 4
> and IRQ 6 don't show in /proc/interrupts (and I've used both serial
> ports and the floppy before), only in /proc/stat.
>
> Have I done something wrong? Should I send more info?

I am too having the same thing appear, it started once i added my advansys
based Ultra Wide SCSI adapter, all the serial port identities dsiappeared
from the IRQ list but functionality is still there, i have COM1,2,3,4 on
IRQ's 4,3,7,9 respectivly (extra 2 are a ISA 2 x ST16650V2 fully
jumperable IO card), procinfo shows:

irq  0:    984034 timer                 irq  7:        22
irq  1:         2 keyboard              irq  9:      3342
irq  2:         0 cascade [4]           irq 11:     47697 advansys, eth0
irq  3:   1825934                       irq 14:     23321 ide0
irq  5:         1 soundblaster          irq 15:     13057 ide1
irq  6:         3

and /proc/interrupts show:

           CPU0
  0:    1048426          XT-PIC  timer
  1:          2          XT-PIC  keyboard
  2:          0          XT-PIC  cascade
  3:    1943828          XT-PIC
  5:          1          XT-PIC  soundblaster
  7:         22          XT-PIC
  9:       3342          XT-PIC
 11:      56781          XT-PIC  advansys, eth0
 14:      28755          XT-PIC  ide0
 15:      14328          XT-PIC  ide1
NMI:          0
ERR:          0

The above was taken from my system whist running kernel 2.4.4 (release)
it also appeared on 2.4.3 (release) after i added the advansys card, which
has appeared to have jumped on irq 11 along side the DEC Tulip ethernet
card. (The advansys replaced a sym53c810a card which used to sit on irq
10)

Maybe its something to do with IRQ sharing?

Regards, Jim.


-
name  : Jim Woodward
www   : http://www.jim.southcom.com.au
email : jim@jim.southcom.com.au

