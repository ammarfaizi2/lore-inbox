Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932594AbVKPJ6s@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932594AbVKPJ6s (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 16 Nov 2005 04:58:48 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932595AbVKPJ6s
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 16 Nov 2005 04:58:48 -0500
Received: from ns2.suse.de ([195.135.220.15]:44459 "EHLO mx2.suse.de")
	by vger.kernel.org with ESMTP id S932594AbVKPJ6r (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 16 Nov 2005 04:58:47 -0500
Message-ID: <437B02C8.4080504@suse.de>
Date: Wed, 16 Nov 2005 10:58:32 +0100
From: Gerd Knorr <kraxel@suse.de>
User-Agent: Mozilla Thunderbird 1.0.6 (X11/20050715)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Roland Dreier <rolandd@cisco.com>
Cc: Linus Torvalds <torvalds@osdl.org>, Dave Jones <davej@redhat.com>,
       Zachary Amsden <zach@vmware.com>, Pavel Machek <pavel@ucw.cz>,
       Andrew Morton <akpm@osdl.org>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       "H. Peter Anvin" <hpa@zytor.com>,
       Zwane Mwaikambo <zwane@arm.linux.org.uk>,
       Pratap Subrahmanyam <pratap@vmware.com>,
       Christopher Li <chrisl@vmware.com>,
       "Eric W. Biederman" <ebiederm@xmission.com>,
       Ingo Molnar <mingo@elte.hu>
Subject: Re: [PATCH 1/10] Cr4 is valid on some 486s
References: <200511100032.jAA0WgUq027712@zach-dev.vmware.com>	<20051111103605.GC27805@elf.ucw.cz> <4374F2D5.7010106@vmware.com>	<Pine.LNX.4.64.0511111147390.4627@g5.osdl.org>	<4374FB89.6000304@vmware.com>	<Pine.LNX.4.64.0511111218110.4627@g5.osdl.org>	<20051113074241.GA29796@redhat.com>	<Pine.LNX.4.64.0511131118020.3263@g5.osdl.org>	<Pine.LNX.4.64.0511131210570.3263@g5.osdl.org>	<4378A7F3.9070704@suse.de>	<Pine.LNX.4.64.0511141118000.3263@g5.osdl.org>	<4379ECC1.20005@suse.de> <437A0649.7010702@suse.de> <52r79h7v2f.fsf@cisco.com>
In-Reply-To: <52r79h7v2f.fsf@cisco.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Roland Dreier wrote:
>     > +#define alternative_smp(smpinstr, upinstr) asm(upinstr, ##input)
> 
> this wouldn't build with CONFIG_SMP=n -- you forgot the input param here.

Yep, and I've noticed meanwhile that it becomes quite messy if you try 
to do that with asm instructions which have both input and output 
parameters.  One way around that would be to use named parameters in the 
inline assembler.  Problem with that is that only gcc >= 3.1 understands 
those and at the moment the minimun requited compiler for the kernel 
still is gcc 2.95.3 according to Documentation/Changes ...

Is it an option to raise the required gcc version to 3.x, given that 
even Debian/stable ships with gcc 3.3 these days?

cheers,

   Gerd

