Return-Path: <linux-kernel-owner+akpm=40zip.com.au-S1751395AbWFEUGO@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751395AbWFEUGO (ORCPT <rfc822;akpm@zip.com.au>);
	Mon, 5 Jun 2006 16:06:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751397AbWFEUGO
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 5 Jun 2006 16:06:14 -0400
Received: from mx1.redhat.com ([66.187.233.31]:25016 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S1751395AbWFEUGM (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 5 Jun 2006 16:06:12 -0400
Date: Mon, 5 Jun 2006 16:05:54 -0400
From: Dave Jones <davej@redhat.com>
To: "Randy.Dunlap" <rdunlap@xenotime.net>
Cc: Ingo Molnar <mingo@elte.hu>, mbligh@google.com, akpm@osdl.org,
        apw@shadowen.org, linux-kernel@vger.kernel.org
Subject: Re: 2.6.17-rc5-mm3
Message-ID: <20060605200554.GB6143@redhat.com>
Mail-Followup-To: Dave Jones <davej@redhat.com>,
	"Randy.Dunlap" <rdunlap@xenotime.net>, Ingo Molnar <mingo@elte.hu>,
	mbligh@google.com, akpm@osdl.org, apw@shadowen.org,
	linux-kernel@vger.kernel.org
References: <44845C27.3000006@google.com> <20060605194422.GB14709@elte.hu> <20060605130039.db1ac80c.rdunlap@xenotime.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060605130039.db1ac80c.rdunlap@xenotime.net>
User-Agent: Mutt/1.4.2.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jun 05, 2006 at 01:00:39PM -0700, Randy.Dunlap wrote:
 > On Mon, 5 Jun 2006 21:44:22 +0200 Ingo Molnar wrote:
 > 
 > > 
 > > * Martin Bligh <mbligh@google.com> wrote:
 > > 
 > > > panic on NUMA-Q during LTP. Was fine in -mm2.
 > > > 
 > > > BUG: unable to handle kernel paging request at virtual address 22222232
 > > 
 > > > EIP is at check_deadlock+0x19/0xe1
 > > > eax: 00000001   ebx: e4453030   ecx: 00000000   edx: e4008000
 > > > esi: 22222222   edi: 00000001   ebp: 22222222   esp: e47ebec0
 > > 
 > > again these 0x22222222 entries on the stack. What on earth does this? 
 > > Andy got a similar crash on x86_64, with a 0x2222222222222222 entry ...
 > > 
 > > nothing of our magic values are 0x22 or 0x222222222.
 > 
 > kernel/mutex-debug.c:
 > void debug_mutex_free_waiter(struct mutex_waiter *waiter)
 > {
 > 	DEBUG_WARN_ON(!list_empty(&waiter->list));
 > 	memset(waiter, 0x22, sizeof(*waiter));
 > }

Documentation/magic-number.txt sounds so promising, but we scatter definitions
of numbers all over the place. (No mention of the slab poison values,
or similar numbers there for eg, and various pointers to _other_ lists
of magic numbers).

		Dave

-- 
http://www.codemonkey.org.uk
