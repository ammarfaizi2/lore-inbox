Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751449AbVKOQQl@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751449AbVKOQQl (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 15 Nov 2005 11:16:41 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751444AbVKOQQl
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 15 Nov 2005 11:16:41 -0500
Received: from ns.suse.de ([195.135.220.2]:46506 "EHLO mx1.suse.de")
	by vger.kernel.org with ESMTP id S1751450AbVKOQQk (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 15 Nov 2005 11:16:40 -0500
Message-ID: <437A09E5.6080306@suse.de>
Date: Tue, 15 Nov 2005 17:16:37 +0100
From: Gerd Knorr <kraxel@suse.de>
User-Agent: Mozilla Thunderbird 1.0.6 (X11/20050715)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Zachary Amsden <zach@vmware.com>
Cc: Linus Torvalds <torvalds@osdl.org>, Dave Jones <davej@redhat.com>,
       Pavel Machek <pavel@ucw.cz>, Andrew Morton <akpm@osdl.org>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       "H. Peter Anvin" <hpa@zytor.com>,
       Zwane Mwaikambo <zwane@arm.linux.org.uk>,
       Pratap Subrahmanyam <pratap@vmware.com>,
       Christopher Li <chrisl@vmware.com>,
       "Eric W. Biederman" <ebiederm@xmission.com>,
       Ingo Molnar <mingo@elte.hu>
Subject: Re: [PATCH 1/10] Cr4 is valid on some 486s
References: <200511100032.jAA0WgUq027712@zach-dev.vmware.com> <20051111103605.GC27805@elf.ucw.cz> <4374F2D5.7010106@vmware.com> <Pine.LNX.4.64.0511111147390.4627@g5.osdl.org> <4374FB89.6000304@vmware.com> <Pine.LNX.4.64.0511111218110.4627@g5.osdl.org> <20051113074241.GA29796@redhat.com> <Pine.LNX.4.64.0511131118020.3263@g5.osdl.org> <Pine.LNX.4.64.0511131210570.3263@g5.osdl.org> <4378A7F3.9070704@suse.de> <Pine.LNX.4.64.0511141118000.3263@g5.osdl.org> <4379ECC1.20005@suse.de> <437A0649.7010702@suse.de> <437A0710.4020107@vmware.com>
In-Reply-To: <437A0710.4020107@vmware.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Zachary Amsden wrote:
> You still need to preserve the originals so that you can patch in both 
> directions.  In the dynamic scenario, you need a multi-way set of 
> alternatives, with the most conservative of those compiled in inline.

Sure, alternatives_smp() puts both versions into the 
.altinstr_replacement section because of that ;)

The idea is to have SMP compiled in and let the normal 
apply_alternatives() handle the SMP->UP patching case using the new 
feature bit.  apply_alternatives_smp() handles UP->SMP patching when you 
plug in a new virtual CPU.

cheers,

   Gerd

