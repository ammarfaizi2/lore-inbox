Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S135527AbRD2KuM>; Sun, 29 Apr 2001 06:50:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S135586AbRD2KuC>; Sun, 29 Apr 2001 06:50:02 -0400
Received: from pop.gmx.net ([194.221.183.20]:1867 "HELO mail.gmx.net")
	by vger.kernel.org with SMTP id <S135527AbRD2Ktz>;
	Sun, 29 Apr 2001 06:49:55 -0400
Date: Sun, 29 Apr 2001 12:47:18 +0200
From: Michael Mauch <michael.mauch@gmx.de>
To: linux-kernel@vger.kernel.org
Subject: /proc/interrupts vs. /proc/stat (and reality)
Message-ID: <20010429124718.A1175@elmicha.333200002251-0001.dialin.t-online.de>
Mail-Followup-To: linux-kernel@vger.kernel.org
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

my /proc/interrupts doesn't show all the interrupts that have been used,
/proc/stat (and hence procinfo) does. All of the devices work without
problems.

% cat /proc/interrupts /proc/stat && procinfo
           CPU0       
  0:     476919          XT-PIC  timer
  1:      12333          XT-PIC  keyboard
  2:          0          XT-PIC  cascade
  3:        221          XT-PIC  
  5:       8388          XT-PIC  soundblaster
  7:          0          XT-PIC  parport0
  8:         67          XT-PIC  rtc
 10:         53          XT-PIC  advansys, ncr53c8xx
 11:      35704          XT-PIC  HiSax
 12:      49384          XT-PIC  PS/2 Mouse
 14:         29          XT-PIC  ide0
 15:      39616          XT-PIC  ide1
NMI:          0 
ERR:          0
cpu  25315 461 35481 415662
cpu0 25315 461 35481 415662
page 331823 243999
swap 2 0
intr 622904 476919 12333 0 221 160 8388 30 0 67 0 53 35704 49384 0 29 39616 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0
disk_io: (2,0):(34,34,37,0,0) (3,0):(5,5,10,0,0) (8,0):(8,8,16,0,0) 
ctxt 2581888
btime 988535311
processes 1291
Linux 2.4.4-pre4 (root@elmicha) (gcc 2.95.3 20010315 ) #2 1CPU [elmicha.(none)]

Memory:      Total        Used        Free      Shared     Buffers      Cached
Mem:        384352      319980       64372           0        4816      137528
Swap:       939752         260      939492

Bootup: Sun Apr 29 11:08:31 2001    Load average: 0.05 0.13 0.10 6/103 1292

user  :       0:04:13.15   5.3%  page in :   331823
nice  :       0:00:04.61   0.1%  page out:   243999
system:       0:05:54.82   7.4%  swap in :        2
idle  :       1:09:16.62  87.2%  swap out:        0
uptime:       1:19:29.19         context :  2581892

irq  0:    476920 timer                 irq  7:         0 parport0             
irq  1:     12333 keyboard              irq  8:        67 rtc                  
irq  2:         0 cascade [4]           irq 10:        53 advansys, ncr53c8xx  
irq  3:       221                       irq 11:     35704 HiSax                
irq  4:       160                       irq 12:     49384 PS/2 Mouse           
irq  5:      8388 soundblaster          irq 14:        29 ide0                 
irq  6:        30                       irq 15:     39616 ide1                 


So IRQ 3 doesn't know it's getting serviced by the serial module, IRQ 4
and IRQ 6 don't show in /proc/interrupts (and I've used both serial
ports and the floppy before), only in /proc/stat.

This is an Athlon 700 on a Gigabyte 7IXE (Irongate/Viper), gcc-2.95.3
compiled 2.4.4-pre4. Some lines from .config:

CONFIG_MK7=y
CONFIG_X86_GOOD_APIC=y
CONFIG_X86_MSR=y
CONFIG_X86_CPUID=y
CONFIG_NOHIGHMEM=y
CONFIG_MTRR=y
# CONFIG_SMP is not set
CONFIG_X86_UP_IOAPIC=y
CONFIG_X86_IO_APIC=y
CONFIG_X86_LOCAL_APIC=y


Have I done something wrong? Should I send more info?

Regards...
		Michael
