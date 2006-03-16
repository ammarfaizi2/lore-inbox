Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932169AbWCPTzn@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932169AbWCPTzn (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 16 Mar 2006 14:55:43 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932686AbWCPTzn
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 16 Mar 2006 14:55:43 -0500
Received: from linux01.gwdg.de ([134.76.13.21]:26496 "EHLO linux01.gwdg.de")
	by vger.kernel.org with ESMTP id S932169AbWCPTzm (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 16 Mar 2006 14:55:42 -0500
Date: Thu, 16 Mar 2006 20:55:28 +0100 (MET)
From: Jan Engelhardt <jengelh@linux01.gwdg.de>
To: Andrew Morton <akpm@osdl.org>
cc: Anton Altaparmakov <aia21@cam.ac.uk>, linux-kernel@vger.kernel.org,
       len.brown@intel.com
Subject: Re: [patch 1/1] consolidate TRUE and FALSE
In-Reply-To: <20060316024234.103d37dc.akpm@osdl.org>
Message-ID: <Pine.LNX.4.61.0603162050160.11776@yvahk01.tjqt.qr>
References: <200603161004.k2GA46Fc029649@shell0.pdx.osdl.net>
 <Pine.LNX.4.64.0603161015130.31173@hermes-2.csi.cam.ac.uk>
 <20060316024234.103d37dc.akpm@osdl.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>
>Is it any good?
>
Depends.

	20:51 shanghai:/dev/shm > cat bool.c
	#include <stdio.h>

	int main(void) {
	    _Bool x = 0;
	    x += 2;
	    printf("%d\n", x);
	}
	20:51 shanghai:/dev/shm > gcc bool.c && ./a.out
	1


It can't "overflow". If that's good or not I can't tell, and I can only 
imagine an artifical scenario where it affects things:


	void do_something_wrong(int *x) {
		*x += 2;
	}

	int x = 0;
	do_something_wrong(&x);
	if(x & 1)
		printf("x & 1");


>From this one, we would expect nothing to be printed. But if x was a _Bool 
x (and _Bool *x, respectively), something would be printed.



Jan Engelhardt
-- 
