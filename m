Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262267AbVERSgX@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262267AbVERSgX (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 18 May 2005 14:36:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262348AbVERSeh
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 18 May 2005 14:34:37 -0400
Received: from mailfe08.swip.net ([212.247.154.225]:49862 "EHLO swip.net")
	by vger.kernel.org with ESMTP id S262285AbVERSdP (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 18 May 2005 14:33:15 -0400
X-T2-Posting-ID: jLUmkBjoqvly7NM6d2gdCg==
Subject: Re: How to diagnose a kernel memory leak
From: Alexander Nyberg <alexn@dsv.su.se>
To: Bruce Guenter <bruceg@em.ca>
Cc: akpm@osdl.org, linux-kernel@vger.kernel.org
In-Reply-To: <20050513212816.GA29230@em.ca>
References: <20050509035823.GA13715@em.ca>
	 <1115627361.936.11.camel@localhost.localdomain>
	 <20050511193726.GA29463@em.ca> <20050512171825.12599c1e.akpm@osdl.org>
	 <20050513212816.GA29230@em.ca>
Content-Type: multipart/mixed; boundary="=-o7vFcyzMfpD6ica8/zGJ"
Date: Wed, 18 May 2005 20:32:53 +0200
Message-Id: <1116441173.23209.17.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.2 
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--=-o7vFcyzMfpD6ica8/zGJ
Content-Type: text/plain
Content-Transfer-Encoding: 7bit

If you don't do reply-to-all there's a chance people will miss out on
your mails...

> > It all looks pretty innocent.  Please send the contents of /proc/meminfo
> > rather than the `free' output.  /proc/meminfo has much more info. 
> 
> Here are the current meminfo numbers:
> 

What's happening with this? It's been a week now so I'm curious.

What you can do is run the attached program, it's a simple memory eater
that will eat the amount of memory you specify, ie. "./a.out 2000" will
simply eat 2G of memory. This is because all caches get reaped to a
minimum leavel and distinguishing trouble makes is easier this way.

If you think the machine has lost memory at this time please do:
gcc memeat.c
./a.out 2000
wait until program is done
save /proc/meminfo
save /proc/page_owner
sort page_owner output

--=-o7vFcyzMfpD6ica8/zGJ
Content-Disposition: attachment; filename=memeat.c
Content-Type: text/x-csrc; name=memeat.c; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit

#include <stdio.h>
#include <stdlib.h>

#define page_size 4096


int main(int argc, char *argv[])
{
	long size = strtoul(argv[1], NULL, 0);
	long curr = 0;

	printf("allocating %ldmb\n", size);
	
	size *= 1024 * 1024;

	while (curr <= size) {
		char *ptr = malloc(page_size);

		if (!ptr) {
			printf("Couldn't allocate after %ld\n", curr);
			sleep(1);
			continue;
		}
			
		memset(ptr, 0, page_size);
		curr += page_size;
	}

	return 0;
}
		


--=-o7vFcyzMfpD6ica8/zGJ--

