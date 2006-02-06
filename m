Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932124AbWBFQLh@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932124AbWBFQLh (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 6 Feb 2006 11:11:37 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932196AbWBFQLh
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 6 Feb 2006 11:11:37 -0500
Received: from omx1-ext.sgi.com ([192.48.179.11]:7120 "EHLO
	omx1.americas.sgi.com") by vger.kernel.org with ESMTP
	id S932124AbWBFQLh (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 6 Feb 2006 11:11:37 -0500
Date: Mon, 6 Feb 2006 08:11:28 -0800 (PST)
From: Christoph Lameter <clameter@engr.sgi.com>
To: Andi Kleen <ak@suse.de>
cc: discuss@x86-64.org, bharata@in.ibm.com, linux-kernel@vger.kernel.org
Subject: Re: [discuss] mmap, mbind and write to mmap'ed memory crashes
 2.6.16-rc1[2] on 2 node X86_64
In-Reply-To: <200602051803.59437.ak@suse.de>
Message-ID: <Pine.LNX.4.62.0602060807530.15863@schroedinger.engr.sgi.com>
References: <20060205163618.GB21972@in.ibm.com> <200602051803.59437.ak@suse.de>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 5 Feb 2006, Andi Kleen wrote:

> > The kernel crashes when I run an application which does:
> > 	- mmap (0, size, PROT_READ|PROT_WRITE, MAP_PRIVATE|MAP_ANONYMOUS)
> > 	- mbind the memory to the 1st node with policy MPOL_BIND
> > 	- write to that memory

Tried the following code on rc1 and rc2 and it worked fine on ia64:

#include <stdio.h>
#include <stdlib.h>
#include <sys/mman.h>
#include <numaif.h>

int main(int argc, void *argv[])
{
	char *p;
	unsigned long nodes = 0x01;

	p = mmap(0, 32768, PROT_READ| PROT_WRITE, MAP_PRIVATE| MAP_ANONYMOUS, 0, 0);
	mbind(p, 32768, MPOL_BIND, &nodes, 64, 0);
	p[34] = 89;
	return 0;
}
 
