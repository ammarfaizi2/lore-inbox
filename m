Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261277AbULEHaE@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261277AbULEHaE (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 5 Dec 2004 02:30:04 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261278AbULEHaE
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 5 Dec 2004 02:30:04 -0500
Received: from 70-56-133-193.albq.qwest.net ([70.56.133.193]:57277 "EHLO
	montezuma.fsmlabs.com") by vger.kernel.org with ESMTP
	id S261277AbULEH35 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 5 Dec 2004 02:29:57 -0500
Date: Sun, 5 Dec 2004 00:29:35 -0700 (MST)
From: Zwane Mwaikambo <zwane@arm.linux.org.uk>
To: Rudolf Usselmann <rudi@asics.ws>
cc: Linux Kernel <linux-kernel@vger.kernel.org>
Subject: Re: 2.6.9, 64bit, 4GB memory => panics ...
In-Reply-To: <1102230225.3778.75.camel@cpu0>
Message-ID: <Pine.LNX.4.61.0412050025240.6378@montezuma.fsmlabs.com>
References: <1102072834.31282.1450.camel@cpu0>  <20041203113704.GD2714@holomorphy.com>
 <1102225183.3779.15.camel@cpu0>  <Pine.LNX.4.61.0412042321080.6378@montezuma.fsmlabs.com>
 <1102230225.3778.75.camel@cpu0>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 5 Dec 2004, Rudolf Usselmann wrote:

> // -------------------------- eat mem ---------------------------------
> 
> #include "stdio.h"
> #include "stdlib.h"
> 
> int main() {
> 
> int mem[10000];

Array of integers, you probably want int *mem[10000] if anything.

> int i, n;
> 
> for(i=0;i<2000;i++) {
> 	printf("Doing alloc %0d ...\n",i);
> 	mem[i] = (int)malloc(1024*1024*1024);

Wrongly assigning pointer to signed integer, casting can sometimes be 
evil.

> 	if(mem[i] == NULL)
> 		printf("Malloc failed ...\n");
> 	else
> 		for(n=0;n<(1024*1024*1024);n=n+640)	mem[i] = n;

You lose the pointer value here and do not touch the allocated memory, 
which means that the VM isn't forced to commit the memory you allocated. 
You also want to be looking at the Committed_AS and Mapped fields of 
/proc/meminfo

