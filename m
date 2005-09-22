Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030436AbVIVQhK@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030436AbVIVQhK (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 22 Sep 2005 12:37:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030438AbVIVQhK
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 22 Sep 2005 12:37:10 -0400
Received: from prgy-npn1.prodigy.com ([207.115.54.37]:34832 "EHLO
	oddball.prodigy.com") by vger.kernel.org with ESMTP
	id S1030436AbVIVQhJ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 22 Sep 2005 12:37:09 -0400
Message-ID: <4332DDA7.4080901@tmr.com>
Date: Thu, 22 Sep 2005 12:36:55 -0400
From: Bill Davidsen <davidsen@tmr.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.11) Gecko/20050729
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: David Sanchez <david.sanchez@lexbox.fr>
CC: Jeff Garzik <jgarzik@pobox.com>, linux-kernel@vger.kernel.org
Subject: Re: How to Force PIO mode on sata promise (Linux 2.6.10)
References: <17AB476A04B7C842887E0EB1F268111E026FBD@xpserver.intra.lexbox.org>
In-Reply-To: <17AB476A04B7C842887E0EB1F268111E026FBD@xpserver.intra.lexbox.org>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

David Sanchez wrote:
> Hi Chris,
> It was a good idea but it doesn't resolve the problem...
> 
> I add my card into the dma_black_list of the libata to force DMA disabled and the problem seems to no more appear...maybe PIO is so slow that the data has no time to be corrupted...
> But I can NOT affirm that the problem is the DMA. 
> 
> I try the linux kernel 2.4,2.6.11, 2.6.12 and 2.6.13. More I try 2 different toolchains and the problem persists...
> 
> Another idea??

You disable DMA and the problem goes away, that seems to point to DMA as 
the problem, and since others aren't having the same problem with the 
DMA code in the kernel it certainly suggests the DMA hardware really is 
the problem, or is causing it. It's remotely possible that the kernel 
has a bug in the code just for your controller, although unlikely.

Have you run memtest86 on your memory? I have seen cases where memory 
was marginal and using CPU and DMA was enough to cause it to fail, but 
only when people had played with the memory timing in the BIOS. I 
suspect the SATA disk has a higher datarate than anything else in your 
system, so it could trigger some marginal cases in the memory system. 
Unlikely, but possible.

ideas:
   test your memory if you haven't
   Check that your BIOS is up-to-date
   check your BIOS memory timing settings
   See if the controller came with tools to adjust DMA timing
   try writing to a PATA drive while reading from the SATA
     to generate high DMA rate, look for corruption there
   try another controller of the same type
   try another controler of another supported type
     to see that it's not your drive
   accept that your controller *belongs* on the blacklist

Since you asked for ideas, these are probably in order of easy to difficult.

-- 
    -bill davidsen (davidsen@tmr.com)
"The secret to procrastination is to put things off until the
  last possible moment - but no longer"  -me
