Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751153AbWHGIRr@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751153AbWHGIRr (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 7 Aug 2006 04:17:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751156AbWHGIRr
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 7 Aug 2006 04:17:47 -0400
Received: from public.id2-vpn.continvity.gns.novell.com ([195.33.99.129]:54734
	"EHLO emea1-mh.id2.novell.com") by vger.kernel.org with ESMTP
	id S1751153AbWHGIRq (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 7 Aug 2006 04:17:46 -0400
Message-Id: <44D7136E.76E4.0078.0@novell.com>
X-Mailer: Novell GroupWise Internet Agent 7.0.1 
Date: Mon, 07 Aug 2006 09:18:22 +0100
From: "Jan Beulich" <jbeulich@novell.com>
To: "Andi Kleen" <ak@muc.de>, "Andrew Morton" <akpm@osdl.org>
Cc: "Michal Piotrowski" <michal.k.k.piotrowski@gmail.com>, <torvalds@osdl.org>,
       <davej@redhat.com>, <linux-kernel@vger.kernel.org>
Subject: Re: 2.6.18-rc3-g3b445eea BUG: warning at
	/usr/src/linux-git/kernel/cpu.c:51/unlock_cpu_hotplug()
References: <6bffcb0e0608041204u4dad7cd6rab0abc3eca6747c0@mail.gmail.com>
 <Pine.LNX.4.64.0608041222400.5167@g5.osdl.org>
 <20060804222400.GC18792@redhat.com> <20060805003142.GH18792@redhat.com>
 <20060805021051.GA13393@redhat.com> <20060805022356.GC13393@redhat.com>
 <20060805024947.GE13393@redhat.com> <20060805064727.GF13393@redhat.com>
 <6bffcb0e0608060959m164436baj9c4c602496e87f5d@mail.gmail.com>
 <20060806123243.826105fc.akpm@osdl.org> <20060807012638.GA42404@muc.de>
In-Reply-To: <20060807012638.GA42404@muc.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>> It's a false-positive in this case - the backtrace was complete.  It would
>> be good if we could make the did-we-get-stuck detector a bit smarter.  Even
>> special-casing "sysenter_past_esp" would stop a lot of this..
>
>Actually it's not completely false in this case -- it should
>have reached user mode and stopped there, but for some reason
>I didn't and already stopped still in the kernel.
>
>Most likely the CFI annotation for that sysenter path is not complete.

Correct, the return point of sysexit (SYSENTER_RETURN) is still in kernel space,
but its annotations are invisible to the unwinder. We should make the VDSO be
treated as user-mode code despite living above PAGE_OFFSET.

>It's on my todo list to investigate but I still hope Jan does it first ;-)

I'll try to, once I've got through moving the Xen code from 2.6.16 to 2.6.18-rc3

Jan
