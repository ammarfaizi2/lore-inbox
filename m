Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1946725AbWKJTjK@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1946725AbWKJTjK (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 10 Nov 2006 14:39:10 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161875AbWKJTjJ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 10 Nov 2006 14:39:09 -0500
Received: from gw.goop.org ([64.81.55.164]:64724 "EHLO mail.goop.org")
	by vger.kernel.org with ESMTP id S1161669AbWKJTjH (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 10 Nov 2006 14:39:07 -0500
Message-ID: <4554D538.10404@goop.org>
Date: Fri, 10 Nov 2006 11:38:32 -0800
From: Jeremy Fitzhardinge <jeremy@goop.org>
User-Agent: Thunderbird 1.5.0.8 (X11/20061107)
MIME-Version: 1.0
To: Martin Schwidefsky <schwidefsky@googlemail.com>
CC: Avi Kivity <avi@qumranet.com>, Arnd Bergmann <arnd@arndb.de>,
       kvm-devel@lists.sourceforge.net, akpm@osdl.org,
       linux-kernel@vger.kernel.org
Subject: Re: [kvm-devel] [PATCH] KVM: Avoid using vmx instruction directly
References: <20061109110852.A6B712500F7@cleopatra.q>	 <200611091429.42040.arnd@arndb.de> <45532EE3.4000104@qumranet.com>	 <200611091542.31101.arnd@arndb.de> <455340B8.2080206@qumranet.com>	 <4553BC18.6090207@goop.org> <6e0cfd1d0611100446j77a27b29jc23f76a515451377@mail.gmail.com>
In-Reply-To: <6e0cfd1d0611100446j77a27b29jc23f76a515451377@mail.gmail.com>
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Martin Schwidefsky wrote:
> On 11/10/06, Jeremy Fitzhardinge <jeremy@goop.org> wrote:
>> >> Or gcc
>> >> might move the assignment of phys_addr to after the inline assembly.
>> >>
>> > "asm volatile" prevents that (and I'm not 100% sure it's necessary).
>>
>> No, it won't necessarily.  "asm volatile" simply forces gcc to emit the
>> assembler, even if it thinks its output doesn't get used.  It makes no
>> ordering guarantees with respect to other code (or even other "asm
>> volatiles").   The "memory" clobbers should fix the ordering of the asms
>> though.
>
> The "memory" clobber just tells the compiler that any memory object
> might get access by the inline. 

I just meant that two asms with a "memory" clobber will be generated
with a fixed ordering, which "asm volatile" does not necessarily do.

    J
