Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S318091AbSFTCBU>; Wed, 19 Jun 2002 22:01:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S318092AbSFTCBT>; Wed, 19 Jun 2002 22:01:19 -0400
Received: from amdext.amd.com ([139.95.251.1]:61139 "EHLO amdext.amd.com")
	by vger.kernel.org with ESMTP id <S318091AbSFTCBQ>;
	Wed, 19 Jun 2002 22:01:16 -0400
From: marc.miller@amd.com
X-Server-Uuid: 02753650-11b0-11d5-bbc5-00508bf987eb
Message-ID: <858788618A93D111B45900805F85267A062BB49D@caexmta3.amd.com>
To: devnull@adc.idt.com, linux-kernel@vger.kernel.org
Subject: RE: >3G Memory support
Date: Wed, 19 Jun 2002 19:01:08 -0700
MIME-Version: 1.0
X-Mailer: Internet Mail Service (5.5.2653.19)
X-WSS-ID: 110FE8E21776476-01-01
Content-Type: text/plain; 
 charset=iso-8859-1
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi

Support of 4G of RAM is a configuration option when you compile the kernel.  Is that setting turned on?  

I think it's in "General Options" when you do a "make menuconfig" (I don't have a machine up at the moment that I can check).  There are three options:  Less than 1G, 1G to less than 4G, and 4G or more.  That last option is the one you would want.  

If that's already enabled, hopefully one of the memory guys can pitch in...

Marc J. Miller
Server Software Alliance Manager
Software & Infrastructure Initiatives Team
AMD, Inc.

marc.miller@amd.com
1-800-538-8450 x43325

 -----Original Message-----
From: 	devnull@adc.idt.com [mailto:devnull@adc.idt.com] 
Sent:	Wednesday, June 19, 2002 3:30 PM
To:	linux-kernel@vger.kernel.org
Subject:	>3G Memory support

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


-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
Please read the FAQ at  http://www.tux.org/lkml/

