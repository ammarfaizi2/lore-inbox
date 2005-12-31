Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964995AbVLaQNu@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964995AbVLaQNu (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 31 Dec 2005 11:13:50 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964998AbVLaQNu
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 31 Dec 2005 11:13:50 -0500
Received: from astra.telenet-ops.be ([195.130.132.58]:65189 "EHLO
	astra.telenet-ops.be") by vger.kernel.org with ESMTP
	id S964995AbVLaQNt (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 31 Dec 2005 11:13:49 -0500
Message-ID: <43B6BC47.7020206@kefren.be>
Date: Sat, 31 Dec 2005 18:13:43 +0100
From: Ochal Christophe <ochal@kefren.be>
User-Agent: Mozilla Thunderbird 1.0.7 (X11/20051212)
X-Accept-Language: en-us, en
MIME-Version: 1.0
Cc: linux-kernel@vger.kernel.org
Subject: Re: Possible bug in amd64-agp (agpgart module)
References: <43B5089E.5090307@kefren.be>
In-Reply-To: <43B5089E.5090307@kefren.be>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
To: unlisted-recipients:; (no To-header on input)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi all,

Some more info regarding my uphill battle with my machine :)

Ochal Christophe wrote:

> Hi all,
>
> Sorry for the intrusion, but i think i've stumbled across a bug in the 
> linux kernel.
> On an Asus KV8-S XE motherboard, the agpgart module is unable to 
> properly determine the AGP aperture size, regardless of bios options 
> (AGP 8x mode & AGP 4x mode), this *might* also be related to possible 
> hangs in X11 when using DRI.
>
> Bug was seen on the following config:
>
> Asus K8V-S XE motherboard, 512MB ram with AMD Sempron 3200 (Athlon64 
> core)
> Witnessed with an ATI Radeon 9700 Pro card and with an Asus Radeon 
> 9200 SE.
>
> I'll try & test this config with some more gfx cards to see if the gfx 
> card has any influence on the detection, but i'm not sure i have any 
> nVidia cards available.
>
> This phenomenon has been found in atleast the following kernel versions:
>
> linux 2.6.12-r9
> linux 2.6.14-r4
> linux 2.6.14-r5
> linux 2.6.14-r7
>
> The reported aperture size is always 32M, more details can be 
> provided, just ask what you need to know. 

Some more info, might be worthwhile for the people in the know:

Motherboard: Asus K8V-X SE
lspci:
00:00.0 Host bridge: VIA Technologies, Inc. K8T800Pro Host Bridge
00:00.1 Host bridge: VIA Technologies, Inc. K8T800Pro Host Bridge
00:00.2 Host bridge: VIA Technologies, Inc. K8T800Pro Host Bridge
00:00.3 Host bridge: VIA Technologies, Inc. K8T800Pro Host Bridge
00:00.4 Host bridge: VIA Technologies, Inc. K8T800Pro Host Bridge
00:00.7 Host bridge: VIA Technologies, Inc. K8T800Pro Host Bridge
00:01.0 PCI bridge: VIA Technologies, Inc. VT8237 PCI bridge 
[K8T800/K8T890 South]
00:0f.0 RAID bus controller: VIA Technologies, Inc. VIA VT6420 SATA RAID 
Controller (rev 80)
00:0f.1 IDE interface: VIA Technologies, Inc. 
VT82C586A/B/VT82C686/A/B/VT823x/A/C PIPC Bus Master IDE (rev 06)
00:10.0 USB Controller: VIA Technologies, Inc. VT82xxxxx UHCI USB 1.1 
Controller (rev 81)
00:10.1 USB Controller: VIA Technologies, Inc. VT82xxxxx UHCI USB 1.1 
Controller (rev 81)
00:10.2 USB Controller: VIA Technologies, Inc. VT82xxxxx UHCI USB 1.1 
Controller (rev 81)
00:10.3 USB Controller: VIA Technologies, Inc. VT82xxxxx UHCI USB 1.1 
Controller (rev 81)
00:10.4 USB Controller: VIA Technologies, Inc. USB 2.0 (rev 86)
00:11.0 ISA bridge: VIA Technologies, Inc. VT8237 ISA bridge 
[KT600/K8T800/K8T890 South]
00:11.5 Multimedia audio controller: VIA Technologies, Inc. 
VT8233/A/8235/8237 AC97 Audio Controller (rev 60)
00:12.0 Ethernet controller: VIA Technologies, Inc. VT6102 [Rhine-II] 
(rev 78)
00:18.0 Host bridge: Advanced Micro Devices [AMD] K8 [Athlon64/Opteron] 
HyperTransport Technology Configuration
00:18.1 Host bridge: Advanced Micro Devices [AMD] K8 [Athlon64/Opteron] 
Address Map
00:18.2 Host bridge: Advanced Micro Devices [AMD] K8 [Athlon64/Opteron] 
DRAM Controller
00:18.3 Host bridge: Advanced Micro Devices [AMD] K8 [Athlon64/Opteron] 
Miscellaneous Control
01:00.0 VGA compatible controller: ATI Technologies Inc Radeon R300 ND 
[Radeon 9700 Pro]
01:00.1 Display controller: ATI Technologies Inc Radeon R300 [Radeon 
9700 Pro] (Secondary)

Distribution:
Gentoo with kernel: 2.6.13-gentoo-r5

Problem witnessed with multiple kernels (see prior post), regardless of 
BIOS settings.

Test results of testgart.c:

localhost ochal # ./test
version: 0.101
bridge id: 0x2821106
agp_mode: 0x1f000a1b
aper_base: 0xe4000000
aper_size: 32
pg_total: 112384
pg_system: 112384
pg_used: 0
entry.key : 0
entry.key : 1
Allocated 8 megs of GART memory
MemoryBenchmark: 8 mb/s
MemoryBenchmark: 8 mb/s
MemoryBenchmark: 9 mb/s
Average speed: 8 mb/s
Testing data integrity (1st pass): failed on first pass!
Testing data integrity (2nd pass): failed on second pass!

dmesg:
Linux agpgart interface v0.101 (c) Dave Jones
fglrx: module license 'Proprietary. (C) 2002 - ATI Technologies, 
Starnberg, GERMANY' taints kernel.
[fglrx] Maximum main memory to use for locked dma buffers: 430 MBytes.
ACPI: PCI Interrupt 0000:01:00.0[A] -> GSI 16 (level, low) -> IRQ 201
[fglrx] module loaded - fglrx 8.20.8 [Dec  6 2005] on minor 0
[fglrx] ACPI power management is initialized.
Fire GL agpgart support
fglrx_agp is probing for an AGP device
Device found = 1106
failed pci_module_init
Unloading fglrx_agp
firegl_agp_probe failed
[fglrx] Failed to load fglrx_agp module
[fglrx] Error code  256
[fglrx] Failed to load ATI module agpgart
[fglrx] Fallback to internal agpgart module
Fire GL built-in AGP-support
Based on agpgart interface v0.99 (c) Jeff Hartmann
agpgart: Maximum main memory to use for agp memory: 439M
agpgart: Unsupported Via chipset (device id: 0282), you might want to 
try agp_try_unsupported=1.
agpgart: no supported devices found.
[fglrx] Initialization of built-in AGP-support failed (ret=-19).
[fglrx:firegl_unlock] *ERROR* Process 5366 using kernel context 0
scsi: unknown opcode 0xe9
scsi: unknown opcode 0xed
scsi: unknown opcode 0x01
scsi: unknown opcode 0xf5
hda: packet command error: status=0x51 { DriveReady SeekComplete Error }
hda: packet command error: error=0x54 { AbortedCommand 
LastFailedSense=0x05 }
ide: failed opcode was: unknown
hda: packet command error: status=0x51 { DriveReady SeekComplete Error }
hda: packet command error: error=0x54 { AbortedCommand 
LastFailedSense=0x05 }
ide: failed opcode was: unknown
agpgart: Detected AGP bridge 0
agpgart: AGP aperture is 32M @ 0xe4000000
agpgart: Found an AGP 3.0 compliant device at 0000:00:00.0.
agpgart: test tried to set rate=x12. Setting to AGP3 x8 mode.
agpgart: Putting AGP V3 device at 0000:00:00.0 into 8x mode
agpgart: Putting AGP V3 device at 0000:01:00.0 into 8x mode
agpgart: Found an AGP 3.0 compliant device at 0000:00:00.0.
agpgart: test tried to set rate=x12. Setting to AGP3 x8 mode.
agpgart: Putting AGP V3 device at 0000:00:00.0 into 8x mode
agpgart: Putting AGP V3 device at 0000:01:00.0 into 8x mode


The testgart.c code:

/* 
 * 
 * Test program for AGPGART module under Linux
 * 
 * Copyright (C) 1999 Jeff Hartmann, 
 * Precision Insight, Inc., Xi Graphics, Inc.
 *
 */ 


#include <stdio.h>
#include <unistd.h>
#include <sys/ioctl.h>
#include <fcntl.h>
#include <sys/mman.h>
#include <sys/time.h>
#include <linux/types.h>
#include <linux/agpgart.h>
#include <asm/mtrr.h>
#include <errno.h>

unsigned char *gart;
int gartfd;
int mtrr;

int usec( void ) {
  struct timeval tv;
  struct timezone tz;
  
  gettimeofday( &tv, &tz );
  return (tv.tv_sec & 2047) * 1000000 + tv.tv_usec;
}

int MemoryBenchmark( void *buffer, int dwords ) {
  int             i;
  int             start, end;
  int             mb;
  int             *base;
  
  base = (int *)buffer;
  start = usec();
  for ( i = 0 ; i < dwords ; i += 8 ) {
    base[i] =
      base[i+1] =
      base[i+2] =
      base[i+3] =
      base[i+4] =
      base[i+5] =
      base[i+6] =
      base[i+7] = 0x15151515;         /* dmapad nops */

  }
  end = usec();
  mb = ( (float)dwords / 0x40000 ) * 1000000 / (end - start);
  printf("MemoryBenchmark: %i mb/s\n", mb );
  return mb;
}

int insert_gart(int page, int size)
{
   agp_allocate entry;
   agp_bind bind;
   
   entry.type = 0;
   entry.pg_count = size;
#ifdef DEBUG
   printf("Using AGPIOC_ALLOCATE\n");
#endif
   if(ioctl(gartfd, AGPIOC_ALLOCATE, &entry) != 0)
    {
      perror("ioctl(AGPIOC_ALLOCATE)");
      exit(1);
    }
   
   bind.key = entry.key;
   bind.pg_start = page;
#ifdef DEBUG
   printf("Using AGPIOC_BIND\n");
#endif
   if(ioctl(gartfd, AGPIOC_BIND, &bind))
     {
	perror("ioctl(AGPIOC_BIND)");
	exit(1);
     }
   
   printf("entry.key : %i\n", entry.key);
   
   return(entry.key);
}

int unbind_gart(int key)
{
   agp_unbind unbind;
   
   unbind.key = key;
#ifdef DEBUG
   printf("Using AGPIOC_UNBIND\n");
#endif
   if(ioctl(gartfd, AGPIOC_UNBIND, &unbind) != 0)
     {
	perror("ioctl(AGPIOC_UNBIND)");
	exit(1);
     }
   
   return(0);
}

int bind_gart(int key, int page)
{
   agp_bind bind;
   
   bind.key = key;
   bind.pg_start = page;
#ifdef DEBUG
   printf("Using AGPIOC_BIND\n");
#endif
   if(ioctl(gartfd, AGPIOC_BIND, &bind) != 0)
     {
	perror("ioctl(AGPIOC_BIND)");
	exit(1);
     }
   
   return(0);
}

int remove_gart(int key)
{
#ifdef DEBUG
   printf("Using AGPIOC_DEALLOCATE\n");
#endif
  if(ioctl(gartfd, AGPIOC_DEALLOCATE, key) != 0)
    {
      perror("ioctl(GARTIOCREMOVE)");
      exit(1);
    }
   
   return(0);
}

void openmtrr(void) 
{
   if ((mtrr = open("/proc/mtrr", O_WRONLY, 0)) == -1) 
     {
	if (errno == ENOENT) {
	   perror("/proc/mtrr not found: MTRR not enabled\n");
	}  else {
	   perror("Error opening /proc/mtrr:");
	   perror("MTRR not enabled\n");
	   exit(1);
	}
	return;
     }
}

int CoverRangeWithMTRR( int base, int range, int type )
{
   int          count;   
      
   /* set it if we aren't just checking the number */
   if ( type != -1 ) {
      struct mtrr_sentry sentry;
      
      sentry.base = base;
      sentry.size = range;
      sentry.type = type;
      
      if ( ioctl(mtrr, MTRRIOC_ADD_ENTRY, &sentry) == -1 ) {
	 perror("mtrr");
	 exit(1);
      }
   }
   
}

int init_agp(void)
{
   agp_info info;
   agp_setup setup;

#ifdef DEBUG
   printf("Using AGPIOC_ACQUIRE\n");
#endif
   if(ioctl(gartfd, AGPIOC_ACQUIRE) != 0)
     {
	perror("ioctl(AGPIOC_ACQUIRE)");
	exit(1);
     }
#ifdef DEBUG
   printf("Using AGPIOC_INFO\n");
#endif
   if(ioctl(gartfd, AGPIOC_INFO, &info) != 0)
     {
	perror("ioctl(AGPIOC_INFO)");
	exit(1);
     }
   
   printf("version: %i.%i\n", info.version.major, info.version.minor);
   printf("bridge id: 0x%lx\n", info.bridge_id);
   printf("agp_mode: 0x%lx\n", info.agp_mode);
   printf("aper_base: 0x%lx\n", info.aper_base);
   printf("aper_size: %i\n", info.aper_size);
   printf("pg_total: %i\n", info.pg_total);
   printf("pg_system: %i\n", info.pg_system);
   printf("pg_used: %i\n", info.pg_used);

   openmtrr();
   if (mtrr != -1) { 
     CoverRangeWithMTRR(info.aper_base, info.aper_size * 0x100000, 
       MTRR_TYPE_WRCOMB);
   }

   gart = mmap(NULL, info.aper_size * 0x100000, PROT_READ | PROT_WRITE, MAP_SHARED, gartfd, 0);

   if(gart == (unsigned char *) 0xffffffff)
     {
	perror("mmap");
	close(gartfd);
	exit(1);
     }	
   
   setup.agp_mode = info.agp_mode;
#ifdef DEBUG
   printf("Using AGPIOC_SETUP\n");
#endif
   if(ioctl(gartfd, AGPIOC_SETUP, &setup) != 0)
     {
	perror("ioctl(AGPIOC_SETUP)");
	exit(1);
     }
   
   return(0);
}

int xchangeDummy;

void FlushWriteCombining( void ) {
	__asm__ volatile( " push %%eax ; xchg %%eax, %0 ; pop %%eax" : : "m" (xchangeDummy));
	__asm__ volatile( " push %%eax ; push %%ebx ; push %%ecx ; push %%edx ; movl $0,%%eax ; cpuid ; pop %%edx ; pop %%ecx ; pop %%ebx ; pop %%eax" : /* no outputs */ :  /* no inputs */ );
}

void BenchMark()
{
  int i, worked = 1;

  i = MemoryBenchmark(gart, (1024 * 1024 * 4) / 4) +
    MemoryBenchmark(gart, (1024 * 1024 * 4) / 4) +
    MemoryBenchmark(gart, (1024 * 1024 * 4) / 4);
  
  printf("Average speed: %i mb/s\n", i /3);
  
  printf("Testing data integrity (1st pass): ");
  fflush(stdout);
   
  FlushWriteCombining();
  
  for (i=0; i < 8 * 0x100000; i++)
    {
      gart[i] = i % 256;
    }
   
  FlushWriteCombining();
   
  
  for (i=0; i < 8 * 0x100000; i++)
    {
       if(!(gart[i] == i % 256))
	 {
#ifdef DEBUG
	    printf("failed on %i, gart[i] = %i\n", i, gart[i]);
#endif
	    worked = 0;
	 }
    }
  
  if (!worked)
    printf("failed on first pass!\n");
  else
    printf("passed on first pass.\n");
   
   unbind_gart(0);
   unbind_gart(1);
   bind_gart(0, 0);
   bind_gart(1, 1024);

   worked = 1;
   printf("Testing data integrity (2nd pass): ");
   fflush(stdout);
   
   for (i=0; i < 8 * 0x100000; i++)
    {
       if(!(gart[i] == i % 256))
	 {
#ifdef DEBUG
	    printf("failed on %i, gart[i] = %i\n", i, gart[i]);
#endif
	    worked = 0;
	 }
    }

   if (!worked)
    printf("failed on second pass!\n");
  else
    printf("passed on second pass.\n");
}

int main()
{
   int i;
   int key;
   int key2;
   agp_info info;
  
   gartfd = open("/dev/agpgart", O_RDWR);
   if (gartfd == -1)
     {	
	perror("open");
	exit(1);
     }
   
   init_agp();
   
   key = insert_gart(0, 1024);
   key2 = insert_gart(1024, 1024);
   
#ifdef DEBUG
   printf("Using AGPIOC_INFO\n");
   if(ioctl(gartfd, AGPIOC_INFO, &info) != 0)
     {
	perror("ioctl(AGPIOC_INFO)");
	exit(1);
     }
   
   printf("version: %i.%i\n", info.version.major, info.version.minor);
   printf("bridge id: 0x%lx\n", info.bridge_id);
   printf("agp_mode: 0x%lx\n", info.agp_mode);
   printf("aper_base: 0x%lx\n", info.aper_base);
   printf("aper_size: %i\n", info.aper_size);
   printf("pg_total: %i\n", info.pg_total);
   printf("pg_system: %i\n", info.pg_system);
   printf("pg_used: %i\n", info.pg_used);
#endif
   
   printf("Allocated 8 megs of GART memory\n");
   
   BenchMark();
   
   remove_gart(key);
   remove_gart(key2);

#ifdef DEBUG   
   printf("Using AGPIOC_RELEASE\n");
#endif
   if(ioctl(gartfd, AGPIOC_RELEASE) != 0)
     {
	perror("ioctl(AGPIOC_RELEASE)");
	exit(1);
     }
   
   close(gartfd);
}


I don't know how correct this test program is, i'm willing to test the 
hell out of this.
