Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263636AbTKKRgz (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 11 Nov 2003 12:36:55 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263638AbTKKRgy
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 11 Nov 2003 12:36:54 -0500
Received: from e3.ny.us.ibm.com ([32.97.182.103]:30707 "EHLO e3.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id S263636AbTKKRgx (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 11 Nov 2003 12:36:53 -0500
Date: Tue, 11 Nov 2003 10:02:03 -0800
From: "Martin J. Bligh" <mbligh@aracnet.com>
To: Erik Jacobson <erikj@subway.americas.sgi.com>,
       linux-kernel@vger.kernel.org
Subject: Re: 2.6 /proc/interrupts fails on systems with many CPUs
Message-ID: <9710000.1068573723@flay>
In-Reply-To: <Pine.SGI.4.53.0311111116440.360387@subway.americas.sgi.com>
References: <Pine.SGI.4.53.0311111116440.360387@subway.americas.sgi.com>
X-Mailer: Mulberry/2.1.2 (Linux/x86)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> On systems with lots of processors (512 for example), catting /proc/interrupts
> fails with a "not enough memory" error.
> 
> This was observed in 2.6.0-test8
> 
> I tracked this down to this in proc_misc.c:
> 
> static int interrupts_open(struct inode *inode, struct file *file)
> {
>    unsigned size = 4096 * (1 + num_online_cpus() / 8);
>    char *buf = kmalloc(size, GFP_KERNEL);
> 
> The kmalloc fails here.
> 
> I'm looking for suggestions on how to fix this.  I came up with one fix
> that seems to work OK for ia64.  I have attached it to this message.
> I'm looking for advice on what should be proposed for the real fix.

I think it'd make more sense to only use vmalloc when it's explicitly 
too big for kmalloc - or simply switch on num_online_cpus > 100 or 
whatever a sensible cutoff is (ie nobody but you would ever see this ;-))

M.

