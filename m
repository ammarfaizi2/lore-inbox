Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261455AbTIGVlw (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 7 Sep 2003 17:41:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261499AbTIGVlw
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 7 Sep 2003 17:41:52 -0400
Received: from pix-525-pool.redhat.com ([66.187.233.200]:10899 "EHLO
	lacrosse.corp.redhat.com") by vger.kernel.org with ESMTP
	id S261455AbTIGVlu (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 7 Sep 2003 17:41:50 -0400
Date: Sun, 7 Sep 2003 22:39:24 +0100
From: Dave Jones <davej@redhat.com>
To: Andi Kleen <ak@suse.de>
Cc: Adrian Bunk <bunk@fs.tum.de>, marcelo.tosatti@cyclades.com.br,
       linux-kernel@vger.kernel.org, Peter Daum <peter_daum@t-online.de>
Subject: Re: [2.4 patch] fix CONFIG_X86_L1_CACHE_SHIFT
Message-ID: <20030907213924.GA28927@redhat.com>
Mail-Followup-To: Dave Jones <davej@redhat.com>, Andi Kleen <ak@suse.de>,
	Adrian Bunk <bunk@fs.tum.de>, marcelo.tosatti@cyclades.com.br,
	linux-kernel@vger.kernel.org, Peter Daum <peter_daum@t-online.de>
References: <20030907195557.GK14436@fs.tum.de.suse.lists.linux.kernel> <p73u17ojq83.fsf@oldwotan.suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <p73u17ojq83.fsf@oldwotan.suse.de>
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Sep 07, 2003 at 10:30:52PM +0200, Andi Kleen wrote:
 > Adrian Bunk <bunk@fs.tum.de> writes:
 > 
 > > With CONFIG_M686 CONFIG_X86_L1_CACHE_SHIFT was set to 5, but a Pentium 4 
 > > requires 7.
 > It doesn't require 7, it just prefers 7. 

*nod*. This 'fix' also papers over the bug instead of fixing it.
Likely it's something like a network card driver setting its cacheline
size incorrectly. Peter what NIC did you see the problem on ?

I thought Ivan's PCI cacheline sizing fixes from 2.6
(see arch/i386/pci/common.c) already made it into 2.4,
but from a quick grep, it seems that didn't happen.

 > > The patch below does:
 > > - set CONFIG_X86_L1_CACHE_SHIFT 7 for all Intel processors (needed for 
 > >   the Pentium 4)
 > > - set CONFIG_X86_L1_CACHE_SHIFT 6 for the K6 (needed for the Athlon)
 > I think these changes should be only done with CONFIG_X86_GENERIC is set.
 > Otherwise the people who want kernels really optimized for their CPUs
 > won't get the full benefit. On UP it does not make that much difference,
 > but on a SMP kernel having a bigger than needed cache size wastes a lot
 > of memory.

ACK.

		Dave

-- 
 Dave Jones     http://www.codemonkey.org.uk
