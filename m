Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964787AbVKMHnP@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964787AbVKMHnP (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 13 Nov 2005 02:43:15 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964850AbVKMHnO
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 13 Nov 2005 02:43:14 -0500
Received: from mx1.redhat.com ([66.187.233.31]:58012 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S964787AbVKMHnO (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 13 Nov 2005 02:43:14 -0500
Date: Sun, 13 Nov 2005 02:42:41 -0500
From: Dave Jones <davej@redhat.com>
To: Linus Torvalds <torvalds@osdl.org>
Cc: Zachary Amsden <zach@vmware.com>, Pavel Machek <pavel@ucw.cz>,
       Andrew Morton <akpm@osdl.org>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       "H. Peter Anvin" <hpa@zytor.com>,
       Zwane Mwaikambo <zwane@arm.linux.org.uk>,
       Pratap Subrahmanyam <pratap@vmware.com>,
       Christopher Li <chrisl@vmware.com>,
       "Eric W. Biederman" <ebiederm@xmission.com>,
       Ingo Molnar <mingo@elte.hu>
Subject: Re: [PATCH 1/10] Cr4 is valid on some 486s
Message-ID: <20051113074241.GA29796@redhat.com>
Mail-Followup-To: Dave Jones <davej@redhat.com>,
	Linus Torvalds <torvalds@osdl.org>,
	Zachary Amsden <zach@vmware.com>, Pavel Machek <pavel@ucw.cz>,
	Andrew Morton <akpm@osdl.org>,
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
	"H. Peter Anvin" <hpa@zytor.com>,
	Zwane Mwaikambo <zwane@arm.linux.org.uk>,
	Pratap Subrahmanyam <pratap@vmware.com>,
	Christopher Li <chrisl@vmware.com>,
	"Eric W. Biederman" <ebiederm@xmission.com>,
	Ingo Molnar <mingo@elte.hu>
References: <200511100032.jAA0WgUq027712@zach-dev.vmware.com> <20051111103605.GC27805@elf.ucw.cz> <4374F2D5.7010106@vmware.com> <Pine.LNX.4.64.0511111147390.4627@g5.osdl.org> <4374FB89.6000304@vmware.com> <Pine.LNX.4.64.0511111218110.4627@g5.osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.64.0511111218110.4627@g5.osdl.org>
User-Agent: Mutt/1.4.2.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Nov 11, 2005 at 12:22:07PM -0800, Linus Torvalds wrote:
 > 
 > 
 > On Fri, 11 Nov 2005, Zachary Amsden wrote:
 > > 
 > > Yes, this is fine, but is it worth writing the feature discovery code?  I
 > > suppose it doesn't matter, as it gets jettisoned after init.  I guess it is
 > > just preference.
 > 
 > Well, you could do the feature discovery by trying to take a fault early 
 > at boot-time. That's how we verify that write-protect works, and how we 
 > check that math exceptions come in the right way..
 > 
 > > Could we consider doing the same with LOCK prefix for SMP kernels booted on
 > > UP?  Evil grin.
 > 
 > Not so evil - I think it's been discussed. Not with alternates (not worth 
 > it), but it wouldn't be hard to do: just add a new section for "lock 
 > address", and have each inline asm that does a lock prefix do basically
 > 
 > 	1:
 > 		lock ; xyzzy
 > 
 > 	.section .lock.address
 > 	.long 1b
 > 	.previous
 > 
 > and then just walk the ".lock.address" thing and turn all locks into 0x90 
 > (nop).

Looks like the Ubuntu people already did this...

http://www.kernel.org/git/?p=linux/kernel/git/bcollins/ubuntu-2.6.git;a=commitdiff;h=048985336e32efe665cddd348e92e4a4a5351415;hp=1cb630c2b5aaad7cedaa78aa135e6cecf5ab91ac

		Dave

