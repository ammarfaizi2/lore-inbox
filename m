Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964935AbWHNVVL@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964935AbWHNVVL (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 14 Aug 2006 17:21:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964936AbWHNVVK
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 14 Aug 2006 17:21:10 -0400
Received: from mx1.redhat.com ([66.187.233.31]:63197 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S964935AbWHNVVI (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 14 Aug 2006 17:21:08 -0400
Date: Mon, 14 Aug 2006 17:20:22 -0400
From: Dave Jones <davej@redhat.com>
To: Michal Piotrowski <michal.k.k.piotrowski@gmail.com>
Cc: john stultz <johnstul@us.ibm.com>, Andrew Morton <akpm@osdl.org>,
       linux-kernel@vger.kernel.org, Thomas Gleixner <tglx@linutronix.de>,
       Ingo Molnar <mingo@elte.hu>, Dinakar Guniguntala <dino@in.ibm.com>
Subject: Re: 2.6.18-rc4-mm1
Message-ID: <20060814212022.GB30814@redhat.com>
Mail-Followup-To: Dave Jones <davej@redhat.com>,
	Michal Piotrowski <michal.k.k.piotrowski@gmail.com>,
	john stultz <johnstul@us.ibm.com>, Andrew Morton <akpm@osdl.org>,
	linux-kernel@vger.kernel.org, Thomas Gleixner <tglx@linutronix.de>,
	Ingo Molnar <mingo@elte.hu>, Dinakar Guniguntala <dino@in.ibm.com>
References: <20060813012454.f1d52189.akpm@osdl.org> <6bffcb0e0608140702i70fb82ffr99a3ad6fdfbfd55e@mail.gmail.com> <20060814111914.b50f9b30.akpm@osdl.org> <44E0C889.3020706@gmail.com> <1155583256.5413.42.camel@localhost.localdomain> <6bffcb0e0608141227i2c4c48b6w8e18165ac406862@mail.gmail.com> <1155584697.5413.51.camel@localhost.localdomain> <44E0E1BA.3000204@gmail.com> <20060814205637.GA30814@redhat.com> <6bffcb0e0608141413u122c2a31scb3e170a776cec2b@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <6bffcb0e0608141413u122c2a31scb3e170a776cec2b@mail.gmail.com>
User-Agent: Mutt/1.4.2.2i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Aug 14, 2006 at 11:13:14PM +0200, Michal Piotrowski wrote:
 > On 14/08/06, Dave Jones <davej@redhat.com> wrote:
 > >  > Aug 14 22:30:09 ltg01-fedora kernel: general protection fault: 0000 [#1]
 > >  > Aug 14 22:30:09 ltg01-fedora kernel: 4K_STACKS PREEMPT SMP
 > >  > Aug 14 22:30:09 ltg01-fedora kernel: last sysfs file: /devices/platform/i2c-9191/9191-0290/temp2_input
 > >  > Aug 14 22:30:09 ltg01-fedora kernel: CPU:    0
 > >  > Aug 14 22:30:09 ltg01-fedora kernel: EIP:    0060:[<c0205249>]    Not tainted VLI
 > >  > Aug 14 22:30:09 ltg01-fedora kernel: EFLAGS: 00010246   (2.6.18-rc4-mm1 #101)
 > >  > Aug 14 22:30:09 ltg01-fedora kernel: EIP is at __list_add+0x3d/0x7a
 > >  > Aug 14 22:30:09 ltg01-fedora kernel: eax: 00000000   ebx: c0670a80   ecx: c038d4dc   edx: 00000000
 > >  > Aug 14 22:30:09 ltg01-fedora kernel: esi: ffffffff   edi: f50ebee8   ebp: f50ebed0   esp: f50ebec4
 > >
 > > __list_add will still be dereferencing prev->next, so you should see exactly
 > > the same gpf. Note that you're not triggering the BUG()'s here, you're hitting
 > > some other fault just walking the list.
 > 
 > How can I debug this?

Not sure. I'm somewhat puzzled.
Disassembling the Code: of your oops shows that we were trying to dereference esi,
which was -1 for some bizarre reason.  (my objdump really hated disassembling that
function, but I think thats my tools rather than breakage in the oops).

Question is how did that list member get to be -1 ?
One pie-in-the-sky possibility is that we've corrupted memory recently, and
this link-list manipulation just stumbled across it.  Note that the last file
opened before we blew up was reading i2c.  Can you try and reproduce this
(if you can reproduce it at all) without the sensors stuff loaded ?

It's a long-shot, but without further clues, I'm stabbing in the dark.

		Dave

-- 
http://www.codemonkey.org.uk
