Return-Path: <linux-kernel-owner+willy=40w.ods.org-S265003AbUELLFl@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265003AbUELLFl (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 12 May 2004 07:05:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265002AbUELLFk
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 12 May 2004 07:05:40 -0400
Received: from ecbull20.frec.bull.fr ([129.183.4.3]:43716 "EHLO
	ecbull20.frec.bull.fr") by vger.kernel.org with ESMTP
	id S263544AbUELLFg (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 12 May 2004 07:05:36 -0400
Message-ID: <40A2054B.21EDE518@nospam.org>
Date: Wed, 12 May 2004 13:06:51 +0200
From: Zoltan Menyhart <Zoltan.Menyhart_AT_bull.net@nospam.org>
Reply-To: Zoltan.Menyhart@bull.net
Organization: Bull S.A.
X-Mailer: Mozilla 4.78 [en] (X11; U; AIX 4.3)
X-Accept-Language: fr, en
MIME-Version: 1.0
To: "Luck, Tony" <tony.luck@intel.com>
CC: Zoltan.Menyhart@bull.net, linux-ia64@vger.kernel.org,
       linux-kernel@vger.kernel.org
Subject: Re: Who owns those locks ?
References: <B8E391BBE9FE384DAA4C5C003888BE6F013CCAED@scsmsx401.sc.intel.com>
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

"Luck, Tony" wrote:
> 
> >The current task pointers are identity mapped memory addresses.
> >I shift them to the right by 12 bits (these bits are always 0-s).
> >In that way, addresses up to 16 Tbytes can fit into the lock word.
> 
> Neat trick.  Will work for most people ... but watch out if you
> have an architecture that has sparse physical address space and
> can thus potentially allocate a task structure on a 16TB boundary.
> 
> At first I thought SGI Altix could be hurt by this, but they are
> saved by the fact that bits [37:36] are always set to one.
> 
> I know of at least one 1TB machine now, so 16TB machines are only
> a few years away.  You could stretch the life of this patch by
> using PAGE_SHIFT, rather than 12 (as practically nobody builds
> kernels with a 4k pagesize, especially not on monster machines).
> 
> Or perhaps just fix the allocation of task structures to skip
> around the 16TB aligned ones?
> 
> -Tony

The first reason to use a shift of 12 bits is:
you can see easily what the address of the owner's task structure is.
In addition, with page size of 16 Kbytes, you've got only 16 Tbytes
in the identity mapped kernel address space any way.
Should we move to a page size of 64 Kbytes, you can use a shift of
16 bits and you keep the address human readable ;-)

Thanks,

Zoltán
