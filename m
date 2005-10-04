Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964929AbVJDT1J@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964929AbVJDT1J (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 4 Oct 2005 15:27:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964931AbVJDT1J
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 4 Oct 2005 15:27:09 -0400
Received: from mx2.suse.de ([195.135.220.15]:44778 "EHLO mx2.suse.de")
	by vger.kernel.org with ESMTP id S964929AbVJDT1I (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 4 Oct 2005 15:27:08 -0400
From: Andi Kleen <ak@suse.de>
To: Tejun Heo <htejun@gmail.com>
Subject: Re: Question regarding x86_64 __PHYSICAL_MASK_SHIFT
Date: Tue, 4 Oct 2005 21:27:20 +0200
User-Agent: KMail/1.8.2
Cc: lkml <linux-kernel@vger.kernel.org>, discuss@x86-64.org
References: <43426EB4.6080703@gmail.com> <200510042101.44946.ak@suse.de> <4342D5A5.2080902@gmail.com>
In-Reply-To: <4342D5A5.2080902@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200510042127.21238.ak@suse.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tuesday 04 October 2005 21:19, Tejun Heo wrote:

>   Hmmm.. but, currently
>
> * PHYSICAL_PAGE_MASK == (~(PAGE_SIZE-1)&(__PHYSICAL_MASK << PAGE_SHIFT)
> 	== (0xffffffff_fffff000 & (0x00003fff_ffffffff << 12)
>   	== 0x03ffffff_fffff000
>   while it actually should be 0x00003fff_fffff000

Right. Fixed now

> * PTE_FILE_MAX_BITS == __PHYSICAL_MASK_SHIFT == 46, but only 40bits are
> available in page table entries.

The non linear mapping format is independent from the MMU, the number
is pretty much arbitary, but it is consistent to make it the same as
other ptes for easier sanity checking.

-Andi
