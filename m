Return-Path: <linux-kernel-owner+w=401wt.eu-S1161054AbXAHXBq@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161054AbXAHXBq (ORCPT <rfc822;w@1wt.eu>);
	Mon, 8 Jan 2007 18:01:46 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161098AbXAHXBq
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 8 Jan 2007 18:01:46 -0500
Received: from smtp.osdl.org ([65.172.181.24]:51469 "EHLO smtp.osdl.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1161064AbXAHXBl (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 8 Jan 2007 18:01:41 -0500
Date: Mon, 8 Jan 2007 14:57:33 -0800 (PST)
From: Linus Torvalds <torvalds@osdl.org>
To: Adrian Bunk <bunk@stusta.de>
cc: "Eric W. Biederman" <ebiederm@xmission.com>,
       Tobias Diedrich <ranma+kernel@tdiedrich.de>,
       Yinghai Lu <yinghai.lu@amd.com>, Andrew Morton <akpm@osdl.org>,
       Andi Kleen <ak@suse.de>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       mingo@redhat.com, discuss@x86-64.org
Subject: Re: [PATCH 4/4] x86_64 ioapic: Improve the heuristics for when
 check_timer fails.
In-Reply-To: <20070108223355.GI6167@stusta.de>
Message-ID: <Pine.LNX.4.64.0701081454240.3661@woody.osdl.org>
References: <5986589C150B2F49A46483AC44C7BCA490733F@ssvlexmb2.amd.com>
 <86802c440701022223q418bd141qf4de8ab149bf144b@mail.gmail.com>
 <20070108005556.GA2542@melchior.yamamaya.is-a-geek.org>
 <Pine.LNX.4.64.0701071708240.3661@woody.osdl.org> <m1lkkdikmn.fsf_-_@ebiederm.dsl.xmission.com>
 <m1hcv1ikfj.fsf_-_@ebiederm.dsl.xmission.com> <m1d55pikbc.fsf_-_@ebiederm.dsl.xmission.com>
 <m18xgdijmb.fsf_-_@ebiederm.dsl.xmission.com> <20070108202105.GB6167@stusta.de>
 <m1k5zxgplv.fsf@ebiederm.dsl.xmission.com> <20070108223355.GI6167@stusta.de>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Mon, 8 Jan 2007, Adrian Bunk wrote:
> 
> We just got a completely different bug reported that was confirmed to be 
> caused by Andi's patch:
>    AMD64/ATI : timer is running twice as fast as it should [1]

Yeah. I have to say, that with my main goal for 2.6.20 being a stability 
release, and the APIC setup scaring me too, I'm starting to strongly lean 
towards just reverting the thing, and then having this whole thing 
re-introduced early during the 2.6.21 cycle with the new information we 
have (ie the clues about exactly why the dang thing broke in the first 
place).

After all, the only reason I didn't want to revert the commit initially 
was that it did clean things up, and I wanted to understand why it didn't 
work. I think we understand why it caused problems, and I think we can fix 
them, but on the other hand, we're already deep into -rc4 with this, so 
let's just revert for now and then clean it up correctly after the 2.6.20 
release.

		Linus
