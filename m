Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262929AbTIRBNQ (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 17 Sep 2003 21:13:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262930AbTIRBNP
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 17 Sep 2003 21:13:15 -0400
Received: from dsl092-233-042.phl1.dsl.speakeasy.net ([66.92.233.42]:27039
	"EHLO whisper.qrpff.net") by vger.kernel.org with ESMTP
	id S262929AbTIRBNN (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 17 Sep 2003 21:13:13 -0400
X-All-Your-Base: Are Belong To Us!!!
X-Envelope-Recipient: linux-kernel@vger.kernel.org
X-Envelope-Sender: oliver@klozoff.com
Message-ID: <3F6905FE.5030106@klozoff.com>
Date: Wed, 17 Sep 2003 21:10:22 -0400
From: Stevie-O <oliver@klozoff.com>
User-Agent: Mozilla/5.0 (Windows; U; Windows NT 5.0; en-US; rv:1.5b) Gecko/20030827
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
CC: Petr Vandrovec <VANDROVE@vc.cvut.cz>
Subject: Re: Aliasing physical memory using virtual memory (from a d
References: <80BC15566D@vcnet.vc.cvut.cz> <3F68FEEC.5020809@klozoff.com>
In-Reply-To: <3F68FEEC.5020809@klozoff.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Stevie-O wrote:

> 
> I grepped my 2.4 kernel source for 'vmap' and the only results that 
> seemed meaningful were vmap_pte_range or vmap_pmd_range in 
> mips/mm/umap.c and mips64/mm/umap.c. Is this documented somewhere? I 
> suffer from the 'i'm new at this, but this looks possible' syndrome. I 
> don't actually know how anything is accomplished.
> 
> Btw, am I right about kmalloc(35000) effectively grabbing 64K?

I did a freetext search of the LXR for 'remap' and came up with this function:

820 /*
821  * maps a range of physical memory into the requested pages. the old
822  * mappings are removed. any references to nonexistent pages results
823  * in null mappings (currently treated as "copy-on-access")
824  */
825 static inline void remap_pte_range(pte_t * pte, unsigned long address, 
unsigned long size,
826         unsigned long phys_addr, pgprot_t prot)

This looks promising, although it's a bit ambiguous to me.  Treating the 
physical pages as distinct from virtual pages:

[1] maps a range of physical memory onto the requested pages
I assume 'the requested pages' here refer to 'the specified virtual pages', 
since the statement makes no sense if it's referring to 'the specified physical 
pages'.

[2] the old mappings are removed.
Looking at the source, it seems that this means 'if these virtual pages were 
pointed to any physical pages before, they won't be anymore'

[3] any references to nonexistent pages results in null mappings ('copy-on-access')
I have no idea what this means, and I can't figure it out reading the code.
Obviously it refers to something not really being there (thus 'nonexistent'). So 
copy-on-access? How do you copy something that doesn't exist?

-- 
- Stevie-O

Real Programmers use COPY CON PROGRAM.EXE

