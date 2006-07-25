Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932471AbWGYFca@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932471AbWGYFca (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 25 Jul 2006 01:32:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932472AbWGYFca
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 25 Jul 2006 01:32:30 -0400
Received: from smtp.osdl.org ([65.172.181.4]:38803 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S932471AbWGYFc3 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 25 Jul 2006 01:32:29 -0400
Date: Mon, 24 Jul 2006 22:32:17 -0700 (PDT)
From: Linus Torvalds <torvalds@osdl.org>
To: Andrew Morton <akpm@osdl.org>
cc: Edgar Hucek <hostmaster@ed-soft.at>, ebiederm@xmission.com, hpa@zytor.com,
       linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/1] Add efi e820 memory mapping on x86 [try #1]
In-Reply-To: <20060724212911.32dd3bc0.akpm@osdl.org>
Message-ID: <Pine.LNX.4.64.0607242227340.29649@g5.osdl.org>
References: <44A04F5F.8030405@ed-soft.at> <Pine.LNX.4.64.0606261430430.3927@g5.osdl.org>
 <44A0CCEA.7030309@ed-soft.at> <Pine.LNX.4.64.0606262318341.3927@g5.osdl.org>
 <44A304C1.2050304@zytor.com> <m1ac7r9a9n.fsf@ebiederm.dsl.xmission.com>
 <44A8058D.3030905@zytor.com> <m11wt3983j.fsf@ebiederm.dsl.xmission.com>
 <44AB8878.7010203@ed-soft.at> <m1lkr83v73.fsf@ebiederm.dsl.xmission.com>
 <44B6BF2F.6030401@ed-soft.at> <Pine.LNX.4.64.0607131507220.5623@g5.osdl.org>
 <44B73791.9080601@ed-soft.at> <Pine.LNX.4.64.0607140901200.5623@g5.osdl.org>
 <44B9FF02.3020600@ed-soft.at> <20060724212911.32dd3bc0.akpm@osdl.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Mon, 24 Jul 2006, Andrew Morton wrote:
> 
> > This Patch add an efi e820 memory mapping.
> > 
> 
> Why?

EFI is this other Intel brain-damage (the first one being ACPI). It's 
totally different from a normal BIOS, and was brought on by ia64, which 
never had a BIOS, of course. 

Sadly, Apple bought into the whole "BIOS bad, EFI good" hype, so we now 
have x86 machines with EFI as the native boot protocol.

The original EFI code in the kernel basically duplicates all the BIOS 
interfaces (ie everything that looks at a memory map comes in two 
varieties: the normal and tested BIOS e820 variety, and the usually broken 
and hacked-up EFI memory map variety).

Translating the EFI memory map to e820 is very much the sane thing to do, 
and should have been done by ia64 in the first place. Sadly, EFI people 
(a) think that their stinking mess is better than a BIOS and (b) are 
historically ia64-only, so they didn't do that, but went the "we'll just 
duplicate everything using our inferior EFI interfaces" way.

Edgars patch looks fine per se, I'd just wish we had more testers (or, 
alternatively, people would just use bootcamp and make their Apple 
machines look like PC's, but see (a) above).

		Linus
