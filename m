Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751540AbWH3Fpw@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751540AbWH3Fpw (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 30 Aug 2006 01:45:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751536AbWH3Fpw
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 30 Aug 2006 01:45:52 -0400
Received: from terminus.zytor.com ([192.83.249.54]:18841 "EHLO
	terminus.zytor.com") by vger.kernel.org with ESMTP id S1751527AbWH3Fpv
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 30 Aug 2006 01:45:51 -0400
Message-ID: <44F525BC.4020608@zytor.com>
Date: Tue, 29 Aug 2006 22:44:28 -0700
From: "H. Peter Anvin" <hpa@zytor.com>
User-Agent: Thunderbird 1.5.0.5 (X11/20060808)
MIME-Version: 1.0
To: Andi Kleen <ak@suse.de>
CC: Arnd Bergmann <arnd@arndb.de>, David Woodhouse <dwmw2@infradead.org>,
       David Miller <davem@davemloft.net>, linux-arch@vger.kernel.org,
       jdike@addtoit.com, B.Steinbrink@gmx.de, arjan@infradead.org,
       chase.venters@clientec.com, akpm@osdl.org, rmk+lkml@arm.linux.org.uk,
       rusty@rustcorp.com.au, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 6/7] remove all remaining _syscallX macros
References: <200608281003.02757.ak@suse.de> <1156759232.5340.36.camel@pmac.infradead.org> <200608281606.00602.arnd@arndb.de> <200608281642.21737.ak@suse.de>
In-Reply-To: <200608281642.21737.ak@suse.de>
Content-Type: text/plain; charset=ISO-8859-15; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andi Kleen wrote:
> On Monday 28 August 2006 16:05, Arnd Bergmann wrote:
> 
>> The patch below should address both these issues, as long as the libc
>> has a working implementation of syscall(2).
> 
> I would prefer the _syscall() macros to stay independent of the 
> actual glibc version. Or what do you do otherwise on a system
> with old glibc? Upgrading glibc is normally a major PITA.
> 

Why don't you just have a private version of the macros?

syscall(2) is, again, a horrible botch -- on architectures which 
requires alignment for register pairs, the extra register buggers up the 
alignment.  One *can* work around it by making the syscall number 64 
bits, but I think it's safe to say that no libc does that currently.

	-hpa
