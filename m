Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S318037AbSFSWag>; Wed, 19 Jun 2002 18:30:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S318038AbSFSWaf>; Wed, 19 Jun 2002 18:30:35 -0400
Received: from noc.mainstreet.net ([207.5.0.45]:35086 "EHLO noc.mainstreet.net")
	by vger.kernel.org with ESMTP id <S318037AbSFSWac>;
	Wed, 19 Jun 2002 18:30:32 -0400
From: devnull@adc.idt.com
Date: Wed, 19 Jun 2002 18:30:28 -0400 (EDT)
X-X-Sender: <ram@bom.adc.idt.com>
Reply-To: <devnull@adc.idt.com>
To: <linux-kernel@vger.kernel.org>
Subject: >3G Memory support
Message-ID: <Pine.GSO.4.31.0206191818370.13822-100000@bom.adc.idt.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello All.

I have a PC with 4G of Memory and would like a process to be able to
address all 4G of memory.

I am running 2.4.13-ac8

The way i understand it is that linux shares the top 1G of process address
space with all processes on the system(so on systems with 4G is physical
addressability, it leaves 3G for each process).

>From the archives, i learnt that i need to modify __PAGE_OFFSET and change
it from the default  (0xC0000000).

Looking at /usr/src/linux/include/asm-i386/page.h

<<SNIP>>
/*
 * This handles the memory map.. We could make this a config
 * option, but too many people screw it up, and too few need
 * it.
 *
 * A __PAGE_OFFSET of 0xC0000000 means that the kernel has
 * a virtual address space of one gigabyte, which limits the
 * amount of physical memory you can use to about 950MB.
 *
 * If you want more physical memory than this then see the
 *   CONFIG_HIGHMEM4G
 * and CONFIG_HIGHMEM64G options in the kernel configuration.
 */

<<END_OF_SNIP>>

When i compiled my kernel, i set CONFIG_HIGHMEM4G.

Does this mean that all my programs should be able to address 4G ?

If yes, i dont think it is working very well.

#include<stdio.h>
#include<sys/resource.h>
#include<unistd.h>
#include<sys/wait.h>
#include<stdlib.h>

main(int argc, char **argv)
{

        char    *n;
  int   size = 1073741000;
        unsigned int totalsize = 0;

        while(size > 1000)      {
                while(n=(char *) malloc(size))  {
                        bzero(n, size);
                        totalsize += size;
                }
//              usleep(999999) ;
                size = size / 2;
        }
        printf("Total size = %lu\n", totalsize);
}

The variable "totalsize" goes upto 3G only.

If seting CONFIG_HIGHMEM4G is not the way to proceed, could someone please
point me in the right direction.

Thanks for taking the time to read my email, and sorry about the long
post.

Best Regards,


/dev/null

devnull@adc.idt.com


