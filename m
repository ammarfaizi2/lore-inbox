Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1031280AbWKUSga@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1031280AbWKUSga (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 21 Nov 2006 13:36:30 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1031282AbWKUSga
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 21 Nov 2006 13:36:30 -0500
Received: from terminus.zytor.com ([192.83.249.54]:9955 "EHLO
	terminus.zytor.com") by vger.kernel.org with ESMTP id S1031280AbWKUSg3
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 21 Nov 2006 13:36:29 -0500
Message-ID: <45634704.8020407@zytor.com>
Date: Tue, 21 Nov 2006 10:35:48 -0800
From: "H. Peter Anvin" <hpa@zytor.com>
User-Agent: Thunderbird 1.5.0.8 (X11/20061107)
MIME-Version: 1.0
To: Jeremy Fitzhardinge <jeremy@goop.org>
CC: Avi Kivity <avi@qumranet.com>, Arnd Bergmann <arnd@arndb.de>,
       kvm-devel@lists.sourceforge.net, akpm@osdl.org,
       linux-kernel@vger.kernel.org
Subject: Re: [kvm-devel] [PATCH] KVM: Avoid using vmx instruction directly
References: <20061109110852.A6B712500F7@cleopatra.q> <200611091429.42040.arnd@arndb.de> <45532EE3.4000104@qumranet.com> <200611091542.31101.arnd@arndb.de> <455340B8.2080206@qumranet.com> <4553BC18.6090207@goop.org>
In-Reply-To: <4553BC18.6090207@goop.org>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Jeremy Fitzhardinge wrote:
> Avi Kivity wrote:
>>> Or gcc
>>> might move the assignment of phys_addr to after the inline assembly.
>>>   
>> "asm volatile" prevents that (and I'm not 100% sure it's necessary).
> 
> No, it won't necessarily.  "asm volatile" simply forces gcc to emit the
> assembler, even if it thinks its output doesn't get used.  It makes no
> ordering guarantees with respect to other code (or even other "asm
> volatiles").   The "memory" clobbers should fix the ordering of the asms
> though.
> 

I think you're wrong about that; in particular, I'm pretty sure "asm 
volatiles" are ordered among themselves.  What the "volatile" means is 
"this has side effects you (the compiler) don't understand", and gcc 
can't assume that it can reorder such side effects.

	-hpa
