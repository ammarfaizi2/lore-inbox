Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261282AbVFNHZS@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261282AbVFNHZS (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 14 Jun 2005 03:25:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261294AbVFNHZS
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 14 Jun 2005 03:25:18 -0400
Received: from web33303.mail.mud.yahoo.com ([68.142.206.118]:46500 "HELO
	web33303.mail.mud.yahoo.com") by vger.kernel.org with SMTP
	id S261282AbVFNHZG (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 14 Jun 2005 03:25:06 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
  s=s1024; d=yahoo.com;
  h=Message-ID:Received:Date:From:Subject:To:Cc:In-Reply-To:MIME-Version:Content-Type:Content-Transfer-Encoding;
  b=gyIT8vhCHehsegNYQAFkRwwlxpFFQq74dny0FnPf5muaQlkJjiTDIWAbyAxaAwbl2MYWf9V8igl+XgTH2+wFDB/P7qfQ/iA7NVEgh9awxPaWiyUCZOrQ6l3uPZoVLEvoObLezE07Tm4EYYDZfZH+Rrifd8jyNywv5g3UcWmAckU=  ;
Message-ID: <20050614072501.2768.qmail@web33303.mail.mud.yahoo.com>
Date: Tue, 14 Jun 2005 00:25:01 -0700 (PDT)
From: li nux <lnxluv@yahoo.com>
Subject: Re: rmap.c: try_to_unmap_file(): VM_LOCKED not respected
To: William Lee Irwin III <wli@holomorphy.com>
Cc: linux <linux-kernel@vger.kernel.org>
In-Reply-To: <20050614063150.GI3879@holomorphy.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--- William Lee Irwin III <wli@holomorphy.com> wrote:

> On Mon, Jun 13, 2005 at 10:48:13PM -0700, li nux
> wrote:
> > I first use mmap(MAP_LOCKED) and then
> > remap_file_pages.
> > This should set VM_LOCKED in the vma.
> 
> This is very odd. Could you get a backtrace with
> code addresses resolved
> to line numbers?
> 
> When you get backtraces, it should show program
> counters (EIP's on i386,
> RIP's on x86-64, other names on others). If you
> compile with debugging
> symbols and keep the vmlinux, you can use addr2line
> to resolve them to
> addresses. Hopefully this is enough for you to go
> on.
> 
> If you can provide this information, it would be
> very helpful wrt.
> resolving your issue.
> 
> Thanks.
> -- wli

Thanks a lot wli.
Sorry, I dont have that machine where i reproduced
this problem. Stack trace (in my first mail) is the
only info that I have with me. There is no other
application running on the system which uses
remap_file_pages (non-linear vma)

Coming to my original question. when I do
mmap(MAP_LOCKED) VM_LOCKED gets set for the vma.
who sets VM_RESERVED, does this flag has to do
anything when VM_LOCKED is already set ?

   do {
 list_for_each_entry(vma, &mapping->i_mmap_nonlinear,
                                                
shared.vm_set.list) {
     if (vma->vm_flags & (VM_LOCKED|VM_RESERVED))
              continue;
    cursor = (unsigned long) vma->vm_private_data;
while (vma->vm_mm->rss &&
cursor < max_nl_cursor &&                             
   cursor < vma->vm_end - vma->vm_start) {
                                
try_to_unmap_cluster(cursor, &mapcount, vma);
        cursor += CLUSTER_SIZE;
}
.....<snip>
   } while (max_nl_cursor <= max_nl_size);




		
__________________________________ 
Discover Yahoo! 
Use Yahoo! to plan a weekend, have fun online and more. Check it out! 
http://discover.yahoo.com/
