Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S290268AbSAXUtB>; Thu, 24 Jan 2002 15:49:01 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S290264AbSAXUsv>; Thu, 24 Jan 2002 15:48:51 -0500
Received: from holomorphy.com ([216.36.33.161]:55177 "EHLO holomorphy")
	by vger.kernel.org with ESMTP id <S290257AbSAXUsl>;
	Thu, 24 Jan 2002 15:48:41 -0500
Date: Thu, 24 Jan 2002 12:48:59 -0800
From: William Lee Irwin III <wli@holomorphy.com>
To: Denis Vlasenko <vda@port.imtp.ilyichevsk.odessa.ua>,
        "Martin J. Bligh" <Martin.Bligh@us.ibm.com>,
        Barry Wu <wqb123@yahoo.com>, linux-kernel@vger.kernel.org
Subject: Re: Can linux support ccNUMA machine now?
Message-ID: <20020124124859.E899@holomorphy.com>
Mail-Followup-To: William Lee Irwin III <wli@holomorphy.com>,
	Denis Vlasenko <vda@port.imtp.ilyichevsk.odessa.ua>,
	"Martin J. Bligh" <Martin.Bligh@us.ibm.com>,
	Barry Wu <wqb123@yahoo.com>, linux-kernel@vger.kernel.org
In-Reply-To: <20020123003530.60778.qmail@web13903.mail.yahoo.com> <74750000.1011782724@flay> <20020123200405.D899@holomorphy.com> <200201241215.g0OCFSE10537@Port.imtp.ilyichevsk.odessa.ua> <20020124105008.E872@holomorphy.com> <20020124121952.A763@lynx.adilger.int>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Description: brief message
Content-Disposition: inline
User-Agent: Mutt/1.3.17i
In-Reply-To: <20020124121952.A763@lynx.adilger.int>; from adilger@turbolabs.com on Thu, Jan 24, 2002 at 12:19:52PM -0700
Organization: The Domain of Holomorphy
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jan 24, 2002 at 02:15:30PM -0200, Denis Vlasenko wrote:
>>> Looks like running x86 with more than 16GB RAM is not a good idea.
>>> If you need it, you need 64bit arch.

On Thu, Jan 24, 2002 at 12:19:52PM -0700, Andreas Dilger wrote:
> Actually, Andrea made a patch to move the page tables into HIMEM on
> such machines.  I believe it is in the latest -aa patch.

That doesn't help boot-time allocations that go into ->zone_mem_map
and various other places, but it certainly helps runtime space
overhead on machines that have enough ZONE_NORMAL left to boot.
... and I don't believe it's in the kernel yet.

On Jan 24, 2002  10:50 -0800, William Lee Irwin III wrote:
>> Reducing overhead helps all boxen everywhere all the time. Turning the
>> kernel upside-down for the corner case of 64GB isn't worth it, but
>> finding more graceful ways to fail than not booting with no visible
>> error messages, and perhaps extending the range of configurations where
>> the kernel actually functions (within reason) by reducing space
>> overhead is worthwhile.

On Thu, Jan 24, 2002 at 12:19:52PM -0700, Andreas Dilger wrote:
> Yes, there also have been several patches floating around to reduce
> the size of struct page.  I don't think any are in the kernel yet.

Actually, I made a patch to eliminate ->virtual, another to eliminate
->zone, and another to eliminate ->wait. I believe they can be found in
revised forms in the latest -rmap patch, and the reduction in space
overhead is available for all machines, not just i386 machines where
there's so much physical memory the kernel can't use direct-mapped
virtual-to-physical translations for the kernel virtual address space.

I will take this as further prompting to push these things to mainline
and at long last kill the multiplicative hash in the waitqueue table.
Pagetables in highmem sound good for mainline too.

Cheers,
Bill

P.S.: ->zone came back as an unsigned char because putting it into the
->flags field looked ugly, but it still beats the heck out of a full word.
