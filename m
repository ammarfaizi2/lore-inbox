Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264961AbTGBMFi (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 2 Jul 2003 08:05:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264959AbTGBMFi
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 2 Jul 2003 08:05:38 -0400
Received: from deviant.impure.org.uk ([195.82.120.238]:49050 "EHLO
	deviant.impure.org.uk") by vger.kernel.org with ESMTP
	id S264960AbTGBMFd (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 2 Jul 2003 08:05:33 -0400
Date: Wed, 2 Jul 2003 13:21:37 +0100
From: Dave Jones <davej@codemonkey.org.uk>
To: Zwane Mwaikambo <zwane@arm.linux.org.uk>
Cc: Herbert Xu <herbert@gondor.apana.org.au>, linux-kernel@vger.kernel.org
Subject: Re: To make a function get executed on cpu2
Message-ID: <20030702122137.GA7562@suse.de>
Mail-Followup-To: Dave Jones <davej@codemonkey.org.uk>,
	Zwane Mwaikambo <zwane@arm.linux.org.uk>,
	Herbert Xu <herbert@gondor.apana.org.au>,
	linux-kernel@vger.kernel.org
References: <E19XeSS-0008Rg-00@gondolin.me.apana.org.au> <Pine.LNX.4.53.0307020758001.13565@montezuma.mastecende.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.53.0307020758001.13565@montezuma.mastecende.com>
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jul 02, 2003 at 08:02:19AM -0400, Zwane Mwaikambo wrote:
 > On Wed, 2 Jul 2003, Herbert Xu wrote:
 > 
 > > Surely you can emulate it using smp_call_function and make it return
 > > straight away if it runs on the wrong CPU.
 > 
 > Yes you can, i thought about the same thing, but it simply generates 
 > unecessary APIC bus traffic and just sounds horrid. Not to mention it 
 > doesn't sound all that friendly on larger systems.

See do_cpuid in arch/i386/kernel/cpuid.c for an example of how to do this
properly. It's a bit icky, but works. I've considered writing a generic
run_on_cpu() when I did the on_each_cpu() stuff, but asides from
cpuid.c, msr.c was the only other case I could find from a quick
grep around that really cared, so it didn't seem worth the effort.

		Dave

