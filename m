Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262580AbUEKJrI@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262580AbUEKJrI (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 11 May 2004 05:47:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262730AbUEKJrI
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 11 May 2004 05:47:08 -0400
Received: from mailbox.leidenuniv.nl ([132.229.102.4]:46836 "EHLO
	mailbox.leidenuniv.nl") by vger.kernel.org with ESMTP
	id S262580AbUEKJqt (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 11 May 2004 05:46:49 -0400
From: Willem de Bruijn <wdebruij@dds.nl>
To: linux-kernel@vger.kernel.org
Subject: on kmalloc vs vmalloc comparative performance
Date: Tue, 11 May 2004 11:46:41 +0200
User-Agent: KMail/1.6.1
MIME-Version: 1.0
Content-Disposition: inline
Content-Type: Multipart/Mixed;
  boundary="Boundary-00=_BEKoAqElAgFaCzl"
Message-Id: <200405111146.41428.wdebruij@dds.nl>
X-MailScanner: Found to be clean
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

--Boundary-00=_BEKoAqElAgFaCzl
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

Hi, 

  for a network monitoring project I'm working on we have to memory map quite 
a lot of data and therefore use vmalloc extensively. A quick google showed me 
that the general assumption is that vmalloc is a lot slower than kmalloc. For 
monitoring high speed network links throughput is of the essence so this made 
me wonder whether I'd taken the correct route.

To test the assumption I created a very simple module that does some reading 
and writing on large buffers. As I'm not too acquainted with the kernel's MM 
this was the best I could do. In any case, 

--> for runtime performance vmalloc'ated memory doesn't appear to perform 
worse than kmalloc'ed. <--

Perhaps the function call itself takes longer (I haven't tested that), but 
that can be handled outside of the datapath of our code.

I thought I'd post the results, including sourcecode, here FYI. Please let me 
know If my test is seriously flawed or you disagree with the outcome for some 
other reason.

cheers,

  Willem

-- 
Willem de Bruijn
wdebruij_at_dds.nl
http://www.wdebruij.dds.nl/

current project : 
Fairly Fast Packet Filter (FFPF)
http://ffpf.sourceforge.net/


-- 
Dit bericht is gescand op virussen en andere gevaarlijke inhoud door ULCN MailScanner en het bericht lijkt schoon te zijn.
This message has been scanned for viruses and dangerous content by ULCN MailScanner, and is believed to be clean.


--Boundary-00=_BEKoAqElAgFaCzl
Content-Type: text/plain;
  charset="us-ascii";
  name="kmem_out"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
	filename="kmem_out"

memory benchmarking module cleanup complete
loading memory benchmarking module
testing type 0
testing memory by linearly reading 40960 bytes... <5>took 81948 cycles
testing memory by linearly writing 40960 bytes... <5>took 134130 cycles
testing memory by linearly reading 1 bytes... <5>took 25 cycles
testing memory by linearly writing 1 bytes... <5>took 33 cycles
testing type 1
testing memory by linearly reading 40960 bytes... <5>took 81977 cycles
testing memory by linearly writing 40960 bytes... <5>took 133528 cycles
testing memory by linearly reading 1 bytes... <5>took 25 cycles
testing memory by linearly writing 1 bytes... <5>took 15 cycles
memory benchmarking module cleanup complete
loading memory benchmarking module
testing type 0
testing memory by linearly reading 40960 bytes... <5>took 81948 cycles
testing memory by linearly writing 40960 bytes... <5>took 133559 cycles
testing memory by linearly reading 1 bytes... <5>took 11 cycles
testing memory by linearly writing 1 bytes... <5>took 86 cycles
testing type 1
testing memory by linearly reading 40960 bytes... <5>took 81965 cycles
testing memory by linearly writing 40960 bytes... <5>took 134846 cycles
testing memory by linearly reading 1 bytes... <5>took 11 cycles
testing memory by linearly writing 1 bytes... <5>took 15 cycles
memory benchmarking module cleanup complete
loading memory benchmarking module
testing type 0
testing memory by linearly reading 40960 bytes... <5>took 81948 cycles
testing memory by linearly writing 40960 bytes... <5>took 133859 cycles
testing memory by linearly reading 1 bytes... <5>took 11 cycles
testing memory by linearly writing 1 bytes... <5>took 86 cycles
testing type 1
testing memory by linearly reading 40960 bytes... <5>took 108440 cycles
testing memory by linearly writing 40960 bytes... <5>took 135190 cycles
testing memory by linearly reading 1 bytes... <5>took 24 cycles
testing memory by linearly writing 1 bytes... <5>took 70 cycles
memory benchmarking module cleanup complete
loading memory benchmarking module
testing type 0
testing memory by linearly reading 40960 bytes... <5>took 81948 cycles
testing memory by linearly writing 40960 bytes... <5>took 134050 cycles
testing memory by linearly reading 1 bytes... <5>took 11 cycles
testing memory by linearly writing 1 bytes... <5>took 86 cycles
testing type 1
testing memory by linearly reading 40960 bytes... <5>took 81977 cycles
testing memory by linearly writing 40960 bytes... <5>took 135397 cycles
testing memory by linearly reading 1 bytes... <5>took 11 cycles
testing memory by linearly writing 1 bytes... <5>took 87 cycles
memory benchmarking module cleanup complete
loading memory benchmarking module
testing type 0
testing memory by linearly reading 40960 bytes... <5>took 81948 cycles
testing memory by linearly writing 40960 bytes... <5>took 133492 cycles
testing memory by linearly reading 1 bytes... <5>took 11 cycles
testing memory by linearly writing 1 bytes... <5>took 86 cycles
testing type 1
testing memory by linearly reading 40960 bytes... <5>took 81965 cycles
testing memory by linearly writing 40960 bytes... <5>took 135255 cycles
testing memory by linearly reading 1 bytes... <5>took 11 cycles
testing memory by linearly writing 1 bytes... <5>took 15 cycles
memory benchmarking module cleanup complete
loading memory benchmarking module
testing type 0
testing memory by linearly reading 40960 bytes... <5>took 81948 cycles
testing memory by linearly writing 40960 bytes... <5>took 134230 cycles
testing memory by linearly reading 1 bytes... <5>took 11 cycles
testing memory by linearly writing 1 bytes... <5>took 86 cycles
testing type 1
testing memory by linearly reading 40960 bytes... <5>took 81977 cycles
testing memory by linearly writing 40960 bytes... <5>took 136708 cycles
testing memory by linearly reading 1 bytes... <5>took 11 cycles
testing memory by linearly writing 1 bytes... <5>took 15 cycles
memory benchmarking module cleanup complete
loading memory benchmarking module
testing type 0
testing memory by linearly reading 40960 bytes... <5>took 81948 cycles
testing memory by linearly writing 40960 bytes... <5>took 134210 cycles
testing memory by linearly reading 1 bytes... <5>took 11 cycles
testing memory by linearly writing 1 bytes... <5>took 86 cycles
testing type 1
testing memory by linearly reading 40960 bytes... <5>took 81977 cycles
testing memory by linearly writing 40960 bytes... <5>took 166958 cycles
testing memory by linearly reading 1 bytes... <5>took 11 cycles
testing memory by linearly writing 1 bytes... <5>took 15 cycles
memory benchmarking module cleanup complete
loading memory benchmarking module
testing type 0
testing memory by linearly reading 40960 bytes... <5>took 81948 cycles
testing memory by linearly writing 40960 bytes... <5>took 133720 cycles
testing memory by linearly reading 1 bytes... <5>took 11 cycles
testing memory by linearly writing 1 bytes... <5>took 33 cycles
testing type 1
testing memory by linearly reading 40960 bytes... <5>took 143210 cycles
testing memory by linearly writing 40960 bytes... <5>took 319914 cycles
testing memory by linearly reading 1 bytes... <5>took 11 cycles
testing memory by linearly writing 1 bytes... <5>took 15 cycles
memory benchmarking module cleanup complete
loading memory benchmarking module
testing type 0
testing memory by linearly reading 40960 bytes... <5>took 81948 cycles
testing memory by linearly writing 40960 bytes... <5>took 133399 cycles
testing memory by linearly reading 1 bytes... <5>took 11 cycles
testing memory by linearly writing 1 bytes... <5>took 86 cycles
testing type 1
testing memory by linearly reading 40960 bytes... <5>took 81977 cycles
testing memory by linearly writing 40960 bytes... <5>took 135417 cycles
testing memory by linearly reading 1 bytes... <5>took 11 cycles
testing memory by linearly writing 1 bytes... <5>took 15 cycles
memory benchmarking module cleanup complete
loading memory benchmarking module
testing type 0
testing memory by linearly reading 40960 bytes... <5>took 81948 cycles
testing memory by linearly writing 40960 bytes... <5>took 133959 cycles
testing memory by linearly reading 1 bytes... <5>took 11 cycles
testing memory by linearly writing 1 bytes... <5>took 33 cycles
testing type 1
testing memory by linearly reading 40960 bytes... <5>took 81976 cycles
testing memory by linearly writing 40960 bytes... <5>took 135905 cycles
testing memory by linearly reading 1 bytes... <5>took 11 cycles
testing memory by linearly writing 1 bytes... <5>took 84 cycles
memory benchmarking module cleanup complete
loading memory benchmarking module
testing type 0
testing memory by linearly reading 40960 bytes... <5>took 81948 cycles
testing memory by linearly writing 40960 bytes... <5>took 133763 cycles
testing memory by linearly reading 1 bytes... <5>took 25 cycles
testing memory by linearly writing 1 bytes... <5>took 86 cycles
testing type 1
testing memory by linearly reading 40960 bytes... <5>took 81962 cycles
testing memory by linearly writing 40960 bytes... <5>took 170261 cycles
testing memory by linearly reading 1 bytes... <5>took 25 cycles
testing memory by linearly writing 1 bytes... <5>took 15 cycles
memory benchmarking module cleanup complete
loading memory benchmarking module
testing type 0
testing memory by linearly reading 40960 bytes... <5>took 81948 cycles
testing memory by linearly writing 40960 bytes... <5>took 133098 cycles
testing memory by linearly reading 1 bytes... <5>took 11 cycles
testing memory by linearly writing 1 bytes... <5>took 86 cycles
testing type 1
testing memory by linearly reading 40960 bytes... <5>took 81965 cycles
testing memory by linearly writing 40960 bytes... <5>took 196327 cycles
testing memory by linearly reading 1 bytes... <5>took 11 cycles
testing memory by linearly writing 1 bytes... <5>took 15 cycles
memory benchmarking module cleanup complete
loading memory benchmarking module
testing type 0
testing memory by linearly reading 40960 bytes... <5>took 81948 cycles
testing memory by linearly writing 40960 bytes... <5>took 133352 cycles
testing memory by linearly reading 1 bytes... <5>took 25 cycles
testing memory by linearly writing 1 bytes... <5>took 86 cycles
testing type 1
testing memory by linearly reading 40960 bytes... <5>took 81965 cycles
testing memory by linearly writing 40960 bytes... <5>took 135258 cycles
testing memory by linearly reading 1 bytes... <5>took 25 cycles
testing memory by linearly writing 1 bytes... <5>took 15 cycles
memory benchmarking module cleanup complete
loading memory benchmarking module
testing type 0
testing memory by linearly reading 40960 bytes... <5>took 81948 cycles
testing memory by linearly writing 40960 bytes... <5>took 133358 cycles
testing memory by linearly reading 1 bytes... <5>took 11 cycles
testing memory by linearly writing 1 bytes... <5>took 86 cycles
testing type 1
testing memory by linearly reading 40960 bytes... <5>took 81965 cycles
testing memory by linearly writing 40960 bytes... <5>took 135353 cycles
testing memory by linearly reading 1 bytes... <5>took 11 cycles
testing memory by linearly writing 1 bytes... <5>took 15 cycles
memory benchmarking module cleanup complete
loading memory benchmarking module
testing type 0
testing memory by linearly reading 40960 bytes... <5>took 81948 cycles
testing memory by linearly writing 40960 bytes... <5>took 133106 cycles
testing memory by linearly reading 1 bytes... <5>took 26 cycles
testing memory by linearly writing 1 bytes... <5>took 15 cycles
testing type 1
testing memory by linearly reading 40960 bytes... <5>took 81978 cycles
testing memory by linearly writing 40960 bytes... <5>took 134819 cycles
testing memory by linearly reading 1 bytes... <5>took 11 cycles
testing memory by linearly writing 1 bytes... <5>took 15 cycles

--Boundary-00=_BEKoAqElAgFaCzl
Content-Type: text/x-makefile;
  charset="us-ascii";
  name="Makefile"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
	filename="Makefile"

## KBUILD infrastructure Makefile. Used with Linux kernels 2.5 and up.

obj-m += kmem.o
kmem-y := test_kmem.o

--Boundary-00=_BEKoAqElAgFaCzl
Content-Type: text/x-csrc;
  charset="us-ascii";
  name="test_kmem.c"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
	filename="test_kmem.c"

#include <linux/kernel.h>		// for using printk(), etc.
#include <linux/module.h>		// necessary for creating a kernel module
#include <linux/init.h>			// kernel modules as of 2.4 can use macros (see end of file)
#include <linux/version.h>		// for the KERNEL_VERSION macro
#include <linux/slab.h>
#include <linux/vmalloc.h>	/* for vmalloc()	*/

#ifdef CONFIG_X86_TSC
#include <asm/msr.h>			/* a 64bit precision solution, should go a long way */
#else
#include <linux/timex.h>		/* the platform independent solution, normally resorts to 32bit */
#endif

#if LINUX_VERSION_CODE >= KERNEL_VERSION(2,4,25)
#include <linux/moduleparam.h>	// enable module_param(..) and friends support
#endif
#if LINUX_VERSION_CODE < KERNEL_VERSION(2,6,0) /* only necessary when we're not using KBUILD */
#include <linux/version.h>
#endif

MODULE_AUTHOR("Willem de Bruijn");
MODULE_DESCRIPTION("A benchmark comparing performance of kmalloc and vmalloc");
MODULE_LICENSE("GPL");

#ifdef CONFIG_X86_TSC
typedef unsigned long my_clock_t;
inline my_clock_t my_get_cycles(my_clock_t in){
	register unsigned long unused;
	rdtsc(in,unused);
	return in;
}
#else
typedef unsigned long my_clock_t;
inline my_clock_t my_get_cycles(my_clock_t in){
	return get_cycles();
}
#endif

#define TESTLENGTH PAGE_SIZE * 10

static unsigned long do_memperf_linear_read(char* array, int length){
	my_clock_t start, end;
	int i;
	register char j;
	
	printk(KERN_NOTICE "testing memory by linearly reading %d bytes... ",length);
	start = my_get_cycles(start);
	for(i=0; i < length; i++)
		j = array[i];
	end = my_get_cycles(end);
	printk(KERN_NOTICE "took %lu cycles\n", end - start);
	
	return end - start;
}

static unsigned long do_memperf_linear_write(char* array, int length){
	my_clock_t start, end;
	int i;
	
	printk(KERN_NOTICE "testing memory by linearly writing %d bytes... ",length);
	start = my_get_cycles(start);
	for(i=0; i < length; i++)
		array[i] = 1;
	end = my_get_cycles(end);
	printk(KERN_NOTICE "took %lu cycles\n", end - start);
	
	return end - start;
}

static void do_memperf(char* array, int type, int test){
		
	switch (test){
		/* simple read test */
		case 0	: do_memperf_linear_read(array, TESTLENGTH); break;
		/* simple write test */
		case 1	: do_memperf_linear_write(array, TESTLENGTH); break;
		/* worst case read for virtual memory : a single byte */
		case 2	: do_memperf_linear_read(array, 1); break;
		/* worst case write : a single byte */
		case 3	: do_memperf_linear_write(array, 1); break;
	}
}

static int __init memperf_init(void){
	int test;
	int type;
	char* arrays[8];

	printk(KERN_NOTICE "loading memory benchmarking module\n");
	
	/* setup the structures. All at once, so we can measure page misses for each test */
	for (type=0; type < 2; type++){
		for (test=0; test < 4; test++){
			if (type)
				arrays[(type*4)+test] = vmalloc (TESTLENGTH);
			else
				arrays[(type*4)+test] = kmalloc (TESTLENGTH, GFP_KERNEL);
		
			if (!arrays[(type*4)+test]){
				printk(KERN_NOTICE "unable to allocate the required amount of memory. Aborting (memleak occurred)\n");
				return 0;
			}
		}
	}
		
	/* run the tests */
	for (type=0; type < 2; type++){
		printk(KERN_NOTICE "testing type %d\n", type);
		for (test=0; test < 4; test++)
			do_memperf(arrays[(type*4)+test],type, test);
	}
	
	/* and clean up */
	for (type=0; type < 2; type++){
		for (test=0; test < 4; test++){
			if (type)
				vfree(arrays[(type*4)+test]);
			else
				kfree(arrays[(type*4)+test]);
		}
	}
	return 0;
}

/**
	module destruction.
*/
static void __exit memperf_exit(void){

	printk(KERN_NOTICE "memory benchmarking module cleanup complete\n");
	
}

module_init(memperf_init);
module_exit(memperf_exit);




--Boundary-00=_BEKoAqElAgFaCzl--
