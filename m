Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265023AbSKKOsN>; Mon, 11 Nov 2002 09:48:13 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265238AbSKKOsN>; Mon, 11 Nov 2002 09:48:13 -0500
Received: from sb0-cf9a4971.dsl.impulse.net ([207.154.73.113]:38417 "EHLO
	madrabbit.org") by vger.kernel.org with ESMTP id <S265023AbSKKOsL>;
	Mon, 11 Nov 2002 09:48:11 -0500
Subject: Re: [PATCH] Re: sscanf("-1", "%d", &i) fails, returns 0
From: Ray Lee <ray-lk@madrabbit.org>
To: hps@intermeta.de, rddunlap@osdl.org
Cc: Linux Kernel <linux-kernel@vger.kernel.org>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Ximian Evolution 1.0.8 
Date: 11 Nov 2002 06:54:54 -0800
Message-Id: <1037026495.22906.36.camel@orca>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> > What should it do?
> I would model this after user space. (Which does strange things: 

<snip>

It only sounds strange at first. It actually means that scanf is
consistent with C's rules of assignment between mixed types. For
example:

ray:~$ cat signs.c

#include <stdio.h>

main() {
	char scan[]="-100";
	unsigned int u;
	int i;

	sscanf(scan, "%ud", &u);
	sscanf(scan, "%d", &i);
	printf("%s scanned to signed %d and unsigned %u\n", scan, i, u);

	i=-100;
	u=i;
	printf("%d assigned to unsigned int gives %u\n", i, u);
}

ray:~$ ./signs
-100 scanned to signed -100 and unsigned 4294967196
-100 assigned to unsigned int gives 4294967196

So, one should think of scanf as having correct knowledge of the types
it's scanning, and then shoe-horning the result into whatever you asked
for. Just like C itself.

Ray

