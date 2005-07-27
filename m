Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261414AbVG0D5N@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261414AbVG0D5N (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 26 Jul 2005 23:57:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261688AbVG0D5N
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 26 Jul 2005 23:57:13 -0400
Received: from [213.184.187.171] ([213.184.187.171]:57867 "EHLO raad.intranet")
	by vger.kernel.org with ESMTP id S261414AbVG0D5L (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 26 Jul 2005 23:57:11 -0400
Message-Id: <200507270354.GAA27975@raad.intranet>
From: "Al Boldi" <a1426z@gawab.com>
To: "'Adrian Bunk'" <bunk@stusta.de>
Cc: "'Linux kernel'" <linux-kernel@vger.kernel.org>,
       "'Horst von Brand'" <vonbrand@inf.utfsm.cl>
Subject: RE: kernel optimization 
Date: Wed, 27 Jul 2005 06:53:02 +0300
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 7bit
X-Mailer: Microsoft Office Outlook, Build 11.0.5510
Thread-Index: AcWSXq+kFc63za7KSiqD8JG5/o55bw==
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2600.0000
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Adrian Bunk wrote: {
On Tue, Jul 26, 2005 at 08:22:59AM +0300, Al Boldi wrote:
> Dr. Horst H. von Brand wrote: {
> Al Boldi <a1426z@gawab.com> wrote:
> >  Adrian Bunk wrote: {
> > On Fri, Jul 22, 2005 at 07:55:48PM +0100, christos gentsis wrote:
> > > i would like to ask if it possible to change the optimization of the 
> > > kernel from -O2 to -O3 :D, how can i do that? if i change it to the 
> > > top level Makefile does it change to all the Makefiles?
> > And since it's larger, it's also slower.
> > }
> 
> > It's faster but it's flawed.  Root-NFS boot failed!
> 
> How do you know that it is faster if it is busted?
> }
> 
> The -O3 compile produces a faster kernel, which seems to work perfectly,
> albeit the Root-NFS boot flaw!

How did you measure that you that your -O3 kernel isn't slower?
}

Gettimeofday loops using gcc-3.2.2 on 2.4.31 and 2.6.12.

Also, 2.4 is faster than 2.6!

Try this:

#define __USE_GNU
#include <stdio.h>
#include <sys/time.h>

unsigned long elapsed(int start) {

	static struct timeval s,e;

	if (start) return gettimeofday(&s, NULL);

	gettimeofday(&e, NULL);

	return ((e.tv_sec - s.tv_sec) * 1000 + (e.tv_usec - s.tv_usec) /
1000);

}

int main(int argc, char *argv[]) {

	int i;
	
	elapsed(1);
	for (i = 0; elapsed(0) < 100; i++) {
		int ret = i;

		if (ret > i)
			break;
		else if (ret < 0) {
			perror("not here");
			break;
		}
		ret++;
	}

	printf("Elapsed: %lu in %lums %lu/ms",i,elapsed(0),i/elapsed(0));

	int tmo=i;

	elapsed(1);
	for (i = 0; i < 100*tmo ; i++) {
		int ret = i;

		if (ret > i)
			break;
		else if (ret < 0) {
			perror("not here");
			break;
		}
		ret++;
	}

	printf(" - %lu/ms",i/elapsed(0));

	elapsed(1);
	for (i = 0; i < 100*tmo ; i++);

	printf(" - %lu/ms\n",i/elapsed(0));

	return 0;
}

--
Al

