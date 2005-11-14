Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751252AbVKNT0j@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751252AbVKNT0j (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 14 Nov 2005 14:26:39 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751253AbVKNT0j
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 14 Nov 2005 14:26:39 -0500
Received: from smtp.osdl.org ([65.172.181.4]:24448 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S1751252AbVKNT0i (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 14 Nov 2005 14:26:38 -0500
Date: Mon, 14 Nov 2005 11:25:54 -0800 (PST)
From: Linus Torvalds <torvalds@osdl.org>
To: Gerd Knorr <kraxel@suse.de>
cc: Dave Jones <davej@redhat.com>, Zachary Amsden <zach@vmware.com>,
       Pavel Machek <pavel@ucw.cz>, Andrew Morton <akpm@osdl.org>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       "H. Peter Anvin" <hpa@zytor.com>,
       Zwane Mwaikambo <zwane@arm.linux.org.uk>,
       Pratap Subrahmanyam <pratap@vmware.com>,
       Christopher Li <chrisl@vmware.com>,
       "Eric W. Biederman" <ebiederm@xmission.com>,
       Ingo Molnar <mingo@elte.hu>
Subject: Re: [PATCH 1/10] Cr4 is valid on some 486s
In-Reply-To: <4378A7F3.9070704@suse.de>
Message-ID: <Pine.LNX.4.64.0511141118000.3263@g5.osdl.org>
References: <200511100032.jAA0WgUq027712@zach-dev.vmware.com>
 <20051111103605.GC27805@elf.ucw.cz> <4374F2D5.7010106@vmware.com>
 <Pine.LNX.4.64.0511111147390.4627@g5.osdl.org> <4374FB89.6000304@vmware.com>
 <Pine.LNX.4.64.0511111218110.4627@g5.osdl.org> <20051113074241.GA29796@redhat.com>
 <Pine.LNX.4.64.0511131118020.3263@g5.osdl.org> <Pine.LNX.4.64.0511131210570.3263@g5.osdl.org>
 <4378A7F3.9070704@suse.de>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Mon, 14 Nov 2005, Gerd Knorr wrote:
> 
> Throwing another patch into the discussion ;)

Ouch, this one is really ugly.

If you want to go this way, then you should instead add an X86_FEATURE_SMP 
that gets cleared on UP and on SMP with just one core (and detect when CPU 
hotplug ain't gonna happen ;), and then do

	#ifdef CONFIG_SMP
	#define smp_alternative(x,y) alternative(x,y,X86_FEATURE_SMP)
	#else
	#define smp_alternative(x,y) asm(x)
	#endif

or something similar, instead of creating a totally new infrastructure to 
do the thing that "alternative()" already does.

(Yeah, the above doesn't really work, since usually the SMP form is the 
longer one, and "alternative()" wants the long complex one first. So maybe 
the x86 feature needs to be "X86_FEATURE_UP" instead, since it's now a 
"feature" to only have one core ;)

			Linus
