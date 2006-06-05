Return-Path: <linux-kernel-owner+akpm=40zip.com.au-S1751348AbWFET5y@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751348AbWFET5y (ORCPT <rfc822;akpm@zip.com.au>);
	Mon, 5 Jun 2006 15:57:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751349AbWFET5y
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 5 Jun 2006 15:57:54 -0400
Received: from xenotime.net ([66.160.160.81]:14290 "HELO xenotime.net")
	by vger.kernel.org with SMTP id S1751348AbWFET5y (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 5 Jun 2006 15:57:54 -0400
Date: Mon, 5 Jun 2006 13:00:39 -0700
From: "Randy.Dunlap" <rdunlap@xenotime.net>
To: Ingo Molnar <mingo@elte.hu>
Cc: mbligh@google.com, akpm@osdl.org, apw@shadowen.org,
        linux-kernel@vger.kernel.org
Subject: Re: 2.6.17-rc5-mm3
Message-Id: <20060605130039.db1ac80c.rdunlap@xenotime.net>
In-Reply-To: <20060605194422.GB14709@elte.hu>
References: <44845C27.3000006@google.com>
	<20060605194422.GB14709@elte.hu>
Organization: YPO4
X-Mailer: Sylpheed version 2.2.5 (GTK+ 2.8.3; x86_64-unknown-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 5 Jun 2006 21:44:22 +0200 Ingo Molnar wrote:

> 
> * Martin Bligh <mbligh@google.com> wrote:
> 
> > panic on NUMA-Q during LTP. Was fine in -mm2.
> > 
> > BUG: unable to handle kernel paging request at virtual address 22222232
> 
> > EIP is at check_deadlock+0x19/0xe1
> > eax: 00000001   ebx: e4453030   ecx: 00000000   edx: e4008000
> > esi: 22222222   edi: 00000001   ebp: 22222222   esp: e47ebec0
> 
> again these 0x22222222 entries on the stack. What on earth does this? 
> Andy got a similar crash on x86_64, with a 0x2222222222222222 entry ...
> 
> nothing of our magic values are 0x22 or 0x222222222.

kernel/mutex-debug.c:
void debug_mutex_free_waiter(struct mutex_waiter *waiter)
{
	DEBUG_WARN_ON(!list_empty(&waiter->list));
	memset(waiter, 0x22, sizeof(*waiter));
}

---
~Randy
