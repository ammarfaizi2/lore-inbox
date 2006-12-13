Return-Path: <linux-kernel-owner+w=401wt.eu-S964943AbWLMGOp@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964943AbWLMGOp (ORCPT <rfc822;w@1wt.eu>);
	Wed, 13 Dec 2006 01:14:45 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964945AbWLMGOp
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 13 Dec 2006 01:14:45 -0500
Received: from web27404.mail.ukl.yahoo.com ([217.146.177.180]:30760 "HELO
	web27404.mail.ukl.yahoo.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with SMTP id S964943AbWLMGOo (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 13 Dec 2006 01:14:44 -0500
X-Greylist: delayed 401 seconds by postgrey-1.27 at vger.kernel.org; Wed, 13 Dec 2006 01:14:44 EST
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
  s=s1024; d=yahoo.co.uk;
  h=Message-ID:X-YMail-OSG:Received:Date:From:Subject:To:MIME-Version:Content-Type:Content-Transfer-Encoding;
  b=AL03oRoWiGie2HO2/d6oRUNuzmbgo+IMfY9UfI8HwOWUPFIOPEObFaV3L4jFS+2t16Vh2/BrbYTNvH++lpXjLW2uybMrKcK/KTVCm8spRU4xfDyf9Pp/NbtiU9k4LTELCkwDX5dXq7QGe5udp7vAqTjFMKnDqjwc7NE696hLKuU=  ;
Message-ID: <20061213060802.78275.qmail@web27404.mail.ukl.yahoo.com>
X-YMail-OSG: bLfFNI4VM1k8ACYrV1TXe5XqfkRnuxn8zMAsy6MgCGXuFtLPgG5APO42b6Q0CDc6Lxf0D4aLc.wogbtR8p6EWN5rAPgDWfXLbJ.WnZa0jr89jVP6jKA-
Date: Wed, 13 Dec 2006 06:08:02 +0000 (GMT)
From: ranjith kumar <ranjit_kumar_b4u@yahoo.co.uk>
Subject: writing to performance monitoring register
To: linux-kernel@vger.kernel.org
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,
    I want to measure number of last level cache
misses in Pentium 4 processor. In IA-32 programmers
manuals it was given that there are (architectural=
same across all IA-32 processors)perfomance monitoring
counters starting at address   0c1H and
performance_event_select registers starting at address
186H. 

1) When I tried to run a kernel module to write some
value in performance event select register (with
address 186H) by wrmsr instruction, the system is
hanging.Why?
The program is :
#include <linux/module.h> /* Needed by all modules */
#include <linux/kernel.h> /* Needed for KERN_INFO */
//#include<xmmintrin.h>
int i,j,k=0;
unsigned int xx,yy,xx1,yy1,xx2,yy2;
unsigned int t1,t2,t3,t4,BIG=0xffffffff;
int init_module(void)
{

asm volatile (" movl $0x186, %%ecx;"
	      " movl $0x0,   %%edx;"
	      " movl $0x0009412E, %%eax;"
	      " wrmsr;"
		:
		:
		:"%eax","%edx","%ecx"); 


printk(KERN_INFO " Initially %u=t1 %u=t2 %u=t3 %u=t4
\n",t1,t2,t3,t4);
 return 0;
}


void cleanup_module(void)
{
printk(KERN_INFO "Goodbye world \n");
}
-------------------------------------------------------
 2) Why I am getting compilation errors when I tried
to include <xmmintrin.h> or <stdio.h> ....files?

Thanks in advane.


		
___________________________________________________________ 
All New Yahoo! Mail – Tired of Vi@gr@! come-ons? Let our SpamGuard protect you. http://uk.docs.yahoo.com/nowyoucan.html
