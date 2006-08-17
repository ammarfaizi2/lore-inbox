Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964805AbWHQLWu@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964805AbWHQLWu (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 17 Aug 2006 07:22:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964811AbWHQLWu
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 17 Aug 2006 07:22:50 -0400
Received: from ev1s-67-15-60-3.ev1servers.net ([67.15.60.3]:20384 "EHLO
	mail.aftek.com") by vger.kernel.org with ESMTP id S964805AbWHQLWt
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 17 Aug 2006 07:22:49 -0400
X-Antivirus-MYDOMAIN-Mail-From: abum@aftek.com via plain.ev1servers.net
X-Antivirus-MYDOMAIN: 1.22-st-qms (Clear:RC:0(203.129.230.146):SA:0(-102.5/1.7):. Processed in 2.18133 secs Process 26947)
From: "Abu M. Muttalib" <abum@aftek.com>
To: "Arjan van de Ven" <arjan@infradead.org>
Cc: <kernelnewbies@nl.linux.org>, <linux-newbie@vger.kernel.org>,
       <linux-kernel@vger.kernel.org>, "linux-mm" <linux-mm@kvack.org>
Subject: RE: Relation between free() and remove_vm_struct()
Date: Thu, 17 Aug 2006 16:57:16 +0530
Message-ID: <BKEKJNIHLJDCFGDBOHGMEEFBDGAA.abum@aftek.com>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
X-Priority: 3 (Normal)
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook IMO, Build 9.0.2416 (9.0.2910.0)
In-Reply-To: <1155811716.4494.51.camel@laptopd505.fenrus.org>
X-MimeOLE: Produced By Microsoft MimeOLE V5.50.4927.1200
Importance: Normal
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

> > > second of all, glibc delays freeing of some memory (in the brk() area)
> > > to optimize for cases of frequent malloc/free operations, so that it
> > > doesn't have to go to the kernel all the time (and a free would imply
a
> > > cross cpu TLB invalidate which is *expensive*, so batching those up is
a
> > > really good thing for performance)
> >
> > As per my observation, in two scenarios that I have tried, in one
scenario I
> > am able to see the prints from remove_vm_struct(), but in the other
> > scenario, I don't see any prints from remove_vm_strcut().
> >
> > My question is, if there is delayed freeing of virtual address space, it
> > should be the same in both the scenarios, but its not the case, and this
> > behavior is consistent for my two scenarios, i.e.. in one I am able to
see
> > the kernel prints and in other I am not, respectively.
>
> I'm sorry but you're not providing enough information for me to
> understand your follow-on question.

Well, the application, which is causing problem is specific to our
organization and details may not be known to the list. Any ways I am
detailing it further,

Our application is a VoIP application, which uses OSIP stack.

While running the application, when I give outgoing call, I see the VM
getting allocated and subsequently getting freed, this I have verified from
/proc/meminfo and kernel prints (that of remove_vm_struct). But in the case
of incoming call, though this is a reverse case, but I see memory only
getting allocated and not being freed.

I can see in the code that the free function is called but the call has not
been propagated to the kernel. The allocation is in the tune of 4 MB, so the
memory must have been allocated using mmap and not brk, as the heap size for
an application is defined to be 4 K, as per my knowledge. Even if the
allocation is from heap, the heap should get enlarged and on subsequent call
to free, the surplus space should be returned to OS.

Please help.

Regards,
Abu.


