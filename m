Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262315AbVBQTtf@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262315AbVBQTtf (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 17 Feb 2005 14:49:35 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262071AbVBQTte
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 17 Feb 2005 14:49:34 -0500
Received: from ebiederm.dsl.xmission.com ([166.70.28.69]:24242 "EHLO
	ebiederm.dsl.xmission.com") by vger.kernel.org with ESMTP
	id S261159AbVBQTst (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 17 Feb 2005 14:48:49 -0500
To: Dave Jones <davej@redhat.com>
Cc: Itsuro Oda <oda@valinux.co.jp>, fastboot <fastboot@lists.osdl.org>,
       lkml <linux-kernel@vger.kernel.org>
Subject: Re: [Fastboot] Re: [PATCH] /proc/cpumem
References: <20050203154433.18E4.ODA@valinux.co.jp>
	<m14qgu81bw.fsf@ebiederm.dsl.xmission.com>
	<20050216170224.4C66.ODA@valinux.co.jp>
	<20050217181850.GE21623@redhat.com>
From: ebiederm@xmission.com (Eric W. Biederman)
Date: 17 Feb 2005 12:46:05 -0700
In-Reply-To: <20050217181850.GE21623@redhat.com>
Message-ID: <m1wtt755s2.fsf@ebiederm.dsl.xmission.com>
User-Agent: Gnus/5.0808 (Gnus v5.8.8) Emacs/21.2
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Dave Jones <davej@redhat.com> writes:

> On Wed, Feb 16, 2005 at 05:49:51PM +0900, Itsuro Oda wrote:
>  > Hi, Eric and all
>  > 
>  > Attached is an implementation of /proc/cpumem.
>  > /proc/cpumem shows the valid physical memory ranges.
>  > 
>  > * i386 and x86_64
>  > * implement valid_phys_addr_range() and use it.
>  >   (the first argument of the i386 version is little uncomfortable.)
>  > * /dev/mem of the i386 version should be mofified. but not yet.
>  > 
>  > example: amd64 8GB Mem
>  > # cat /proc/cpumem
>  > 0000000000000000 000000000009b800
>  > 0000000000100000 00000000fbe70000
>  > 0000000100000000 0000000100000000
>  > #
>  > start address and size. hex digit.
>  > 
>  > Any comments, recomendations and suggestions are welcom.
> 
> It may make more sense to export the entire e820 (or similar)
> bios memory tables. Probably better off in sysfs than adding
> more cruft to procfs too.

Agreed.  In practice we actually do this already with /proc/iomem.  
Except that we truncate everything above 4GB, and we allow the
map to get mangled with mem=xxx options.

I brought up the idea of a /proc/cpumem by analogy because on platforms
that have an iommu and memory is in a distinct address space 
there have been complaints that /proc/iomem just won't work.  But it
is simple enough to do something that is just for the cpu's memory.

As for how to do this cleanly this looks like the start of that discussion.

Eric
