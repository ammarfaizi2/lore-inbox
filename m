Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261278AbULEHdO@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261278AbULEHdO (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 5 Dec 2004 02:33:14 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261280AbULEHdN
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 5 Dec 2004 02:33:13 -0500
Received: from picard.ine.co.th ([203.152.41.3]:25274 "EHLO picard.ine.co.th")
	by vger.kernel.org with ESMTP id S261278AbULEHct (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 5 Dec 2004 02:32:49 -0500
Subject: Re: 2.6.9, 64bit, 4GB memory => panics ...
From: Rudolf Usselmann <rudi@asics.ws>
Reply-To: rudi@asics.ws
To: Adam Heath <doogie@debian.org>
Cc: Linux Kernel <linux-kernel@vger.kernel.org>
In-Reply-To: <Pine.LNX.4.58.0412050118230.2173@gradall.private.brainfood.com>
References: <1102072834.31282.1450.camel@cpu0>
	 <20041203113704.GD2714@holomorphy.com> <1102225183.3779.15.camel@cpu0>
	 <Pine.LNX.4.61.0412042321080.6378@montezuma.fsmlabs.com>
	 <1102230225.3778.75.camel@cpu0>
	 <Pine.LNX.4.58.0412050118230.2173@gradall.private.brainfood.com>
Content-Type: text/plain
Organization: ASICS.ws - Solutions for your ASICS & FPGA needs -
Message-Id: <1102231963.3780.88.camel@cpu0>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6 
Date: Sun, 05 Dec 2004 14:32:43 +0700
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 2004-12-05 at 14:20, Adam Heath wrote:
> On Sun, 5 Dec 2004, Rudolf Usselmann wrote:
> 
> > int mem[10000];
> > int i, n;
> >
> > for(i=0;i<2000;i++) {
> > 	printf("Doing alloc %0d ...\n",i);
> > 	mem[i] = (int)malloc(1024*1024*1024);
> 
> allocate a 1 gig block, but store it in an int array?  That's wrong.
> 
> > 	if(mem[i] == NULL)
> > 		printf("Malloc failed ...\n");
> > 	else
> > 		for(n=0;n<(1024*1024*1024);n=n+640)	mem[i] = n;
> 
> You alter n, but then always only set mem[i], without varying i.
> 
> Your program is buggy, and memleaks.
> 
> Plus, the kernel uses overcommit by default, and since you aren't actually
> touching the memory you are allocating, you are only limited by the address
> space size allowed per process(depends on how you configured the kernel).



Thanks for pointing that out Adam ! Will this work better:



#include "stdio.h"
#include "stdlib.h"

int main() {

char *mem[10000];
int i, n;

for(i=0;i<2000;i++) {
	printf("Doing alloc %0d ...\n",i);
	mem[i] = (char *)malloc(1024*1024*1024);
	if(mem[i] == NULL)
		printf("Malloc failed ...\n");
	else
		for(n=0;n<(1024*1024*1024);n=n+640)	mem[i][n] = n;
   }

while(1);

return(0);
}


Thanks !
rudi

