Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262936AbVA2Q1w@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262936AbVA2Q1w (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 29 Jan 2005 11:27:52 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262937AbVA2Q1w
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 29 Jan 2005 11:27:52 -0500
Received: from a26.t1.student.liu.se ([130.236.221.26]:30175 "EHLO
	mail.drzeus.cx") by vger.kernel.org with ESMTP id S262936AbVA2Q1t
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 29 Jan 2005 11:27:49 -0500
Message-ID: <41FBB982.10608@drzeus.cx>
Date: Sat, 29 Jan 2005 17:27:46 +0100
From: Pierre Ossman <drzeus-list@drzeus.cx>
User-Agent: Mozilla Thunderbird 0.9 (X11/20041127)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Christoph Hellwig <hch@infradead.org>
CC: Geert Uytterhoeven <geert@linux-m68k.org>,
       LKML <linux-kernel@vger.kernel.org>, wbsd-devel@list.drzeus.cx
Subject: Re: [Wbsd-devel] [PATCH 540] MMC_WBSD depends on ISA
References: <200501072250.j07MonUe012310@anakin.of.borg> <41E22B4F.4090402@drzeus.cx> <41FB91A3.7060404@drzeus.cx> <20050129135714.GA320@infradead.org> <20050129145417.A12311@flint.arm.linux.org.uk> <20050129150023.GA959@infradead.org> <41FBAC44.9020502@drzeus.cx> <20050129155722.GA1320@infradead.org> <41FBB500.80805@drzeus.cx> <20050129161325.GA1834@infradead.org>
In-Reply-To: <20050129161325.GA1834@infradead.org>
X-Enigmail-Version: 0.89.0.0
X-Enigmail-Supports: pgp-inline, pgp-mime
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Christoph Hellwig wrote:

>On Sat, Jan 29, 2005 at 05:08:32PM +0100, Pierre Ossman wrote:
>  
>
>>For i386 and x86_64 it's defined as virt_to_phys in asm/io.h without any 
>>#ifdef:s protecting it.
>>    
>>
>
>Not all the world is a PC
>
>  
>
Then the dependency should in that case be on architectures. It is 
connected similar to a floppy (which is not dependent on ISA and uses 
isa_virt_to_bus).

The point is that isa_virt_to_bus() is the method used by devices 
connected in the same way. This works on the platforms where the device 
can be found (i386 and x86_64). We can not make it dependent on ISA 
since you cannot enable ISA on all platforms where it exists (i.e. 
x86_64). Either fix that or make the driver depend on architecture the 
same way floppy does.

Using the generic DMA API might be a viable option now that x86_64 seems 
to be fixed. But it doesn't have a good track record so I'm not prepared 
to commit any changes until I have time to properly test it. There might 
still be assumptions about PCI lurking around.

Rgds
Pierre
